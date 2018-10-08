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