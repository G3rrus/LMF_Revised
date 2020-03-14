// APPLY SETTINGS TO DEFINED GROUND VICS //////////////////////////////////////////////////////////
/*
	- This file handles what happens on creation of player defined ground vehicles.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_vic",objNull,[objNull]]];
if (isNull _vic) exitWith {};

#include "..\..\settings\cfg_Player.sqf"


// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _vic;
clearMagazineCargoGlobal _vic;
clearItemCargoGlobal _vic;
clearBackpackCargoGlobal _vic;

//ADD NEW ITEMS
if ((_Carbine_Ammo#0) != "") then {_vic addMagazineCargoGlobal [(selectRandom _Carbine_Ammo),5 + (random 10)];};
if ((_Rifle_Ammo#0) != "") then {_vic addMagazineCargoGlobal [(selectRandom _Rifle_Ammo),5 + (random 10)];};
if ((_Rifle_GL_Ammo#0) != "") then {_vic addMagazineCargoGlobal [(selectRandom _Rifle_GL_Ammo),5 + (random 10)];};
if ((_LMG_Ammo#0) != "") then {_vic addMagazineCargoGlobal [(selectRandom _LMG_Ammo),2 + (random 4)];};
if ((_MMG_Ammo#0) != "") then {_vic addMagazineCargoGlobal [(selectRandom _MMG_Ammo),2 + (random 4)];};
if ((_Grenade#0) != "") then {_vic addMagazineCargoGlobal [(selectRandom _Grenade),1 + (random 2)];};
if ((_Grenade_Smoke#0) != "") then {_vic addMagazineCargoGlobal [(selectRandom _Grenade_Smoke),1 + (random 2)];};
if ((_LAT_Ammo#0) != "") then {_vic addMagazineCargoGlobal [(selectRandom _LAT_Ammo),2];};

if ((_LAT#0) != "") then {_vic addWeaponCargoGlobal [(selectRandom _LAT),2];};

_vic addItemCargoGlobal ["Toolkit",1];

if ((_Backpack_Light#0) != "") then {_vic addBackpackCargoGlobal [(selectRandom _Backpack_Light),1];};