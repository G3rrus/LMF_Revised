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

#include "cfg_spawn.sqf"

params [
    ["_spawnPos",objNull,[objNull,grpNull,"",locationNull,taskNull,[],123]],
    ["_vicType","TRUCK",[""]],
    ["_tickets",1,[123]],
    ["_respawnTime",300,[123]]
];

private _range = 1000;

private _dir = random 360;
if ((typeName _spawnPos) isEqualTo "OBJECT") then {
	_dir = getDir _spawnPos;
};
if ((typeName _spawnPos) isEqualTo "STRING") then {
	_dir = markerDir _spawnPos;
};

_spawnPos = _spawnPos call CBA_fnc_getPos;
if (_spawnPos isEqualTo  [0,0,0]) exitWith {};

toUpper _vicType;


// PREPARE AND SPAWN //////////////////////////////////////////////////////////////////////////////
private _initTickets = _tickets;
private _grp = grpNull;

while {_initTickets > 0} do {

    //IF THE INITAL TICKETS WERE HIGHER THAN ONE
    if (_tickets > 1) then {
        //WAIT UNTIL PROXIMTY IS FINE
        waitUntil {sleep 5; [_spawnPos,_range] call _proximityChecker isEqualTo false};
    };

    //IF PROXIMITY IS FINE
    private _veh = objNull;

    //IF CAR
    if (_vicType == "CAR") then {
        _veh = createVehicle [selectRandom _car, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _team;
        _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; (leader _grp) call BIS_fnc_enemyDetected || {{alive _x} count units _grp < 1 || {!alive _veh}}};
        [_grp] spawn lmf_ai_fnc_taskAssault;
    };

    //IF CARARMED
    if (_vicType == "CARARMED") then {
        _veh = createVehicle [selectRandom _carArmed, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _sentry;
        _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        _grp setBehaviour "AWARE";
        [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };

    //IF TRUCK
    if (_vicType == "TRUCK") then {
        _veh = createVehicle [selectRandom _truck, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _squad;
        _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; (leader _grp) call BIS_fnc_enemyDetected || {{alive _x} count units _grp < 1 || {!alive _veh}}};
        [_grp] spawn lmf_ai_fnc_taskAssault;
    };

    //IF APC
    if (_vicType == "APC") then {
        _veh = createVehicle [selectRandom _apc, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        _grp = [_spawnPos,var_enemySide,_vehicleCrew] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //PASSENGERS
        private _type = selectRandom [selectRandom _squad,selectRandom _team];
        private _grp2 = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp2 deleteGroupWhenEmpty true;
        {_x moveInCargo _veh;} forEach units _grp2;

        //TASK
        [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; (leader _grp) call BIS_fnc_enemyDetected || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        waitUntil {sleep 3; !(position _veh isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);};
        doStop driver _veh;
        doGetOut units _grp2;
        _grp2 leaveVehicle _veh;
        waitUntil {sleep 2; speed _veh > 0 || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        private _wp = _grp2 addWaypoint [getPos _veh,0];
        _wp setWaypointType "GUARD";
        [_grp2] spawn lmf_ai_fnc_taskAssault;
        sleep 15;
        driver _veh doFollow leader _grp;
    };

    //IF TANK
    if (_vicType == "TANK") then {
        _veh = createVehicle [selectRandom _tank, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        _grp = [_spawnPos,var_enemySide,_vehicleCrew] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        _grp setBehaviour "AWARE";
        [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };

    //IF HELICOPTER TRANSPORT
    if (_vicType == "HELITRANSPORT") then {
        _veh = createVehicle [selectRandom _heli_Transport, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        _grp = [_spawnPos,var_enemySide,_heliCrew] call BIS_fnc_spawnGroup;
        _grp deleteGroupWhenEmpty true;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //PASSENGERS
        private _type = selectRandom _squad;
        private _grp2 = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp2 deleteGroupWhenEmpty true;
        {_x moveInCargo _veh;} forEach units _grp2;

        //TASK
        [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; (leader _grp) call BIS_fnc_enemyDetected || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        doGetOut units _grp2;
        _grp2 leaveVehicle _veh;
        waitUntil {sleep 1; isTouchingGround _veh || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        private _wp = _grp2 addWaypoint [getPos _veh,0];
        _wp setWaypointType "GUARD";
        [_grp2] spawn lmf_ai_fnc_taskAssault;
    };

    //IF ATTACK HELICOPTER
    if (_vicType == "HELIATTACK") then {
        _veh = createVehicle [selectRandom _heli_Attack, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        _grp = createGroup var_enemySide;
        [_veh, _grp, false, "",_Pilot] call BIS_fnc_spawnCrew;
        _grp deleteGroupWhenEmpty true;

        //TASK
        _grp setBehaviour "AWARE";
        [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };

    //IF THE INITAL TICKETS WERE HIGHER THAN ONE
    if (_tickets > 1) then {
        //WAIT UNTIL EVERYONE DEAD
        waitUntil {sleep 5; !alive _veh || {{alive _x} count units _grp < 1}};
        sleep _respawnTime;
    };

    //SUBTRACT TICKET
    _initTickets = _initTickets - 1;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////