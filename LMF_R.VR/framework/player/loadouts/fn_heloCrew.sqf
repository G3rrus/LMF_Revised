// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	- This file is a player gear loadout file.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull]];
if !(local _unit) exitWith {};

#include "..\..\..\settings\cfg_Player.sqf"


// APPLY NEW ROLE SPECIFIC LOADOUT ////////////////////////////////////////////////////////////////
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;

//CLOTHING
_unit forceAddUniform selectRandom _Heli_Uniform;
_unit addVest selectRandom _Heli_Vest;
_unit addBackpack selectRandom _Backpack_Pilot;
_unit addHeadgear selectRandom _Heli_Headgear_C;
if (_Goggles#0 !=  "") then {
	removeGoggles _unit;
	_unit addGoggles selectRandom _Goggles;
};

//RADIO SETUP
if (var_personalRadio) then {
	if !(var_tfar) then {
		_unit linkItem "ItemWatch";
		_unit linkItem "ItemRadioAcreFlagged";
		_unit addItem _Radio_R;
	} else {
		_unit linkItem _Radio_R;
		_unit linkItem "TFAR_microdagr";
	};
} else {
	_unit linkItem "ItemWatch";
};

//LINKED ITEMS
if (var_playerMaps == 0) then {
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit addItem "ACE_Flashlight_XL50";
};
if (var_playerNVG == 0) then {_unit linkItem _NVG};

//ITEMS
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};
for "_i" from 1 to 5 do {_unit addItem _Carbine_Ammo;};

//WEAPONS
_unit addWeapon _Carbine;
_unit addPrimaryWeaponItem _Carbine_Attach1;
_unit addPrimaryWeaponItem _Carbine_Attach2;
_unit addPrimaryWeaponItem _Carbine_Optic;
_unit addPrimaryWeaponItem _Carbine_Bipod;

if (var_pistolAll) then {
	for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};
	_unit addWeapon _Pistol;
	_unit addHandgunItem _Pistol_Attach1;
	_unit addHandgunItem _Pistol_Attach2;
};

//TRAITS
_unit setUnitTrait ["medic",false];
_unit setUnitTrait ["engineer",false];

//RANK
_unit setRank "SERGEANT";