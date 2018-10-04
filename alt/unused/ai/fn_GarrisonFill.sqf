// Fill building with troops
// version 1.0
// by nkenny

/*

Garrison buildings within range randomly. Add extra locations with objects-- such as ducttapes. 

Arguments
  Position    (Object, marker, logic, grid)
  Selection   (Number or string: Default : Team) (OPTIONAL)
  Range       (Number. Default 100m) (OPTIONAL)
  Buildpos    (Use predefined building pos. Default true) (OPTIONAL)
  Item        (Which item is used for locations. Default Ducttape) (OPTIONAL)

  EXAMPLE: 0 = [this,"squad",100, true, "Land_DuctTape_F"] spawn a2k_fnc_GarrisonFill;

*/
waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};

#include "cfg_spawn.sqf";

// init
_p = (_this select 0) call bis_fnc_position; 
_grpType = param [1,"TEAM"];
_r = param [2,100];
_use = param [3,true];
_item = param [4,"Land_DuctTape_F"];

// Check type
_type = [_grpType] call nk_typemaker;  
_grp = [_p,_spawnSide,_type] call BIS_fnc_spawnGroup;

// Gear em up
{0 = [_x] spawn _gear;} foreach units _grp;
_grp deleteGroupWhenEmpty true;


// find positions
_p2 = (_p) nearObjects [_item, _r];
_p3 = [];
{_p3 pushbackUnique (getposatl _x)} foreach _p2;

// house positions
if (_use) then 
  {
  _list = nearestObjects [_p, ["house","building"], _r];
    {
      _list2 = _x call bis_fnc_buildingPositions; 
      _p3 append _list2;
      //[_x] call nk_fnc_dotmarker; 
    } foreach _list; 
  }; 

// debug
if (var_debug) then 
  {
    {_o = "Sign_Arrow_F" createVehicle [0,0,0];_o setpos _x;} foreach _p3;
    //{_m = [_x,"","ColorRed"] call nk_fnc_dotmarker;} foreach _list;  
  }; 

// Orders
_p3 = _p3 call bis_fnc_arrayShuffle;
{
  // END
  if (count units _grp == _forEachIndex) exitWith {}; 
  
  // SITUATE AND ORDER
  _u = ((units _grp) select _forEachIndex);
  _u setpos _x;
  _u DisableAI "PATH";
  _u disableAI "AUTOCOMBAT";
  _u setdir (random 360);

  // OUTSIDE OR NOT? 
  if (!lineIntersects [eyepos _u,[eyepos _u select 0,eyepos _u select 1,(eyepos _u select 2) + 10]] && (random 1 < 0.3)) then {_u setUnitPos "MIDDLE";};
  
  // AGGRESSION
	_u addEventHandler ["Fired", {
                                _shooter = (_this select 0);
                                _shooter setCombatMode "RED";
                               }
                     ];
  
} foreach _p3;

// end
true
