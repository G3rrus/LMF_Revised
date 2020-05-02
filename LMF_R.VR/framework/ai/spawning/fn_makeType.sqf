// MAKE GROUP TYPE ////////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Return Array filled with selection of soldiers used to spawn a group.
	*
	* Arguments:
	* 0: Type <STRING or NUMBER>
	*
	* Example:
	* ["TEAM"] call lmf_ai_fnc_makeType;
	*
	* Return Value:
	* <ARRAY> filled with type of soldier defined in cfg_spawn.sqf
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_type","TEAM",["",123]]];

#include "cfg_spawn.sqf"


// MAKE GROUP /////////////////////////////////////////////////////////////////////////////////////
private _selection = [];
if (_type isEqualType 0) then {
	for "_i" from 1 to (floor (_type)) do {
		_selection pushback (selectRandom _soldier);
	};
}
else {
	toUpper _type;
	if (_type == "SQUAD") exitWith {_selection = selectRandom _squad};
	if (_type == "SENTRY") exitWith {_selection = selectRandom _sentry};
	if (_type == "ATTEAM") exitWith {_selection = selectRandom _atteam};;
	if (_type == "AATEAM") exitWith {_selection = selectRandom _aateam};
	if (_type == "MGTEAM") exitWith {_selection = selectRandom _mgteam};
	_selection = selectRandom _team;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_selection