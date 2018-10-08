// APPLY SETTINGS TO DEFINED AIR VICS /////////////////////////////////////////////////////////////
/*
	- This file handles what happens on creation of player defined air vehicles.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_air",objNull,[objNull]]];
if (isNull _air) exitWith {};

#include "..\..\settings\cfg_Player.sqf"


// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _air;
clearMagazineCargoGlobal _air;
clearItemCargoGlobal _air;
clearBackpackCargoGlobal _air;

//ADD NEW ITEMS