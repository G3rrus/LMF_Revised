// AI INFANTRY QRF ////////////////////////////////////////////////////////////////////////////////
/*
	- Redone by Drgn V4karian with help of Diwako.
	- File to spawn a group of infantry that functions as QRF. Will turn more aggressive if in
	  combat mode.

	- USAGE:
		1) Spawn Position.
		2) Group Type [OPTIONAL] ("squad", "team", "sentry","atTeam","aaTeam" or number of soldiers) (default: "TEAM")
		3) Spawn Tickets [OPTIONAL] (default: 0)

	- EXAMPLE: 0 = [this,"team",0] spawn lmf_ai_fnc_infantryQRF;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_grpType", "TEAM"],["_tickets", 0]];
_spawnPos = _spawnPos call CBA_fnc_getPos;
private _range = 500;

//WAIT A RANDOM BIT OF TIME (In case multiple functions are called on 1 location it make spawning a bit smoother)
sleep (random 10);


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
//NO RESPAWN
if (_tickets == 0) exitWith {
	private _type = [_grptype] call _typeMaker;
	private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
	
	_wp = _grp addWaypoint [_spawnPos,0];
	_wp setWaypointType "GUARD";
	_grp setFormation "DIAMOND";
	_grp allowFleeing 0.1;
	
	waitUntil {sleep 1; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1}};

	_grp setCombatMode "GREEN";
	_grp setFormation "LINE";
	sleep 5 + random 10;
	_grp setCombatMode "YELLOW";

	0 = [_grp] spawn lmf_ai_fnc_taskAssault;
};

//WITH RESPAWN
while {_tickets > 0} do {

	//CECK PROXIMITY
	private _near = [_spawnPos,_range] call _proximityChecker;

	//IF PLAYER TO CLOSE SLEEP ELSE SPAWN
	if (_near) then {
		sleep 60;
	} else {
		private _type = [_grptype] call _typeMaker;
		private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
		
		_wp = _grp addWaypoint [_spawnPos,0];
		_wp setWaypointType "GUARD";
		_grp setFormation "DIAMOND";
		_grp allowFleeing 0.1;
		
		waitUntil {sleep 1; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1}};

		_grp setCombatMode "GREEN";
		_grp setFormation "LINE";
		sleep 5 + random 10;
		_grp setCombatMode "YELLOW";

		0 = [_grp] spawn lmf_ai_fnc_taskAssault;

		//WAIT UNTIL EVERYONE DEAD THEN SUBTRACT TICKET
		waitUntil {sleep 5; {alive _x} count units _grp < 1};
		_tickets = _tickets - 1;
	};
};