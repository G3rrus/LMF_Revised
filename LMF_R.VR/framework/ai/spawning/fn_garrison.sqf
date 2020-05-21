// AI INFANTRY GARRISON  //////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus, nkenny
	* Spawn AI and garrison them.
	* Note: Needs to be called on the Server or a HC.
	*
	* Arguments:
	* 0: Spawn Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	* 1: Type <STRING or NUMBER> supported types are: "SENTRY", "TEAM", "SQUAD", "ATTEAM", "MGTEAM" and "AATEAM"
	* 2: Radius <NUMBER>
	* 3: Distribution <NUMBER> possible numbers are: 0 = even filling, 1 = building by building or 2 = random
	* 4: Use only CBA position <BOOL>
	*
	* Example:
	* [player, "TEAM", 100, 0, false] spawn lmf_ai_fnc_garrison;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if (hasInterface && {!isServer}) exitWith {};
waitUntil {CBA_missionTime > 0};

params [
	["_spawnPos",objNull,[objNull,grpNull,"",locationNull,taskNull,[],123]],
	["_grpType","TEAM",["",123]],
	["_garrisonRadius",100,[123]],
	["_distribution",1,[123]],
	["_customPos",false,[true]]
];

_spawnPos = _spawnPos call CBA_fnc_getPos;
if (_spawnPos isEqualTo  [0,0,0]) exitWith {};

private _usePos = [];
if (_customPos) then {
	_usePos = ["CBA_BuildingPos"];
};


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
private _type = [_grptype] call lmf_ai_fnc_makeType;
private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
_grp deleteGroupWhenEmpty true;
_grp setFormation "DIAMOND";
_grp setGroupIDGlobal [format ["Garrison: %1", groupId _grp]];

//GARRISON THEM
[_spawnPos, _usePos, units _grp, _garrisonRadius, _distribution, selectRandom [true,false], true] call ace_ai_fnc_garrison;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////