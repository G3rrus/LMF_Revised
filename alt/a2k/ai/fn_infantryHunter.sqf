// INFANTRY HUNTER ////////////////////////////////////////////////////////////////////////////////
// BEHAVIOUR: Will hunt players within the defined radius. Be aware that they have "magic" knowledge of player position.

//Parameters:
//1. Spawn position
//2. Group type ("squad","team","sentry","atTeam","aaTeam") OR number of soldiers.
//3. Hunting radius
//EXAMPLE: 0 = [this,"team",500] spawn a2k_fnc_infantryHunter;

/*
Rewritten 02.04.17 by nkenny
- Fewer paramaters required
- Many fewer lines of code
*/


waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};

waitUntil {!isNil "var_warmup"};
waitUntil {!var_warmup};

#include "cfg_spawn.sqf";

_pos = (_this select 0) call CBA_fnc_getpos;
_grpType = if (count _this > 1) then {_this select 1} else {"team"};
_dist = if (count _this > 2) then {_this select 2} else {500};

// STAY A WHILE AND LISTEN!
waitUntil {sleep 1; CBA_missionTime > (30 + (random 90));};
sleep (random 10);
		
// Check type
_type = [_grpType] call nk_typemaker; 

// Select and spawn infantry
_grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;

// Gear
{0 = [_x] spawn _gear;} forEach units _grp;

// Orders
0 = [_grp,_dist] spawn a2k_fnc_taskHunt;
_grp deleteGroupWhenEmpty true;

{_x disableAI "AUTOCOMBAT"} forEach units _grp;
_grp setBehaviour "AWARE";
//{_x disableAI "COVER"} forEach units _grp;
{_x allowFleeing 0} forEach units _grp;
{_x enableAttack false} forEach units _grp;