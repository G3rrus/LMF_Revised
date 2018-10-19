// AI VEHICLE QRF /////////////////////////////////////////////////////////////////////////////////
/*
	- Redone by Drgn V4karian with help of Diwako.
	- File to spawn a vehicle that functions as QRF. Some have additional infantry as passengers loaded,
      others like the tank will move in on players alone.
	- It is important to note that the player proximity check for spawning will only occur if spawn tickets
	  are set to a higher number than 0. The same goes for the respawn timer.

	- USAGE:
		1) Spawn Position.
		2) Vehicle Type [OPTIONAL] ("CAR", "CARARMED", "TURCK","APC","TANK", "HELITRANSPORT" or "HELIATTACK") (default: "TURCK")
		3) Spawn Tickets [OPTIONAL] (default: 0)
        4) Respawn Timer [OPTIONAL] (default: 300)

	- EXAMPLE: 0 = [this,"TRUCK",0,300] spawn lmf_ai_fnc_vehicleQRF;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_vicType", "TRUCK"],["_tickets", 0],["_respawnTime", 300]];
private _range = 1000;
private _dir = random 360;
if !(_spawnPos isEqualType []) then {_dir = getDir _spawnPos;};
_spawnPos = _spawnPos call CBA_fnc_getPos;
toUpper _vicType;

//WAIT A RANDOM BIT OF TIME (In case multiple functions are called on 1 location it make spawning a bit smoother)
sleep (random 10);


// WITHOUT RESPAWN ////////////////////////////////////////////////////////////////////////////////
if (_tickets == 0) exitWith {
    //IF CAR
    if (_vicType == "CAR") then {
        private _veh = createVehicle [selectRandom _car, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _team;
        private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh}}};
        0 = [_grp] spawn lmf_ai_fnc_taskAssault;
    };

    //IF CARARMED
    if (_vicType == "CARARMED") then {
        private _veh = createVehicle [selectRandom _carArmed, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _sentry;
        private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        _grp setBehaviour "AWARE";
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };

    //IF TRUCK
    if (_vicType == "TRUCK") then {
        private _veh = createVehicle [selectRandom _truck, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = selectRandom _squad;
        private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh}}};
        0 = [_grp] spawn lmf_ai_fnc_taskAssault;
    };

    //IF APC
    if (_vicType == "APC") then {
        private _veh = createVehicle [selectRandom _apc, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = _vehicleCrew;
        private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //PASSENGERS
        private _type2 = selectRandom [selectRandom _squad,selectRandom _team];
        private _grp2 = [_spawnPos,var_enemySide,_type2] call BIS_fnc_spawnGroup;
        {_x moveInCargo _veh;} forEach units _grp2;

        //TASK
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        waitUntil {sleep 3; !(position (vehicle leader _grp) isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);};
        doStop driver _veh;
        doGetOut units _grp2;
        _grp2 leaveVehicle _veh;
        waitUntil {sleep 2; speed _veh == 1  || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        0 = [_grp2] spawn lmf_ai_fnc_taskAssault;
        sleep 15;
        driver _veh doFollow leader _grp;
    };

    //IF TANK
    if (_vicType == "TANK") then {
        private _veh = createVehicle [selectRandom _tank, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = _vehicleCrew;
        private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //TASK
        _grp setBehaviour "AWARE";
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };

    //IF HELICOPTER TRANSPORT
    if (_vicType == "HELITRANSPORT") then {
        private _veh = createVehicle [selectRandom _heli_Transport, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _type = _heliCrew;
        private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh;} forEach units _grp;

        //PASSENGERS
        private _type2 = selectRandom [selectRandom _squad,selectRandom _team];
        private _grp2 = [_spawnPos,var_enemySide,_type2] call BIS_fnc_spawnGroup;
        {_x moveInCargo _veh;} forEach units _grp2;


        //TASK
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
        waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        doGetOut units _grp2;
        _grp2 leaveVehicle _veh;
        waitUntil {sleep 1; isTouchingGround _veh || {{alive _x} count units _grp < 1 || {!alive _veh || {{alive _x} count units _grp2 < 1}}}};
        0 = [_grp2] spawn lmf_ai_fnc_taskAssault;
    };

    //IF ATTACK HELICOPTER
    if (_vicType == "HELIATTACK") then {
        private _veh = createVehicle [selectRandom _heli_Attack, _spawnPos, [], 0, "CAN_COLLIDE"];
        _veh setDir _dir;

        //CREW
        private _grp = createGroup var_enemySide;
        [_veh, _grp, false, "",_Pilot] call BIS_fnc_spawnCrew;

        // Orders
        _grp setBehaviour "AWARE";
        0 = [_grp] spawn lmf_ai_fnc_taskUpdateWP;
    };
};

while {_tickets > 0} do {
    //CECK PROXIMITY
    private _near = [_spawnPos,_range] call _proximityChecker;

    //IF PLAYER TO CLOSE SLEEP ELSE SPAWN
    if (_near) then {
        sleep 60;
    } else {




    // ALL THE SHIT GOES HERE AGAIN?
    // NEED TO SOLVE THE GROUP AND VEHICLE SCOPE PROBLEM FOR THE WAIT UNTIL UNLESS I MOVE IT INTO THE SCOPE.



    //WAIT UNTIL VEHICLE OR VEHICLE CREW DEAD THEN SUBTRACT TICKET AND SLEEP
    waitUntil {sleep 5; !alive _veh || {{alive _x} count units _grp < 1}};
    _tickets = _tickets - 1;
    sleep _respawnTime;
    };
};