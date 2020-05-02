// AI INFANTRY PATROL  ////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus, nkenny
	* Spawn AI and make patrol around their spawn areas.
	* Note: Needs to be called on the Server or a HC.
	*
	* Arguments:
	* 0: Spawn Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	* 1: Type <STRING or NUMBER> supported types are: "SENTRY", "TEAM", "SQUAD", "ATTEAM", "MGTEAM" and "AATEAM"
	* 2: Patrol Radius <NUMBER>
	* 3: Alerted <BOOL>
	*
	* Example:
	* [player, "TEAM", 200, true] spawn lmf_ai_fnc_patrol;
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
	["_grpType","TEAM",["",123]],
	["_patrolRadius",200,[123]],
	["_alerted",true,[true]]
];

_spawnPos = _spawnPos call CBA_fnc_getPos;
if (_spawnPos isEqualTo  [0,0,0]) exitWith {};

private _patrolTarget = _spawnPos;
private _behav = "AWARE";
private _cMode = "RED";
private _speed = "NORMAL";
if !(_alerted) then {
	_behav = "SAFE";
	_cMode = "YELLOW";
	_speed = "LIMITED";
};


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
private _type = [_grptype] call lmf_ai_fnc_makeType;
private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
_grp deleteGroupWhenEmpty true;

//GIVE THEM ORDERS
[_grp, _patrolTarget, _patrolRadius, 4, "MOVE", _behav, _cMode, _speed, "STAG COLUMN", "", [10,20,30]] call CBA_fnc_taskPatrol;

waitUntil {sleep 5; behaviour leader _grp == "COMBAT" || {{alive _x} count units _grp < 1}};

if ({alive _x} count units _grp < 1) exitWith {};
[_grp] spawn lmf_ai_fnc_taskUpdateWP;
sleep 5;
if (isClass (configfile >> "CfgPatches" >> "lambs_wp")) then {
	[_grp,150,30] spawn lambs_wp_fnc_taskRush;
} else {
	[_grp] spawn lmf_ai_fnc_taskAssault;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////