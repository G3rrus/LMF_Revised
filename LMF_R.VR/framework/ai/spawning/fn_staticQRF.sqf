// AI STATIC QRF ////////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus, Alex2k
	* Spawn AI sentry with static weapon backpacks, make them deploy on contact.
	* Note: Needs to be called on the Server or a HC.
	*
	* Arguments:
	* 0: Spawn Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	* 1: Spawn Tickets <NUMBER> values higher than 1 enable spawn proximity check
	*
	* Example:
	* [player, 1] spawn lmf_ai_fnc_staticQRF;
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
	_grp = [_spawnPos,var_enemySide,_staticCrew] call BIS_fnc_spawnGroup;
	_grp deleteGroupWhenEmpty true;

	private _wp = _grp addWaypoint [_spawnPos,0];
	_wp setWaypointType "GUARD";
	_grp setFormation "STAG COLUMN";
	_grp allowFleeing 0.1;

	waitUntil {sleep 3; (leader _grp) call BIS_fnc_enemyDetected || {{alive _x} count units _grp < 1}};

	//IF BOTH ARE STILL ALIVE
	if ({alive _x} count units _grp > 1) then {
		private _gunner = (units _grp) select 0;
		private _assistant = (units _grp) select 1;

		//ADD EH THAT MAKES SURE THE GUY GETS IN AN THE WEAPON IS ROTATED RIGHT
		_gunner addEventHandler ["WeaponAssembled",{
			_this spawn {
				params ["_unit","_weapon"];
				sleep 2;
				private _dir = _unit getDir (_unit findNearestEnemy _unit);
				_weapon setDir _dir;
				_weapon setVectorUp (surfaceNormal position _weapon);
				_unit moveInAny _weapon;
			};
		}];

		//DEPLOY THE WEAPON
		{_x disableAI "AUTOCOMBAT";} count units _grp;
		_grp setbehaviourstrong "SAFE";
		_grp setCombatMode "BLUE";
		private _base = unitBackpack _assistant;
		_gunner action ["Assemble", _base];
		_assistant playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
		sleep 2;
		removeBackpack _assistant;
		{_x enableAI "AUTOCOMBAT";} count units _grp;
		_grp setBehaviour "AWARE";
		_grp setCombatMode "YELLOW";
	};

	//IF THE INITAL TICKETS WERE HIGHER THAN ONE
	if (_tickets > 1) then {
		//WAIT UNTIL EVERYONE DEAD
		waitUntil {sleep 5; {alive _x} count units _grp < 1};
	};

	//SUBTRACT TICKET
	_initTickets = _initTickets - 1;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////