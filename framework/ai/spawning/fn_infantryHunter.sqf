// AI INFANTRY HUNTER /////////////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny.
	- Revised by Drgn V4karian.
	- File to spawn a group of infantry that functions as hunter AI. Once in range of _radius they
	  will start to move in on the closest target aggressively.
	- It is important to note that the player proximity check for spawning will only occur if spawn tickets
	  are set to a higher number than 0.

	- USAGE:
		1) Spawn Position.
		2) Group Type [OPTIONAL] ("squad", "team", "sentry","atTeam","aaTeam" or number of soldiers) (default: "TEAM")
		3) Hunting Radius [OPTIONAL] (default: 500)
		4) Spawn Tickets [OPTIONAL] (default: 0)

	- EXAMPLE: 0 = [this,"TEAM",500,0] spawn lmf_ai_fnc_infantryHunter;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_grpType", "TEAM"],["_radius", 500],["_tickets", 0]];
_spawnPos = _spawnPos call CBA_fnc_getPos;
private _range = 500;


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
//NO RESPAWN
if (_tickets == 0) exitWith {
	private _type = [_grptype] call _typeMaker;
	private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;

	0 = [_grp,_radius] spawn lmf_ai_fnc_taskHunt;

	{_x disableAI "AUTOCOMBAT";} count units _grp;
	{_x allowFleeing 0;} count units _grp;
	{_x enableAttack false;} count units _grp;
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

		0 = [_grp,_radius] spawn lmf_ai_fnc_taskHunt;

		{_x disableAI "AUTOCOMBAT";} count units _grp;
		{_x allowFleeing 0;} count units _grp;
		{_x enableAttack false;} count units _grp;

		//WAIT UNTIL EVERYONE DEAD THEN SUBTRACT TICKET
		waitUntil {sleep 5; {alive _x} count units _grp < 1};
		_tickets = _tickets - 1;
	};
};