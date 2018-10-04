

if (!isServer) exitWith {};


_veh = _this select 0;

#include "..\cfg_player.sqf";


clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;


// add new shit
_veh addMagazineCargoGlobal [(_SMG_Ammo select 0), 10];
_veh addMagazineCargoGlobal [(_FlareGun_Ammo select 1), 4];
_veh addMagazineCargoGlobal [(_Rifle_Ammo select 0), 8];
_veh addMagazineCargoGlobal [(_Rifle_Ammo_T select 0), 8];
_veh addMagazineCargoGlobal [(_MMG_Ammo select 0), 2];


_veh addMagazineCargoGlobal [(_Grenade_Smoke select 0), 4];
_veh addMagazineCargoGlobal [(_Grenade_Smoke select 1), 2];
_veh addItemCargoGlobal ["ACE_HandFlare_Green", 4];

_veh addItemCargoGlobal ["FirstAidKit", 5];
_veh addItemCargoGlobal ["Toolkit", 1];
_veh addItemCargoGlobal [_ACRE_MMR, 1];
_veh addBackpackCargoGlobal ["B_Parachute",2];