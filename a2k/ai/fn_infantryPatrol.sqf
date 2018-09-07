// PATROL SPAWN SCRIPT /////////////////////////////////////////////////////////////////////////////
// BEHAVIOUR: Will patrol in the given radius

//Parameters:
//1. Spawn position
//2. Group type ("squad", "team", "sentry","atTeam","aaTeam") OR number of soldiers.
//3. Patrol radius
//EXAMPLE: 0 = [this,"team",100] spawn a2k_fnc_infantryPatrol;

/*
Rewritten 02.04.17 by nkenny
- Fewer paramaters required
- Many fewer lines of code
*/


waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};

#include "cfg_spawn.sqf";

_spawnPos = (_this select 0) call CBA_fnc_getpos;
_grptype = if (count _this > 1) then {_this select 1} else {"sentry"};
_patrolRadius = if (count _this > 2) then {_this select 2} else {200};
_patrolTarget = if (count _this > 3) then {_this select 3} else {_this select 0};

// STAY A WHILE AND LISTEN!
waitUntil {sleep 1; CBA_missionTime > (30 + (random 90));};
sleep (random 10);

// Check type
_type = [_grptype] call nk_typemaker; 

// Spawn units
_grp = [_spawnPos,_spawnSide,_type] call BIS_fnc_spawnGroup;

// Gear
{0 = [_x] spawn _gear;} foreach units _grp;

// Orders
[_grp, _patrolTarget, _patrolRadius, 4, "MOVE", "AWARE", "RED", "NORMAL", "STAG COLUMN", "", [10,20,30]] call CBA_fnc_taskPatrol;
_grp deleteGroupWhenEmpty true;

waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1};
0 = [_grp] spawn a2k_fnc_taskUpdateWP;
sleep 5;
0 = [_grp] spawn a2k_fnc_taskAssault;