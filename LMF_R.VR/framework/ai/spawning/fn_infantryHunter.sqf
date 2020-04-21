// AI INFANTRY HUNTER /////////////////////////////////////////////////////////////////////////////
/*
	* Author: nkenny, Alex2k, G4rrus
	* Spawn AI and once player in radius hunt them.
	* Note: Needs to be called on the Server or a HC.
	*
	* Arguments:
	* 0: Spawn Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	* 1: Type <STRING or NUMBER> supported types are: "SENTRY", "TEAM", "SQUAD", "ATTEAM", "MGTEAM" and "AATEAM"
	* 2: Radius <NUMBER>
	* 3: Spawn Tickets <NUMBER> values higher than 1 enable spawn proximity check
	*
	* Example:
	* [player, "TEAM", 500, 1] spawn lmf_ai_fnc_infantryHunter;
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
	["_radius",500,[123]],
	["_tickets",1,[123]]
];

_spawnPos = _spawnPos call CBA_fnc_getPos;
if (_spawnPos isEqualTo  [0,0,0]) exitWith {};

private _range = 500;


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
private _initTickets = _tickets;

while {_initTickets > 0} do {

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE
	if (_tickets > 1) then {
		//WAIT UNTIL PROXIMTY IS FINE
		waitUntil {sleep 5; [_spawnPos,_range] call _proximityChecker isEqualTo false};
	};

	//ONCE THE PROXIMITY IS FINE
	private _type = [_grptype] call _typeMaker;
	private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
	_grp deleteGroupWhenEmpty true;

	[_grp,_radius] spawn lmf_ai_fnc_taskHunt;

	{_x disableAI "AUTOCOMBAT";} count units _grp;
	_grp enableAttack false;
	_grp allowFleeing 0;

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE
	if (_tickets > 1) then {
		//WAIT UNTIL EVERYONE DEAD
		waitUntil {sleep 5; {alive _x} count units _grp < 1};
	};

	//SUBTRACT TICKET
	_initTickets = _initTickets - 1;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////