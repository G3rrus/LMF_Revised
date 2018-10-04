// APPLY SETTINGS TO DEFINED PLAYER AIR VICS //////////////////////////////////////////////////////

// START THE FUNCTION /////////////////////////////////////////////////////////////////////////////
params [["_var_air",objNull,[objNull]]];
if (isNull _var_air) exitWith {};

#include "..\..\settings\cfg_Player.sqf"



// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _var_air;
clearMagazineCargoGlobal _var_air;
clearItemCargoGlobal _var_air;
clearBackpackCargoGlobal _var_air;