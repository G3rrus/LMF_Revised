// SORTING FUNCTION FOR SUPPLIES //////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Sort between potential Player supply crates and execute their function.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Crate <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_common_fnc_sortSupplies;
	*
	* Return Value:
	* <BOOL> true if settings were applied, else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_supp",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL OR PLAYER HASN'T DEFINED CUSTOM GEAR
if (isNull _supp || {!local _supp || {!var_playerGear}}) exitWith {false};


// SORT ///////////////////////////////////////////////////////////////////////////////////////////
private _type = typeof _supp;
private _allSupplies = [var_supSmall,var_supLarge,var_supSpecial,var_supExplosives];
if (_allSupplies findIf {_type == _x} == -1) exitWith {false};

[_supp] call lmf_player_fnc_initPlayerSupp;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////