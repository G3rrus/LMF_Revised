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
_unit forceAddUniform selectRandom _Plane_Uniform;
_unit addVest selectRandom _Plane_Vest;
_unit addBackpack selectRandom _Backpack_Pilot;
_unit addHeadgear selectRandom _Plane_Headgear;
if (_Goggles#0 !=  "") then {
	removeGoggles _unit;
	_unit addGoggles selectRandom _Goggles;
};

//LINKED ITEMS
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadioAcreFlagged";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
if (var_playerNVG != 2) then {_unit linkItem _NVG_Pilot};

//ITEMS
_unit addItem _ACRE_ITR;
if (var_personalRadio) then {_unit addItem _ACRE_PRR};
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};
_unit addItem "ACE_Flashlight_XL50";
for "_i" from 1 to 4 do {_unit addItem _FlareGun_Ammo;};
for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};

//WEAPONS
_unit addWeapon _Pistol;
_unit addHandgunItem _Pistol_Attach1;
_unit addHandgunItem _Pistol_Attach2;

_unit addItemToBackpack _FlareGun;

//TRAITS
_unit setUnitTrait ["medic",false];
_unit setUnitTrait ["engineer",true];

//RANK
_unit setRank "CAPTAIN";