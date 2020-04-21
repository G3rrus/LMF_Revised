// SORTING FUNCTION FOR CAMANBASE UNITS ///////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Sort between infantry units and execute their respective functions.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Unit <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_common_fnc_sortUnits;
	*
	* Return Value:
	* <BOOL> true if settings were applied, else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _unit || {!local _unit}) exitWith {false};


// SORT ///////////////////////////////////////////////////////////////////////////////////////////
if  !(isPlayer _unit) exitWith {
	private _side = side group _unit;
	if (_side == civilian && {var_civPanic}) exitWith {["lmf_ai_civ_listener", [_unit]] call CBA_fnc_localEvent;};
	if (_side != var_enemySide) exitWith {false};
	group _unit deleteGroupWhenEmpty true;
	[_unit] call lmf_ai_fnc_initMan;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
false