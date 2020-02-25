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
_unit addBackpack selectRandom _Backpack_Engineer;
_unit addHeadgear selectRandom _Headgear;
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
for "_i" from 1 to 3 do {_unit addItem _Carbine_Ammo_T;};
for "_i" from 1 to 2 do {_unit addItem _Grenade;};
for "_i" from 1 to 6 do {_unit addItem _Grenade_Smoke;};
_unit addItem "ToolKit";
_unit addItem "ACE_M26_Clacker";
for "_i" from 1 to 4 do {_unit addItemToBackpack _Explosive_Large;};
for "_i" from 1 to 2 do {_unit addItemToBackpack _Explosive_Small;};

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
_unit setUnitTrait ["engineer",true];

//RANK
_unit setRank "PRIVATE";