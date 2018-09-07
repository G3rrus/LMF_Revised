// CREATE GOATS OR SHEEP OR CHICKENS
// version 1.2
// MUAHAHAHHAa
// by nkenny

/*
version v1.2 
Total rewrite 

Find locations
Run 1 to 3 animals on it
*/

waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};

waitUntil {CBA_missionTime > 2};

fn_goats = 
{
  private ["_pos"];
  _pos = (_this select 0);
  _center = createCenter sideLogic;    
  _group = createGroup _center;
  _select = SelectRandom ["Goat_random_F","Sheep_Random_F","Hen_random_F"];
  _goats = _group createUnit ["ModuleAnimals_F",_pos , [], 0, ""];   
  _goats setVariable ["count",ceil (random 10),true]; 
  _goats setVariable ["type", _select,true];  
}; 

// Init
_pos = (_this select 0) call bis_fnc_position;
_units = ceil (random 3);

// get realpos
_o = "Land_Baseball_01_F" createVehicle _pos;
_rp = getposATL _o;

for "_i" from 1 to _units do 
  {
    // Find locations
    _npos = [(_rp select 0) + 100 - (random 200),(_rp select 1) + 100 - (random 200),(_rp select 2)];

    // Create em
    _baaah = [_npos] call fn_goats; 
   }; 

// Debug
if (var_debug) then {systemchat format ["DEBUG-GOAT : %1 Units created",_units];}; 

// End