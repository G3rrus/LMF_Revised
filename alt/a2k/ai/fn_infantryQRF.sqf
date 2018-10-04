// INFANTRY QRF ///////////////////////////////////////////////////////////////////////////////////
// BEHAVIOUR: Will act as a QRF, waiting at their spawnposition until called by friendly AI.

//Parameters:
//1. Spawn position
//2. Group type ("squad","team","sentry","atTeam","aaTeam") OR number of soldiers.
//EXAMPLE: 0 = [this,"team"] spawn a2k_fnc_infantryQRF;

/*
Rewritten 02.04.17 by nkenny
- Fewer paramaters required
- Many fewer lines of code
*/


waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};

#include "cfg_spawn.sqf";

_pos = (_this select 0) call CBA_fnc_getpos;
_grpType = if (count _this > 1) then {_this select 1} else {"team"};


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
		_grp deleteGroupWhenEmpty true;
		_wp = _grp addWaypoint [_pos,0];
		_wp setWaypointType "GUARD";
		_grp setFormation "DIAMOND";
		_grp allowFleeing 0.1;

		waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1};

		_grp setCombatMode "GREEN";
		_grp setFormation "LINE";
		sleep 5 + random 10;
		_grp setCombatMode "YELLOW";

		0 = [_grp] spawn a2k_fnc_taskAssault;
