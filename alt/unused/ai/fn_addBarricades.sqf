// SPAWN BARRICADE!
// version 1.6
// by nkenny, adapted work by h8maker

/*
v1.6
- Updated for framework
- Added arguments
  1. Position
  2. Number of spawns   Default 6 - 10 
  3. Range              Default 100m

v1.5
- Wreck version
v1.41
-count roadlist
v1.4
-expanded car selecction
*/

#include "cfg_spawn.sqf";

// INIT
_pos = (_this select 0) call bis_fnc_position;

// SETTINGS
_carSpawns= param [1,floor (6 + random 4)];
_range = param [2,100];
_wrecklist = [
              "Land_Barricade_01_10m_F",
              "Land_Barricade_01_10m_F",
              "Land_Barricade_01_10m_F",
              "Land_Barricade_01_4m_F",
              "Land_Razorwire_F"
             ];

// ROADS
_roadList= _pos nearroads _range;
if (count _roadlist < 2) exitWith {Systemchat format ["DEBUG: No roads found!(%1)",count _roadlist]};

// DEBUG
_showRoads=false;
if (_showRoads) then 
  {
		{
      _txt=format ["RoadPos:%1",_x];
      _debug=createMarker [_txt,_x];
      _debug setMarkerShape "ICON";
      _debug setMarkerType "hd_dot";
    } foreach _roadList;
	};
		
// SHUFFLE ROADS
_roadlist=_roadlist call BIS_fnc_arrayShuffle;
if (count _roadlist < _carSpawns) then {_carSpawns = count _roadlist};

// SPAWN IN CARS!
for "_i" from 0 to (_carSpawns-1) do {

  // road
	_direction = (Random 360);
	_currentRoad=_roadlist select _i;
  if (count (roadsConnectedTo _currentRoad) > 1) then 
    {
    _connectedRoad = ((roadsConnectedTo _currentRoad) select 0);
    _direction = [_currentRoad, _connectedRoad] call BIS_fnc_DirTo;
    };

 // Vehicle
 _car = selectRandom _wrecklist;
 _veh = createVehicle [_car, _currentRoad, [], 0, "CAN_COLLIDE"]; //"NONE"
 _veh setdir _direction;
 _rel_pos = [_veh, 0.5 + (random 5),(_direction+90)] call BIS_fnc_relPos;
 _veh setpos _rel_pos;
 addToRemainsCollector [_veh];
 
 if (_car == "Land_Razorwire_F") then 
  {
     _veh = createVehicle ["Land_Razorwire_F", _currentRoad, [], 0, "NONE"]; //"NONE"
     _veh setdir _direction;
     addToRemainsCollector [_veh];
  }; 
 
 // Burning Barrel
 if (random 1 < 0.1 && (_car != "Land_Razorwire_F")) then 
  {
    _veh2 = createVehicle ["MetalBarrel_burning_F", _veh, [], 0, "NONE"]; //"NONE"
    _veh2 setVectorUp surfaceNormal position _veh2;
    addToRemainsCollector [_veh2];
  }; 
  
 // Burning Wheels
 if (random 1 < 0.1 && (_car != "Land_Razorwire_F")) then 
  {
    _center = createCenter sideLogic;    
    _grp = createGroup _center;
    _veh3 = createVehicle ["Land_Tyres_F", _veh, [], 150, "NONE"];
    _smoke = _grp createUnit ["ModuleEffectsSmoke_F",getpos _veh3,[],0,"CAN_COLLIDE"];
    _veh3 setVectorUp surfaceNormal position _veh3;
    addToRemainsCollector [_smoke,_veh3];  
  }; 
  
  // DEBUG
  if (_showroads) then {
      _txt=format ["Veh:%1",_i];
      _debug=createMarker [_txt,_currentRoad];
      _debug setMarkerShape "ICON";
      _debug setMarkerType "hd_dot";
      _debug setMarkerText _txt;	
  };
};


                  