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
_unit forceAddUniform selectRandom _Uniform;
_unit addVest selectRandom _Vest;
_unit addBackpack selectRandom _Backpack_Leader;
_unit addHeadgear selectRandom _Headgear_L;
if (_Goggles#0 !=  "") then {
	removeGoggles _unit;
	_unit addGoggles selectRandom _Goggles;
};

//RADIO SETUP
if !(var_tfar) then {
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadioAcreFlagged";
	_unit addItem _Radio_L;
	if (var_personalRadio) then {
		_unit addItem _Radio_R;
	};
} else {
	_unit linkItem "ItemWatch";
	_unit linkItem _Radio_L;
};

//LINKED ITEMS
if (var_playerMaps != 2) then {
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit addItem "ACE_Flashlight_XL50";
};
if (var_playerNVG == 0) then {_unit linkItem _NVG};

//ITEMS
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};
for "_i" from 1 to 5 do {_unit addItem _Rifle_Ammo;};
for "_i" from 1 to 3 do {_unit addItem _Rifle_Ammo_T;};
for "_i" from 1 to 2 do {_unit addItem _Grenade;};
_unit addItem _Grenade_Smoke;
for "_i" from 1 to 2 do {_unit addItem _Grenade_Smoke_Grn;};
for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};

//WEAPONS
_unit addWeapon _Rifle;
_unit addPrimaryWeaponItem _Rifle_Attach1;
_unit addPrimaryWeaponItem _Rifle_Attach2;
_unit addPrimaryWeaponItem _Rifle_Optic;
_unit addPrimaryWeaponItem _Rifle_Bipod;

_unit addWeapon _Pistol;
_unit addHandgunItem _Pistol_Attach1;
_unit addHandgunItem _Pistol_Attach2;

_unit addWeapon _Binocular;

//TRAITS
_unit setUnitTrait ["medic",false];
_unit setUnitTrait ["engineer",false];

//RANK
_unit setRank "SERGEANT";