// APPLY SETTINGS TO DEFINED AIR VICS /////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Apply vehicle specific code to player air vehicles.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Vehicle <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_player_fnc_initPlayerAir;
	*
	* Return Value:
	* <BOOL> true if settings were applied else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_air",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _air || {!local _air}) exitWith {false};

#include "..\..\settings\cfg_Player.sqf"


// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _air;
clearMagazineCargoGlobal _air;
clearItemCargoGlobal _air;
clearBackpackCargoGlobal _air;

//ADD NEW ITEMS
if ((_SMG_Ammo#0) != "") then {_air addMagazineCargoGlobal [(selectRandom _SMG_Ammo),5 + (random 10)];};
if ((_Grenade_Smoke#0) != "") then {_air addMagazineCargoGlobal [(selectRandom _Grenade_Smoke),2 + (random 2)];};

_air addItemCargoGlobal ["Toolkit",1];

if ((_Backpack_Light#0) != "") then {_air addBackpackCargoGlobal [(selectRandom _Backpack_Light),1];};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true