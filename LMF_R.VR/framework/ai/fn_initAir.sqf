// INIT AI AIR VICS ///////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Apply vehicle specific code to AI air vehicles.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Vehicle <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_ai_fnc_initAir;
	*
	* Return Value:
	* <BOOL> true if settings were applied else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_air",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _air || {!local _air}) exitWith {false};

#include "..\..\settings\cfg_AI.sqf"

private _type = typeOf _air;


// APPLY GENERAL SETTINGS /////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _air;
clearMagazineCargoGlobal _air;
clearItemCargoGlobal _air;
clearBackpackCargoGlobal _air;

//REMOVE AMMO
{_air removeMagazines _x;} count _ammoBlacklist;


// APPLY VEHICLE SPECIFIC SETTINGS ////////////////////////////////////////////////////////////////
if (_heli_Transport findIf {_type == _x} != -1) exitWith {
	if !(_heli_Transport_Camo isEqualTo [""]) then {
		_heli_Transport_Camo = selectRandom _heli_Transport_Camo;
		[_air,[_heli_Transport_Camo,1]] call BIS_fnc_initVehicle;
	};
	_air setVehicleLock "LOCKEDPLAYER";
	true
};

if (_heli_Attack findIf {_type == _x} != -1) exitWith {
	if !(_heli_Attack_Camo isEqualTo [""]) then {
		_heli_Attack_Camo = selectRandom _heli_Attack_Camo;
		[_air,[_heli_Attack_Camo,1]] call BIS_fnc_initVehicle;
	};
	_air setVehicleLock "LOCKEDPLAYER";
	true
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true