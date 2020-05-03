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
	* 4: Slow Hunt <BOOL> only does something if lambs danger AI is enabled
	*
	* Example:
	* [player, "TEAM", 500, 1, false] spawn lmf_ai_fnc_infantryHunter;
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
	["_radius",500,[123]],
	["_tickets",1,[123]],
	["_methodical",false,[true]]
];

_spawnPos = _spawnPos call CBA_fnc_getPos;
if (_spawnPos isEqualTo  [0,0,0]) exitWith {};

private _range = 500;
private _initTickets = _tickets;
private _doSpawn = 0;


// PREPARE AND SPAWN THE GROUP ////////////////////////////////////////////////////////////////////
while {_initTickets > 0} do {

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE
	if (_tickets > 1) then {
		//WAIT UNTIL PROXIMTY IS FINE OR HAS BEEN BREACHED BY GROUND
		waitUntil {sleep 5; _doSpawn = [_spawnPos,_range] call lmf_ai_fnc_proxyCheck; !(_doSpawn isEqualTo 1)};
	};
	if (_doSpawn isEqualTo 2) exitWith {};

	//ONCE THE PROXIMITY IS FINE
	private _type = [_grptype] call lmf_ai_fnc_makeType;
	private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
	_grp deleteGroupWhenEmpty true;

	if (isClass (configfile >> "CfgPatches" >> "lambs_wp")) then {
		if (_methodical) then {
			[_grp, _radius, 30] spawn lambs_wp_fnc_taskHunt;
		} else {
			[_grp, _radius] spawn lambs_wp_fnc_taskRush;
		};
	} else {
		[_grp,_radius] spawn lmf_ai_fnc_taskHunt;
	};

	//SUBTRACT TICKET
	_initTickets = _initTickets - 1;

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE AND ITS NOT THE LAST CYCLE
	if (_tickets > 1 && {_initTickets > 0}) then {
		//WAIT UNTIL EVERYONE DEAD OR GROUND PROXIMITY BREACH
		waitUntil {sleep 15; [_spawnPos,_range] call lmf_ai_fnc_proxyCheck isEqualTo 2 || {{alive _x} count units _grp < 1}};
	};
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////