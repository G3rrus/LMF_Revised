// APPLY SETTINGS TO DEFINED GROUND VICS //////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Apply vehicle specific code to player ground vehicles.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Vehicle <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_player_fnc_initPlayerVic;
	*
	* Return Value:
	* <BOOL> true if settings were applied else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_vic",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _vic || {!local _vic}) exitWith {false};

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


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true