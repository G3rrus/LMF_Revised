// AI INFANTRY GARRISON  //////////////////////////////////////////////////////////////////////////
/*
	- Originally by nkenny.
	- Revised by Drgn V4karian.
	- File to spawn a group of infantry that garrisons. The group will ungarrison/regarrison
	  depending on their combat status and their distance to the closest enemy.

	- USAGE:
		1) Spawn Position.
		2) Group Type [OPTIONAL] ("squad", "team", "sentry","atTeam","aaTeam", "mgTeam" or number of soldiers.) (default: "TEAM")
		3) Garrison Radius. [OPTIONAL] (number) (default: 100)
		4) Distribution [OPTIONAL] (0 = fill evenly, 1 = building by building) (default: 1)
		5) Use CBA Building Pos only [Optional] (false = no, true = yes) (default: false)

	- EXAMPLE: [this,"TEAM",100,1,false] spawn lmf_ai_fnc_garrison;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {CBA_missionTime > 0};
private _spawner = [] call lmf_ai_fnc_returnSpawner;
if !(_spawner) exitWith {};

#include "cfg_spawn.sqf"

params [["_spawnPos", [0,0,0]],["_grpType", "TEAM"],["_garrisonRadius", 100],["_distribution", 1],["_customPos", false]];
_spawnPos = _spawnPos call CBA_fnc_getPos;
private _usePos = [];
if (_customPos) then {
	_usePos = ["CBA_BuildingPos"];
};


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
private _type = [_grptype] call _typeMaker;
private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
_grp deleteGroupWhenEmpty true;
_grp setFormation "DIAMOND";


// GARRISON THEM //////////////////////////////////////////////////////////////////////////////////
//APPLY GARRISON
[_spawnPos, _usePos, units _grp, _garrisonRadius, _distribution, selectRandom [true,false], true] call ace_ai_fnc_garrison;

//UNGARRISON SINGLE UNIT BASED ON NEARBY ENEMY FIRE, ITS OWN FIRE, OR NEARBY FRIENDLY FIRE
{
	_x addEventHandler ["FiredNear", {
		_this call lmf_ai_fnc_ungarrisonEH;

		//REMOVE EH AFTER IT FIRED
		_unit removeEventHandler ["FiredNear", _thisEventHandler];
	}];
} forEach (units _grp);