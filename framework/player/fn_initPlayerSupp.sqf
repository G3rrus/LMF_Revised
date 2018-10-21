// APPLY SETTINGS TO DEFINED SUPPLY CRATES ////////////////////////////////////////////////////////
/*
	- This file handles what happens on creation of player defined supply crates.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_supp",objNull,[objNull]]];
if (isNull _supp) exitWith {};

#include "..\..\settings\cfg_Player.sqf"


// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _supp;
clearMagazineCargoGlobal _supp;
clearItemCargoGlobal _supp;
clearBackpackCargoGlobal _supp;

//ADD NEW ITEMS
if (typeOf _supp == var_supSmall) exitWith {
	if ((_Carbine_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_Carbine_Ammo select 0), 15];};
	if ((_Rifle_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_Ammo select 0), 15];};
	if ((_Rifle_GL_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_GL_Ammo select 0), 15];};
	if ((_LMG_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_LMG_Ammo select 0), 4];};
	if ((_MMG_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_MMG_Ammo select 0), 4];};
	if ((_MAT_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_MAT_Ammo select 0), 4];};
	if ((_Rifle_GL_HE select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_GL_HE select 0), 4];};
	if ((_Grenade select 0) != "") then {_supp addMagazineCargoGlobal [(_Grenade select 0), 4];};
	if ((_Grenade_Smoke select 0) != "") then {_supp addMagazineCargoGlobal [(_Grenade_Smoke select 0), 4];};
};

if (typeOf _supp == var_supLarge) exitWith {
	if ((_Carbine_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_Carbine_Ammo select 0), 40];};
	if ((_Rifle_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_Ammo select 0), 40];};
	if ((_Rifle_GL_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_GL_Ammo select 0), 40];};
	if ((_LMG_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_LMG_Ammo select 0), 10];};
	if ((_MMG_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_MMG_Ammo select 0), 10];};
	if ((_MAT_Ammo select 0) != "") then {_supp addMagazineCargoGlobal [(_MAT_Ammo select 0), 10];};
	if ((_Rifle_GL_HE select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_GL_HE select 0), 20];};
	if ((_Rifle_GL_Flare select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_GL_Flare select 0), 30];};
	if ((_Rifle_GL_Smoke_Grn select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_GL_Smoke_Grn select 0), 10];};
	if ((_Rifle_GL_Smoke_Red select 0) != "") then {_supp addMagazineCargoGlobal [(_Rifle_GL_Smoke_Red select 0), 10];};
	if ((_Grenade select 0) != "") then {_supp addMagazineCargoGlobal [(_Grenade select 0), 10];};
	if ((_Grenade_Smoke select 0) != "") then {_supp addMagazineCargoGlobal [(_Grenade_Smoke select 0), 10];};

	if ((_LAT select 0) != "") then {_supp addWeaponCargoGlobal [(_LAT select 0), 6];};

	_supp addItemCargoGlobal ["ACE_Wirecutter",5];
};

if (typeOf _supp == var_supSpecial) exitWith {

};

if (typeOf _supp == var_supExplosives) exitWith {
	_supp addItemCargoGlobal ["DemoCharge_Remote_Mag", 8];
	_supp addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2];
	_supp addItemCargoGlobal ["ACE_M26_Clacker",2];

	if ((_Backpack_Light select 0) != "") then {_supp addBackpackCargoGlobal [(_Backpack_Light select 0), 2];};
};