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
	if ((_Carbine_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Carbine_Ammo),15];};
	if ((_Rifle_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_Ammo),15];};
	if ((_Rifle_GL_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_GL_Ammo),15];};
	if ((_LMG_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _LMG_Ammo),4];};
	if ((_MMG_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _MMG_Ammo),4];};
	if ((_MAT_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _MAT_Ammo),4];};
	if ((_Rifle_GL_UGL1#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_GL_UGL1),4];};
	if ((_Grenade#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Grenade),4];};
	if ((_Grenade_Smoke#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Grenade_Smoke),4];};
	if ((_Grenade_Smoke_Clr#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Grenade_Smoke_Clr),4];};
};

if (typeOf _supp == var_supLarge) exitWith {
	if ((_Carbine_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Carbine_Ammo),40];};
	if ((_Rifle_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_Ammo),40];};
	if ((_Rifle_GL_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_GL_Ammo),40];};
	if ((_DMR_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _DMR_Ammo),10];};
	if ((_LMG_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _LMG_Ammo),10];};
	if ((_MMG_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _MMG_Ammo),10];};
	if ((_MAT_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _MAT_Ammo),10];};
	if ((_Rifle_GL_UGL1#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_GL_UGL1),20];};
	if ((_Rifle_GL_UGL2#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_GL_UGL2),30];};
	if ((_Rifle_GL_UGL3#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_GL_UGL3),10];};
	if ((_Rifle_GL_UGL4#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Rifle_GL_UGL4),10];};
	if ((_Grenade#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Grenade),10];};
	if ((_Grenade_Smoke#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Grenade_Smoke),10];};
	if ((_Grenade_Smoke_Grn#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Grenade_Smoke_Grn),10];};
	if ((_LAT_Ammo#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _LAT_Ammo),6];};

	if ((_LAT#0) != "") then {_supp addWeaponCargoGlobal [(selectRandom _LAT),6];};

	_supp addItemCargoGlobal ["ACE_Wirecutter",5];
};

if (typeOf _supp == var_supSpecial) exitWith {
	_supp addMagazineCargoGlobal ["TrainingMine_Mag",10];
	_supp addMagazineCargoGlobal ["Chemlight_blue",20];
	_supp addMagazineCargoGlobal ["Chemlight_green",20];
	_supp addMagazineCargoGlobal ["Chemlight_red",20];
	_supp addMagazineCargoGlobal ["ACE_Chemlight_HiRed",20];
	_supp addMagazineCargoGlobal ["ACE_Chemlight_HiWhite",20];
	_supp addMagazineCargoGlobal ["ACE_Chemlight_HiYellow",20];
	_supp addMagazineCargoGlobal ["ACE_HandFlare_Green",20];
	_supp addMagazineCargoGlobal ["ACE_HandFlare_Red",20];
	_supp addMagazineCargoGlobal ["ACE_HandFlare_White",20];
	_supp addMagazineCargoGlobal ["ACE_HandFlare_Yellow",20];
	_supp addMagazineCargoGlobal ["ACE_M84",10];

	_supp addItemCargoGlobal ["ACE_RangeTable_82mm",2];
	_supp addItemCargoGlobal ["ACE_RangeCard",5];
	_supp addItemCargoGlobal ["ACE_CableTie",20];
	_supp addItemCargoGlobal ["ACE_wirecutter",5];
	_supp addItemCargoGlobal ["ACE_DefusalKit",5];
	_supp addItemCargoGlobal ["ACE_EntrenchingTool",5];
	_supp addItemCargoGlobal ["ACE_Fortify",5];
	_supp addItemCargoGlobal ["ACE_HuntIR_monitor",5];
	_supp addItemCargoGlobal ["ACE_IR_Strobe_Item",20];
	_supp addItemCargoGlobal ["ACE_Clacker",5];
	_supp addItemCargoGlobal ["ACE_Flashlight_XL50",20];
	_supp addItemCargoGlobal ["ACE_MapTools",5];

	_supp addItemCargoGlobal ["ACRE_PRC117F",5];
	_supp addItemCargoGlobal ["ACRE_PRC148",10];
	_supp addItemCargoGlobal ["ACRE_PRC152",10];
	_supp addItemCargoGlobal ["ACRE_PRC343",20];

	_supp addItemCargoGlobal ["TFAR_anprc152", 10];
	_supp addItemCargoGlobal ["TFAR_rf7800str", 20];
	_supp addItemCargoGlobal ["TFAR_microdagr",20];
	if (_Backpack_RTO#0 != "") then {_supp addBackpackCargoGlobal [_Backpack_RTO,5];};

	_supp addItemCargoGlobal ["acc_pointer_IR",20];
	_supp addItemCargoGlobal ["acc_flashlight",20];
	_supp addItemCargoGlobal ["ACE_VectorDay",5];
	_supp addItemCargoGlobal ["ItemGPS",5];

	if ((_Backpack_Light#0) != "") then {_supp addBackpackCargoGlobal [(selectRandom _Backpack_Light),5];};
};

if (typeOf _supp == var_supExplosives) exitWith {
	if ((_Explosive_Small#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Explosive_Small),8];};
	if ((_Explosive_Large#0) != "") then {_supp addMagazineCargoGlobal [(selectRandom _Explosive_Large),2];};
	_supp addItemCargoGlobal ["ACE_M26_Clacker",2];

	if ((_Backpack_Light#0) != "") then {_supp addBackpackCargoGlobal [(selectRandom _Backpack_Light),2];};
};