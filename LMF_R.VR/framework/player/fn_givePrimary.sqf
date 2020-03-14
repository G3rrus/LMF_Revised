// GIVE CORRECT PRIMARY WEAPON TO PLAYER //////////////////////////////////////////////////////////
/*
	- This file handles which primary and ammo a player gets.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull],["_weapon",3]];
if !(local _unit) exitWith {};

#include "..\..\settings\cfg_Player.sqf"

// APPLY CORRECT WEAPON ///////////////////////////////////////////////////////////////////////////
private _amount = 5;

switch (_weapon) do {
	case 1: {
		if (_SMG_Ammo select 0 == "") then {_SMG_Ammo = 0;} else {_SMG_Ammo = selectRandom _SMG_Ammo};
		[_unit, selectRandom _SMG, 5, _SMG_Ammo] call BIS_fnc_addWeapon;
		_unit addPrimaryWeaponItem (selectRandom _SMG_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _SMG_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _SMG_Optic);
		_unit addPrimaryWeaponItem (selectRandom _SMG_Bipod);
	};
	case 2: {
		if (_Carbine_Ammo select 0 == "") then {_Carbine_Ammo = 0; _amount = 8;} else {_Carbine_Ammo = selectRandom _Carbine_Ammo};
		[_unit, selectRandom _Carbine, _amount, _Carbine_Ammo] call BIS_fnc_addWeapon;
		for "_i" from 1 to 3 do {_unit addItem (selectRandom _Carbine_Ammo_T);};
		_unit addPrimaryWeaponItem (selectRandom _Carbine_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _Carbine_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _Carbine_Optic);
		_unit addPrimaryWeaponItem (selectRandom _Carbine_Bipod);
	};
	case 3: {
		if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0; _amount = 8;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
		[_unit, selectRandom _Rifle, _amount, _Rifle_Ammo] call BIS_fnc_addWeapon;
		for "_i" from 1 to 3 do {_unit addItem (selectRandom _Rifle_Ammo_T);};
		_unit addPrimaryWeaponItem (selectRandom _Rifle_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_Optic);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_Bipod);
	};
	case 4: {
		if (_Rifle_GL_Ammo select 0 == "") then {_Rifle_GL_Ammo = 0; _amount = 8;} else {_Rifle_GL_Ammo = selectRandom _Rifle_GL_Ammo};
		[_unit, selectRandom _Rifle_GL, _amount, _Rifle_GL_Ammo] call BIS_fnc_addWeapon;
		for "_i" from 1 to 3 do {_unit addItem (selectRandom _Rifle_GL_Ammo_T);};
		for "_i" from 1 to 6 do {_unit addItem (selectRandom _Rifle_GL_UGL1);};
		for "_i" from 1 to 4 do {_unit addItem (selectRandom _Rifle_GL_UGL2);};
		for "_i" from 1 to 2 do {_unit addItem (selectRandom _Rifle_GL_UGL3);};
		for "_i" from 1 to 2 do {_unit addItem (selectRandom _Rifle_GL_UGL4);};
		_unit addPrimaryWeaponItem (selectRandom _Rifle_GL_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_GL_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_GL_Optic);
		_unit addPrimaryWeaponItem (selectRandom _Rifle_GL_Bipod);
	};
	case 5: {
		if (_DMR_Ammo select 0 == "") then {_DMR_Ammo = 0;} else {_DMR_Ammo = selectRandom _DMR_Ammo};
		[_unit, selectRandom _DMR, 8, _DMR_Ammo] call BIS_fnc_addWeapon;
		_unit addPrimaryWeaponItem (selectRandom _DMR_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _DMR_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _DMR_Optic);
		_unit addPrimaryWeaponItem (selectRandom _DMR_Bipod);
	};
	case 6: {
		if (_LMG_Ammo select 0 == "") then {_LMG_Ammo = 0; _amount = 5;} else {_LMG_Ammo = selectRandom _LMG_Ammo; _amount = 3;};
		[_unit, selectRandom _LMG, _amount, _LMG_Ammo] call BIS_fnc_addWeapon;
		for "_i" from 1 to 2 do {_unit addItem (selectRandom _LMG_Ammo_T);};
		_unit addPrimaryWeaponItem (selectRandom _LMG_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _LMG_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _LMG_Optic);
		_unit addPrimaryWeaponItem (selectRandom _LMG_Bipod);
	};
	case 7: {
		if (_MMG_Ammo select 0 == "") then {_MMG_Ammo = 0;} else {_MMG_Ammo = selectRandom _MMG_Ammo};
		[_unit, selectRandom _MMG, 3, _MMG_Ammo] call BIS_fnc_addWeapon;
		_unit addPrimaryWeaponItem (selectRandom _MMG_Attach1);
		_unit addPrimaryWeaponItem (selectRandom _MMG_Attach2);
		_unit addPrimaryWeaponItem (selectRandom _MMG_Optic);
		_unit addPrimaryWeaponItem (selectRandom _MMG_Bipod);
	};
}