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