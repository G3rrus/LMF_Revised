// APPLY SETTINGS TO  DEFINED AIR VICS ////////////////////////////////////////////////////////////

// START THE FUNCTION /////////////////////////////////////////////////////////////////////////////
params [["_var_air",objNull,[objNull]]];
if (isNull _var_air) exitWith {};

#include "..\..\settings\cfg_AI.sqf"



// CHECK WHO GETS WHAT GEAR ///////////////////////////////////////////////////////////////////////
private _type = typeOf _var_air;



// APPLY GENERAL SETTINGS /////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _var_air;
clearMagazineCargoGlobal _var_air;
clearItemCargoGlobal _var_air;
clearBackpackCargoGlobal _var_air;

//REMOVE AMMO
{_var_air removeMagazines _x;} forEach _ammoBlacklist;



// APPLY VEHICLE SPECIFIC SETTINGS ////////////////////////////////////////////////////////////////
if (_heli_Transport findIf {_type == _x} != -1) then {
	if !(_heli_Transport_Camo isEqualTo [""]) then {
		_heli_Transport_Camo = selectRandom _heli_Transport_Camo;
		[_var_air,[_heli_Transport_Camo,1]] call BIS_fnc_initVehicle;
		_var_air setVehicleLock "LOCKEDPLAYER";
	};
};

if (_heli_Attack findIf {_type == _x} != -1) then {
	if !(_heli_Attack_Camo isEqualTo [""]) then {
		_heli_Attack_Camo = selectRandom _heli_Attack_Camo;
		[_var_air,[_heli_Attack_Camo,1]] call BIS_fnc_initVehicle;
	};
	_var_air setVehicleLock "LOCKEDPLAYER";
};

if (_plane findIf {_type == _x} != -1) then {
	if !(_plane_Camo isEqualTo [""]) then {
		_plane_Camo = selectRandom _plane_Camo;
		[_var_air,[_plane_Camo,1]] call BIS_fnc_initVehicle;
	};
	_var_air setVehicleLock "LOCKEDPLAYER";
};