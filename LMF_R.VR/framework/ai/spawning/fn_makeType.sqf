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
	switch (toUpper _type) do {
		case "SQUAD": {_selection = selectRandom _squad};
		case "SENTRY": {_selection = selectRandom _sentry};
		case "ATTEAM": {_selection = selectRandom _atteam};
		case "AATEAM": {_selection = selectRandom _aateam};
		case "MGTEAM": {_selection = selectRandom _mgteam};
		case "CREW": {_selection = _vehicleCrew};
		case "HCREW": {_selection = _heliCrew};
		case "STATIC": {_selection = _staticCrew};

		case "CAR": {_selection = selectRandom _car};
		case "CARARMED": {_selection = selectRandom _carArmed};
		case "TRUCK": {_selection = selectRandom _truck};
		case "APC": {_selection = selectRandom _apc};
		case "TANK": {_selection = selectRandom _tank};
		case "HELITRANSPORT": {_selection = selectRandom _heli_Transport};
		case "HELIATTACK": {_selection = selectRandom _heli_Attack};

		default {_selection = selectRandom _team};
	}
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_selection