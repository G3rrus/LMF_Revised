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
_unit forceAddUniform selectRandom _Crew_Uniform;
_unit addVest selectRandom _Crew_Vest;
_unit addBackpack selectRandom _Backpack_Crew;
_unit addHeadgear selectRandom _Crew_Headgear;
if (_Goggles#0 !=  "") then {
	removeGoggles _unit;
	_unit addGoggles selectRandom _Goggles;
};

//LINKED ITEMS
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadioAcreFlagged";
if (var_playerMaps != 2) then {
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit addItem "ACE_Flashlight_XL50";
};
if (var_playerNVG == 0) then {_unit linkItem _NVG};

//ITEMS
_unit addItem _ACRE_ITR;
if (var_personalRadio) then {_unit addItem _ACRE_PRR};
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};
for "_i" from 1 to 5 do {_unit addItem _SMG_Ammo;};

//WEAPONS
_unit addWeapon _SMG;
_unit addPrimaryWeaponItem _SMG_Attach1;
_unit addPrimaryWeaponItem _SMG_Attach2;
_unit addPrimaryWeaponItem _SMG_Optic;
_unit addPrimaryWeaponItem _SMG_Bipod;

if (var_pistolAll) then {
	for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};
	_unit addWeapon _Pistol;
	_unit addHandgunItem _Pistol_Attach1;
	_unit addHandgunItem _Pistol_Attach2;
};

_unit addWeapon _Binocular;

//TRAITS
_unit setUnitTrait ["medic",false];
_unit setUnitTrait ["engineer",true];

//RANK
_unit setRank "SERGEANT";