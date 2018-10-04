// SORTING FUNCTION FOR PLAYER SUPPLIES ///////////////////////////////////////////////////////////

//SELECT UNIT
private _var_supp = _this select 0;

//EXIT IF NOT LOCAL
if !(local _var_supp) exitWith {};

//WHICH SUPPLIES ARE AFFECTED?
private _type = typeof _var_supp;
if (_type != var_supSmall && {_type != var_supLarge}) exitWith {};

//CALL THE FUNCTION
[_var_supp] call lmf_fnc_execPlayerSupp;