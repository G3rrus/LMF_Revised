// SPAWN WRECKS!
// version 1.6
// by nkenny, adapted work by h8maker

/*
v1.6
- Updated for framework
- Added arguments
  1. Position
  2. Number of spawns   Default 12
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
_pos = (_this select 0) call bis_fnc_position; ; 

// SETTINGS
_carSpawns= param [1,12];
_range = param [2,100];
_wrecklist = 
          [
            "Land_Wreck_BMP2_F",
            "Land_Wreck_Skodovka_F",
            "Land_Wreck_CarDismantled_F",
            "Land_Wreck_Truck_F",
            "Land_Wreck_Car2_F",
            "Land_Wreck_Car_F",
            "Land_Wreck_Car3_F",
            "Land_Wreck_Offroad_F",
            "Land_Wreck_Offroad2_F",
            "Land_Wreck_UAZ_F",
            "Land_Wreck_Ural_F",
            "Land_Wreck_Truck_dropside_F",
            "Land_Wreck_Van_F",
            "Land_GarbagePallet_F",
            "Land_GarbageWashingMachine_F",
            "Land_GarbageBags_F",
            "Land_GarbageHeap_01_F",
            "Land_GarbageHeap_02_F",
            "Land_GarbageHeap_03_F",
            "Land_GarbageHeap_04_F",
            "Land_ScrapHeap_1_F",
            "Land_ScrapHeap_2_F"
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
for "_i" from 0 to (_carSpawns-1) do 
{

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
 _trash = createVehicle ["Land_Garbage_square5_F", _currentRoad, [], 0, "CAN_COLLIDE"]; //"NONE"
 addToRemainsCollector [_veh,_trash];
  
  // DEBUG
  if (_showroads) then {
      _txt=format ["Veh:%1",_i];
      _debug=createMarker [_txt,_currentRoad];
      _debug setMarkerShape "ICON";
      _debug setMarkerType "hd_dot";
      _debug setMarkerText _txt;	
  };
};


                  