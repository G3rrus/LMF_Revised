// AI VEHICLE QRF /////////////////////////////////////////////////////////////////////////////////
/*
	* Author: nkenny, G4rrus, Alex2k
	* Spawn AI vehicle with crew(s) and make them behave as QRF.
	* Note: Needs to be called on the Server or a HC.
	*
	* Arguments:
	* 0: Spawn Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	* 1: Type <STRING> supported types are: "CAR", "CARARMED", "TRUCK", "APC", "TANK", "HELITRANSPORT" and "HELIATTACK"
	* 2: Tickets <NUMBER> values higher than 1 enable spawn proximity check
	* 3: Respawn delay after death <NUMBER>
	*
	* Example:
	* [player, "CAR", 1, 300] spawn lmf_ai_fnc_vehicleQRF;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if (hasInterface && {!isServer}) exitWith {};
waitUntil {CBA_missionTime > 0};

params [
    ["_spawnPos",objNull,[objNull,grpNull,"",locationNull,taskNull,[],123]],
    ["_vicType","TRUCK",[""]],
    ["_tickets",1,[123]],
    ["_respawnTime",300,[123]]
];

private _dir = random 360;
if ((typeName _spawnPos) isEqualTo "OBJECT") then {
	_dir = getDir _spawnPos;
};
if ((typeName _spawnPos) isEqualTo "STRING") then {
	_dir = markerDir _spawnPos;
};

_spawnPos = _spawnPos call CBA_fnc_getPos;
if (_spawnPos isEqualTo  [0,0,0]) exitWith {};

private _range = 1000;
private _initTickets = _tickets;
private _doSpawn = 0;
_vicType = toUpper _vicType;


// PREPARE AND SPAWN //////////////////////////////////////////////////////////////////////////////
while {_initTickets > 0} do {

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE
	if (_tickets > 1) then {
		//WAIT UNTIL PROXIMTY IS FINE OR HAS BEEN BREACHED BY GROUND
		waitUntil {sleep 5; _doSpawn = [_spawnPos,_range] call lmf_ai_fnc_proxyCheck; !(_doSpawn isEqualTo 1)};
	};
	if (_doSpawn isEqualTo 2) exitWith {};

    //IF PROXIMITY IS FINE
    private _type = [_vicType] call lmf_ai_fnc_makeType;
    private _veh = createVehicle [_type, _spawnPos, [], 0, "CAN_COLLIDE"];;
    _veh setDir _dir;

    //CREW
    private _type = switch (_vicType) do {
		case "CAR": {"TEAM"};
		case "CARARMED": {"SENTRY"};
		case "TRUCK": {"SQUAD"};
		case "APC": {"CREW"};
		case "TANK": {"CREW"};
		case "HELITRANSPORT": {"HCREW"};
		case "HELIATTACK": {"HCREW"};
    };
    _type = [_type] call lmf_ai_fnc_makeType;
    private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
    _grp deleteGroupWhenEmpty true;
    _grp addVehicle _veh;
    {_x moveInAny _veh} forEach units _grp;

    //PASSENGERS FOR APC AND TRANSPORT HELO
    private _grp2 = grpNull;
    if (_vicType isEqualTo "APC" || _vicType isEqualTo "HELITRANSPORT") then {
        private _type = ["SQUAD"] call lmf_ai_fnc_makeType;
        _grp2 = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp2 deleteGroupWhenEmpty true;
        {_x moveInCargo _veh} forEach units _grp2;
    };

    //TASKS
    [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    _grp setBehaviour "AWARE";

    //CAR AND TRUCK SPECIFICS
    if (_vicType isEqualTo "CAR" || _vicType isEqualTo "TRUCK") then {
        waitUntil {sleep 5; (leader _grp) call BIS_fnc_enemyDetected || {{alive _x} count units _grp < 1 || {!alive _veh}}};
        if (isClass (configfile >> "CfgPatches" >> "lambs_wp")) then {
            if !(isNull objectParent leader _grp) then {
                {deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
                private _wp1 =_grp addWaypoint [getPos leader _grp, 0];
                _wp1 setWaypointType "GETOUT";
                private _wp2 =_grp addWaypoint [getPos leader _grp, 0];
                _wp2 setWaypointType "GUARD";
            };
            [_grp,150,30] spawn lambs_wp_fnc_taskRush;
        } else {
            [_grp] spawn lmf_ai_fnc_taskAssault;
        };
    };

    //APC
    if (_vicType isEqualTo "APC") then {
        waitUntil {sleep 5; (leader _grp) call BIS_fnc_enemyDetected || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        waitUntil {sleep 3; !(position _veh isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);};
        doStop driver _veh;
        doGetOut units _grp2;
        _grp2 leaveVehicle _veh;
        waitUntil {sleep 2; speed _veh > 0 || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        private _wp = _grp2 addWaypoint [getPos _veh,0];
        _wp setWaypointType "GUARD";
        if (isClass (configfile >> "CfgPatches" >> "lambs_wp")) then {
            [_grp2,150,30] spawn lambs_wp_fnc_taskRush;
        } else {
            [_grp2] spawn lmf_ai_fnc_taskAssault;
        };
        sleep 15;
        {_x doFollow leader _grp} forEach units _grp;
    };

    //HELITRANSPORT
    if (_vicType isEqualTo "HELITRANSPORT") then {
        waitUntil {sleep 5; (leader _grp) call BIS_fnc_enemyDetected || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        doGetOut units _grp2;
        _grp2 leaveVehicle _veh;
        waitUntil {sleep 1; isTouchingGround _veh || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        private _wp = _grp2 addWaypoint [getPos _veh,0];
        _wp setWaypointType "GUARD";
        if (isClass (configfile >> "CfgPatches" >> "lambs_wp")) then {
            [_grp2,150,30] spawn lambs_wp_fnc_taskRush;
        } else {
            [_grp2] spawn lmf_ai_fnc_taskAssault;
        };
    };

	//SUBTRACT TICKET
	_initTickets = _initTickets - 1;

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE AND ITS NOT THE LAST CYCLE
	if (_tickets > 1 && {_initTickets > 0}) then {
		//WAIT UNTIL EVERYONE DEAD OR GROUND PROXIMITY BREACH
		waitUntil {sleep 15; [_spawnPos,_range] call lmf_ai_fnc_proxyCheck isEqualTo 2 || {!alive _veh || {{alive _x} count units _grp < 1}}};
	};
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////