// INFANTRY QRF (RESPAWNING) //////////////////////////////////////////////////////////////////////
// BEHAVIOUR: Will act as a QRF, waiting at their spawnposition until called by friendly AI.
// RESPAWNS at original spawn position when all group members are dead
// DOES NOT spawn if there are players nearby their spawnposition (within 500m)

//Parameters:
//1. Spawn position & Guard waypoint
//2. Group type ("squad","team","sentry","atTeam","aaTeam") OR number of soldiers.
//3. Number of times the group will respawn (Default 99)
//EXAMPLE: 0 = [this,"team"] spawn a2k_fnc_infantryQRF_re;


/*
Rewritten 02.04.17 by nkenny
- Fewer paramaters required
- Many fewer lines of code
- Added tickets parameter
*/


waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};


#include "cfg_spawn.sqf";

_pos = (_this select 0) call CBA_fnc_getpos;
_grpType = if (count _this > 1) then {_this select 1} else {"team"};
_tickets = if (count _this > 2) then {_this select 2} else {99};
_range = 500; // distance to nearest player

// the magic
for "_i" from 0 to _tickets do {

// STAY A WHILE AND LISTEN!
waitUntil {sleep 1; CBA_missionTime > (30 + (random 90));};
sleep (random 10);
		
  // check if player nearby-- if close, wait. 
  _near = [_pos,_range] call nk_Close;
  if (_near) then 
    {
    sleep 60; 
    } else {
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

		// Waituntil...
		waitUntil {sleep 1; {alive _x} count units _grp < 1};
	};
};