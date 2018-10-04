// SORTING FUNCTION FOR CAMANBASE UNITS ///////////////////////////////////////////////////////////

//SELECT UNIT
private _var_unit = _this select 0;

//EXIT IF NOT LOCAL
if !(local _var_unit) exitWith {};

//SORT
if  !(isPlayer _var_unit) then {
	if (side group _var_unit != var_enemySide) exitWith {};
    [_var_unit] call lmf_ai_fnc_initAI;
		if(!(isGroupDeletedWhenEmpty group _var_unit)) then {
    		(group _var_unit) deleteGroupWhenEmpty true;
		};
}
else {
    if( _var_unit == player) then {};
};