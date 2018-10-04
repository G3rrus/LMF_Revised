// CREW STATIC WEAPONS
// version 1.0
// by nkenny

/*

Group
Find static weapons
Take control of them 

*/


// Init 
_grp = _this select 0; 
_pos = getposatl leader _grp; 
_range = if (count _this > 1) then {_this select 1} else {100};
_vehicles = if (count _this > 2) then {_this select 2} else {true};

// Find close static weapons ----------------------------
_types = ["StaticWeapon"];
if (_vehicles) then {_types pushback "Tank";_types pushback "Car"};

// Do the search
_glist = nearestobjects [_pos,_types,_range];
_staticlist = [];
if (count _glist > 0) then 
{
  {
      if ((_x emptyPositions "Gunner") > 0) then 
      {
          _staticlist = _staticlist + [_x];
      };
  } foreach _glist;
}; 

// Order the static weapons -------------------------
// potentially randomise? 

// Move units into them! ----------------------------
_team = units _grp; 

{
  if (isNull (gunner _x)) then 
  {
    (_team select 0) enableAI "MOVE"; 
    (_team select 0) assignasgunner _x; 
    [(_team select 0)] ordergetin true; 
    //(_team select 0) moveingunner _x; 
    _team = _team - [_team select 0];
    if (count _team < 1) exitWith {if (var_debug) then {systemchat "DEBUG STATIC WEAPONS : No more troops"};};
  }; 
} foreach _staticlist; 

// End 
