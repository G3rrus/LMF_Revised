// INFANTRY GARRISON //////////////////////////////////////////////////////////////////////////////
// BEHAVIOUR: Will garrison random buildings and has a chance to man empty static weapons within the given radius.

//Parameters:
//1. Spawn position
//2. Group type ("squad","team","sentry","atTeam","aaTeam") OR number of soldiers.
//3. Garrison radius
//EXAMPLE: 0 = [this,"team",100] spawn a2k_fnc_infantryGarrison;

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
_garrisonRadius = if (count _this > 2) then {_this select 2} else {100};

// STAY A WHILE AND LISTEN!
waitUntil {sleep 1; CBA_missionTime > (30 + (random 90));};
sleep (random 10);

// Check type
_type = [_grpType] call nk_typemaker; 

// Spawn units
_grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;

// Gear
{0 = [_x] spawn _gear;} foreach units _grp;

// Behaviour
_grp deleteGroupWhenEmpty true;

// Garrison sequence
[_pos, nil, units _grp, _garrisonRadius, 0, selectRandom [true,false], true] call ace_ai_fnc_garrison;
{_x setUnitPos selectRandom ["UP","UP","MIDDLE"];} forEach units _grp;

waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1};
{_x setUnitPos "UP";} forEach units _grp;

sleep 5 + random 10;

{
	if (typeOf _x == _Autorifleman OR typeOf _x == _MMG_Gunner) then {
		_x setUnitPos "UP";
	} else
	{
		_x setUnitPos "AUTO";
	};
} forEach units _grp;


while {count units _grp > 1} do {
	waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1};
	_nearEnemy = (leader _grp) findNearestEnemy (leader _grp);
	_range = 25 + random 25;

	sleep 30;

	if (!isNull _nearEnemy AND _nearEnemy distance (leader _grp) < _range) then {
		//{_x setUnitPos "AUTO"} forEach units _grp;
		{_x disableAI "AUTOCOMBAT"} forEach units _grp;
		_grp setBehaviour "AWARE";
		[units _grp] call ace_ai_fnc_unGarrison;
		sleep 5;
		if ({alive _x} count units _grp > 1) then {
			[_pos, nil, units _grp, _garrisonRadius, 0, selectRandom [true,false], false] call ace_ai_fnc_garrison;
			sleep 55;
			{_x enableAI "AUTOCOMBAT"} forEach units _grp;
			_grp setBehaviour "AWARE";
		};
	};
	//waitUntil {sleep 1; behaviour leader _grp == "AWARE" OR {alive _x} count units _grp < 1};
};