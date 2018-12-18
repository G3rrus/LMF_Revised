// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	- This file is a player gear loadout file.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull]];
if !(local _unit) exitWith {};

#include "..\..\..\settings\cfg_Player.sqf"


// APPLY NEW ROLE SPECIFIC LOADOUT ////////////////////////////////////////////////////////////////
_unit setUnitLoadout [
	[
		[_Rifle_GL,_Rifle_GL_Attach1,_Rifle_GL_Attach2,_Rifle_GL_Optic,[],[],_Rifle_GL_Bipod],
		[],
		[],
		[(selectRandom _Uniform),[]],
		[selectRandom _Vest,[[_Rifle_GL_Ammo,5,999],[_Rifle_GL_Ammo_T,3,999],[_Rifle_GL_HE,5,99],[_Rifle_GL_Flare,5,99],[_Grenade,2,1],[_Grenade_Smoke,1,1],[_Grenade_Smoke_Grn,2,1]]],
		[(selectRandom _Backpack_Light),[]],(selectRandom _Headgear),(selectRandom _Goggles),
		[_Binocular,"","","",[],[],""],
		["","","ItemRadioAcreFlagged","","ItemWatch",""]
	],true
];

//RADIO
if (var_personalRadio) then {_unit addItem _ACRE_PRR};

//MAP
if (var_playerMaps != 2) then {
	_unit linkItem "ItemMap";
	_unit linkItem "ItemCompass";
	_unit addItem "ACE_Flashlight_XL50";
};

//REST
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};

//NVG
if (var_playerNVG == 0) then {_unit linkItem _NVG};

//PISTOL
if (var_pistolAll) then {
	_unit addWeapon _Pistol;
	_unit addHandgunItem _Pistol_Attach1;
	_unit addHandgunItem _Pistol_Attach2;
	for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};
};

//RANK
_unit setRank "CORPORAL";