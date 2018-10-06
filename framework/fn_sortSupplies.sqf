// SORTING FUNCTION FOR PLAYER SUPPLIES ///////////////////////////////////////////////////////////

//SELECT UNIT
private _supp = _this select 0;

//EXIT IF NOT LOCAL OR PLAYER HASN'T DEFINED CUSTOM GEAR
if !(local _supp) exitWith {};
if !(var_playerGear) exitWith {};

//WHICH SUPPLIES ARE AFFECTED?
private _type = typeof _supp;
if (_type != var_supSmall && {_type != var_supLarge}) exitWith {};

//CALL THE FUNCTION
[_supp] call lmf_player_fnc_initPlayerSupp;