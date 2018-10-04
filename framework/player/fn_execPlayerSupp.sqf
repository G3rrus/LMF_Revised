// APPLY SETTINGS TO DEFINED GROUND VICS //////////////////////////////////////////////////////////

// START THE FUNCTION /////////////////////////////////////////////////////////////////////////////
params [["_var_supp",objNull,[objNull]]];
if (isNull _var_supp) exitWith {};

#include "..\..\settings\cfg_Player.sqf"



// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//CLEAR CARGO
clearWeaponCargoGlobal _var_supp;
clearMagazineCargoGlobal _var_supp;
clearItemCargoGlobal _var_supp;
clearBackpackCargoGlobal _var_supp;