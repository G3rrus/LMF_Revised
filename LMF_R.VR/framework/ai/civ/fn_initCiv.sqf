// INIT AI CIV ////////////////////////////////////////////////////////////////////////////////////
/*
	* Author: diwako
	* Handle civilian panic behavior.
	* Note: Needs to be local to the object.
	* To blacklist a unit from panic behavior:
	* this setVariable ["lmf_ai_civ_cannotPanic",true]
	*
	* Arguments:
	* 0: Unit <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_ai_civ_fnc_initCiv;
	*
	* Return Value:
	* <BOOL> true if behavior handling applies else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_unit",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _unit || {!local _unit}) exitWith {false};

//IF CIV IS ALREADY IN PANIC
if (_unit getVariable ["lmf_ai_civ_paniced",false]) exitWith {true};


// EHS ////////////////////////////////////////////////////////////////////////////////////////////
private _id = _unit addEventHandler ["FiredNear",{
	_this call lmf_ai_civ_fnc_firedNear;
}];
_unit setVariable ["lmf_ai_civ_fired_near_EH", _id];

//LOKAL EH (To remove and reapply all EHs if locality changes.)
private _id = _unit addEventHandler ["Local", {
	params ["_unit"];
	_unit removeEventHandler ["FiredNear", _unit getVariable ["lmf_ai_civ_fired_near_EH", -1]];
	_unit removeEventHandler ["Local", _unit getVariable ["lmf_ai_civ_local_EH" ,-1]];

	//REAPPLY EHS
	["lmf_ai_civ_listener", [_unit], _unit] call CBA_fnc_targetEvent;
}];
_unit setvariable ["lmf_ai_civ_local_EH", _id];


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true