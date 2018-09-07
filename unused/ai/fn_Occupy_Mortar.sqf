// Occupy Mortar script
// version 1.1
// by nkenny

/*

version 1.1
- Reconfig og occupy static essentially 

Find a suitable nearby spot, prefer meadows
Create a Mortar
Add Mortar trigger
End
*/

waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};

#include "cfg_spawn.sqf";

// init
_p = (_this select 0) call bis_fnc_position;

// Find spot ----------------
_p2 = [_p, 10, 50, 4, 0, 0, 0] call BIS_fnc_findSafePos;
if (count _p2 < 1) exitWith {if (var_debug) then {systemchat "DEBUG-occupy-MORTAR No good sites found"}};

// Spawn Mortar-------------
_gun = "B_Mortar_01_F";
//if (var_RHS) then {_gun = "rhsgref_ins_2b14"};
_grp = [_p2, _spawnside, [_gun]] call BIS_fnc_spawnGroup;
(vehicle leader _grp) setVectorUp surfaceNormal position (vehicle leader _grp);

// mortar attack!
_Mortar_trigger = createTrigger ["EmptyDetector",_p2];
_Mortar_trigger setTriggerActivation ["EAST","WEST D",true];
_Mortar_trigger setTriggerArea [(600 + random 400),(600 + random 400),0,false];
_Mortar_trigger setTriggerTimeout [30, 120, 180, false]; 
_Mortar_trigger setTriggerStatements ["this", "0 = [Thislist,ThisTrigger] execVM 'a2k\ai\task\fn_MortarAttack.sqf'",""];

// Dynamic Simulation
//_grp enableDynamicSimulation true;
_grp deleteGroupWhenEmpty true;

// Gear em! 
{0 = [_x] spawn _gear;} forEach units _grp;
// end