// Ultra simple vehicle tracker script
// version 1.55
// by nkenny

/*
version 1.0
- Inception 

version 1.1
- Added support for single soldiers
- Update list periodically

version 1.2
- Tweaked range
- Removed X for dead units

version 1.3
- Check if marker is made already? 

version 1.4 
- 'nil' markers removed! 
- Gave markers "nk_m_" prefix 

version 1.5
- Added variables for cohesion and distance
- Added variable for update frequency

version 1.55
- Tweaked Removed group distance modifier

version 1.6
- Is now tuned to groups. 
- Alpha change based on distance removed
- Extended range of vehicles which are automatically detected
- New marker deletion system 

  
*/
if (!hasinterface) exitWith {};
waitUntil {time > 0};

// init
nk_cohesion_mod = 500; 
nk_distance_mod = 1000; 
nk_update_Freq = 1; 

// If there is no var_trackthese, make one. 
if (isnil "var_trackthese") then {var_trackthese = []};

// list of tracked units
nk_tracklist = [];

// FUNCTIONS -------------------------------------------- 

// Add unit marker
nk_addUnitMarker =  
{
  private ["_veh","_txt","_m"];
  _veh = _this select 0;
  _txt = if (count _this > 1) then {_this select 1} else {""}; 
 
  _m = createMarkerLocal ["nk_m_"+str(_veh),getpos _veh];
  _m setMarkerShapeLocal "Icon";
  _m setMarkerColorLocal "ColorWEST";
  _m setMarkerTypeLocal "mil_dot_noshadow";

  // Small for men!
  if (_veh isKindOf "Man") then {_m setmarkerSizeLocal [0.4,0.4]};
    
  // For vehicles...
  if (_veh isKindOf "LandVehicle") then {_m setMarkerTypeLocal "b_motor_inf"};
  if (_veh isKindOf "Air") then {_m setMarkerTypeLocal "b_air"};
  if (_veh isKindOf "Plane") then {_m setMarkerTypeLocal "b_plane"};
  if (_veh isKindOf "Tank") then {_m setMarkerTypeLocal "b_mech_inf"};
  if (_veh isKindOf "Ship") then {_m setMarkerTypeLocal "b_naval"};
  
  // optional colour
  if (count _this > 3) then {_m setmarkerColorLocal (_this select 3);};

  // optional type
  if (count _this > 2) then {_m setMarkerTypeLocal (_this select 2);_m setmarkerSizeLocal [1.0,1.0]}; 
 
  // optional text
  if (count _this > 1) then {_m setMarkerTextLocal (_this select 1);};
  
  // Add to list
  nk_tracklist pushbackunique _veh;  
 
  // Return marker 
  _m 
};

// ADD RELEVANT VEHICLES  ------------------------------- 
{0 =[_x select 0,_x select 1] call nk_addUnitMarker;} foreach var_trackthese;

// ADD PLAYERS CYCLE  ----------------------------------- 
[] spawn 
  {
    while {true} do 
    {
      {if (_x in nk_tracklist) then {} else {0 =[_x,""] call nk_addUnitMarker;}} foreach (playableunits + switchableunits - entities "Headless_F");
      sleep 20; 
    };
  }; 

// TRACKING MAGIC ---------------------------------------

while {true} do
{
                WaitUntil {time > 0};
                waitUntil {count nk_tracklist > 0};
                //WaitUntil {visibleMap};

                // UPDATE VEHICLE LOCATIONS
                {
                  _m = ("nk_m_"+ str(_x));
                  // update it
                  _m setmarkerposlocal getpos _x;
                  
                  // black it if no crew
                  if (count crew _x < 1) then {_m setMarkerColorLocal "ColorBlack";} else {_m setMarkerColorLocal "ColorWEST";}; 
                  
                  // delete if dead or missing? 
                  if (isNull _x) then {nk_tracklist = nk_tracklist - [_x];deleteMarkerLocal _m;};
 /*                 
                  // Leader
                  if (_x isKindOf "Man") then 
                    {
                      if (leader group _x == _x && (isNull objectParent _x)) then {_m setMarkerTypeLocal "b_inf";_m setMarkerTextLocal (GroupID group _x);_m setMarkerSizeLocal [1,1];} else {_m setMarkerTextLocal "";_m setMarkerTypeLocal "mil_dot_noshadow";_m setMarkerSizeLocal [0.4,0.4];};
                      if (typeOf _x == "B_Officer_F") then {_m setMarkerTypeLocal "b_hq";}; 
                    }; 
*/					
                } foreach nk_tracklist;
                uisleep nk_update_Freq;
};