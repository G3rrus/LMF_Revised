

if (!isServer) exitWith {};


_veh = _this select 0;

#include "..\cfg_player.sqf";


clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;


if ((_SMG_Ammo select 0) != "") then {_veh addMagazineCargoGlobal [(_SMG_Ammo select 0), 6 + (random 6)];};
if ((_Grenade_Smoke select 0) != "") then {_veh addMagazineCargoGlobal [(_Grenade_Smoke select 0), 2 + (random 2)];};
_veh addItemCargoGlobal ["Toolkit",1];