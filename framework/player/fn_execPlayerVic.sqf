// APPLY SETTINGS TO DEFINED GROUND VICS //////////////////////////////////////////////////////////

// START THE FUNCTION /////////////////////////////////////////////////////////////////////////////
params [["_var_vic",objNull,[objNull]]];
if (isNull _var_vic) exitWith {};

#include "..\..\settings\cfg_Player.sqf"



// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _var_vic;
clearMagazineCargoGlobal _var_vic;
clearItemCargoGlobal _var_vic;
clearBackpackCargoGlobal _var_vic;