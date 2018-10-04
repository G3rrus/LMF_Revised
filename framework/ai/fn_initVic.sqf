// APPLY SETTINGS TO  DEFINED GROUND VICS /////////////////////////////////////////////////////////

// START THE FUNCTION /////////////////////////////////////////////////////////////////////////////
params [["_var_vic",objNull,[objNull]]];
if (isNull _var_vic) exitWith {};

#include "..\..\settings\cfg_AI.sqf"



// CHECK WHO GETS WHAT GEAR ///////////////////////////////////////////////////////////////////////
private _type = typeOf _var_vic;



// APPLY GENERAL SETTINGS /////////////////////////////////////////////////////////////////////////
//MAKE CREW IMMOBILE
if (80 > random 100) then {_var_vic allowCrewInImmobile true;};

//CLEAR CARGO
clearWeaponCargoGlobal _var_vic;
clearMagazineCargoGlobal _var_vic;
clearItemCargoGlobal _var_vic;
clearBackpackCargoGlobal _var_vic;

//REMOVE AMMO
{_var_vic removeMagazines _x;} forEach _ammoBlacklist;



// APPLY VEHICLE SPECIFIC SETTINGS ////////////////////////////////////////////////////////////////
if (_car findIf {_type == _x} != -1) then {
	if !(_car_Camo isEqualTo [""]) then {
		_car_Camo = selectRandom _car_Camo;
		[_var_vic,[_car_Camo,1]] call BIS_fnc_initVehicle;
	};
};

if (_carArmed findIf {_type == _x} != -1) then {
	if !(_carArmed_Camo isEqualTo [""]) then {
		_carArmed_Camo = selectRandom _carArmed_Camo;
		[_var_vic,[_carArmed_Camo,1]] call BIS_fnc_initVehicle;
	};
};

if (_truck findIf {_type == _x} != -1) then {
	if !(_truck_Camo isEqualTo [""]) then {
		_truck_Camo = selectRandom _truck_Camo;
		[_var_vic,[_truck_Camo,1]] call BIS_fnc_initVehicle;
	};
};

if (_apc findIf {_type == _x} != -1) then {
	if !(_apc_Camo isEqualTo [""]) then {
		_apc_Camo = selectRandom _apc_Camo;
		[_var_vic,[_apc_Camo,1]] call BIS_fnc_initVehicle;
	};
	_var_vic setVehicleLock "LOCKEDPLAYER";
};

if (_tank findIf {_type == _x} != -1) then {
	if !(_tank_Camo isEqualTo [""]) then {
		_tank_Camo = selectRandom _tank_Camo;
		[_var_vic,[_tank_Camo,1]] call BIS_fnc_initVehicle;
	};
	_var_vic setVehicleLock "LOCKEDPLAYER";
};