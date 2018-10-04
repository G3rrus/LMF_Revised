// SPAWN Jet
// version 1.0
// by nkenny

/*
 Create Jet with S&D Destroy task


 Arguments
 1. spawn pos
 2. Destination (optional) 
 3. Type (optional : Default "CAS bird") 
 4. waves (optional : Default 1)

*/


waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};

#include "cfg_spawn.sqf";

// init
_p = (_this select 0) call bis_fnc_position;
_p2 = if (count _this > 1) then {(_this select 1) call bis_fnc_position} else {getArray (configFile >> "CfgWorlds" >> worldName >> "centerPosition")};
_type = if (count _this > 2) then {_this select 2} else {"O_Plane_CAS_02_dynamicLoadout_F"}; 
_waves = if (count _this > 3) then {_this select 3} else {1};

for "_i" from 1 to _waves do
  {
 
  // init
  _d = _p getDir _p2; 
  _speed = 150; 
  _velx = (sin _d * _speed);
  _vely = (cos _d * _speed);
  _velz = 0;
  
  // spawn
  _grp = [_p,_spawnside,[_type]] call BIS_fnc_spawnGroup;
  {0 = [_x] spawn _gear;} foreach units _grp; 
    
  // tweak
  _veh = vehicle leader _grp;
  _veh setDir _d;  
  _veh setVelocity [_velx, _vely, _velz];
  _veh setVehicleLock "LOCKEDPLAYER";
  
  // Performance
  _grp deleteGroupWhenEmpty true;
  
  // mission
  _wp = _grp AddWaypoint [_p2,500,0];
  _wp setWaypointType "SAD";
  _wp setWaypointCombatMode "RED";
  _wp setWaypointTimeout [60, 60, 120];
  _wp setWaypointCompletionRadius 1000; 
  
  // patrol 
  _wp2 = _grp AddwayPoint [_p2,3000,1];
  _wp3 = _grp AddwayPoint [_p2,3000,2];
  _wp3 setWayPointType "GUARD";
  
  // Debug
  if (var_debug) then {systemchat Format ["DEBUG JET SPAWN %1",_type]};
  
  // wait to Cycle
  WaitUntil {!alive _veh}; 
  
  }; 
  
// end
true 