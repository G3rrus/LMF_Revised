// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Apply Loadout.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Unit <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_loadout_fnc_medic;
	*
	* Return Value:
	* <BOOL> true if settings were applied, else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _unit || {!local _unit}) exitWith {false};

#include "..\..\..\settings\cfg_Player_2.sqf"


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
_unit addVest selectRandom _Vest_M;
_unit addBackpack selectRandom _Backpack_Medic;
_unit addHeadgear selectRandom _Headgear;
if (_Goggles#0 !=  "") then {
	removeGoggles _unit;
	_unit addGoggles selectRandom _Goggles;
};

//RADIO SETUP
if (var_personalRadio) then {
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadioAcreFlagged";
	_unit addItem _Radio_R;
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

//PRIMARY
[_unit,_Gun_Cls] call lmf_loadout_fnc_givePrimary;

//ITEMS
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};
for "_i" from 1 to 2 do {_unit addItem (selectRandom _Grenade);};
for "_i" from 1 to 6 do {_unit addItem (selectRandom _Grenade_Smoke);};
_unit addItem "ACE_personalAidKit";
for "_i" from 1 to 15 do {_unit addItem "ACE_packingBandage";};
for "_i" from 1 to 15 do {_unit addItem "ACE_elasticBandage";};
for "_i" from 1 to 15 do {_unit addItem "ACE_fieldDressing";};
for "_i" from 1 to 10 do {_unit addItem "ACE_quikclot";};
for "_i" from 1 to 10 do {_unit addItem "ACE_morphine";};
for "_i" from 1 to 10 do {_unit addItem "ACE_epinephrine";};
for "_i" from 1 to 6 do {_unit addItem "ACE_tourniquet";};
for "_i" from 1 to 6 do {_unit addItem "ACE_splint";};
for "_i" from 1 to 10 do {_unit addItem "ACE_salineIV";};

//SIDEARM
if (var_pistolAll) then {
	if (_Pistol_Ammo select 0 == "") then {_Pistol_Ammo = 0;} else {_Pistol_Ammo = selectRandom _Pistol_Ammo};
	[_unit, selectRandom _Pistol, 3, _Pistol_Ammo] call BIS_fnc_addWeapon;
	_unit addHandgunItem (selectRandom _Pistol_Attach1);
	_unit addHandgunItem (selectRandom _Pistol_Attach2);
};

//TRAITS
_unit setUnitTrait ["medic",true];
_unit setUnitTrait ["engineer",false];

//RANK
_unit setRank "CORPORAL";


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true