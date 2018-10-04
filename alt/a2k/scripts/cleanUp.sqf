// CLEAN UP SCRIPT
// version 1.0
// by nkenny


if (!isServer) exitWith {};
if (getMarkerColor "mrk_cleanup" == "") exitWith {};
"mrk_cleanup" setMarkerAlpha 0;

// Settings --------------------------------
_pos = getMarkerPos "mrk_cleanup";
_range = getMarkerSize "mrk_cleanup" select 0;
_cycle = 60;
_list = ["WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated","TimeBombCore","SmokeShell"];


waitUntil {!isNil "var_warmup"};
waitUntil {!var_warmup;};
sleep 5;

// The magic -------------------------------
while {true} do 
{
// Dead bodies
{if ((_x isKindOf "Man") AND (_x distance _pos < _range)) then {deleteVehicle _x}} forEach allDead;

// Wrecks
{if ((damage _x == 1) AND (_x distance _pos < _range)) then {deleteVehicle _x}} forEach vehicles;
  
// Small items
{
 { 	 
  deletevehicle _x; 
 } forEach (_pos nearObjects [_x, _range]);
} forEach _list;

//add time to cycle
_cycle = _cycle + 5;
if (_cycle > 300) then {_cycle = 300};

// wait
sleep _cycle;  
};