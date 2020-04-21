// ACRE CHANNEL PRESET ////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Set ACRE short range frequency depending on group ID.
	* Note: Needs to be local to the player.
	*
	* Arguments:
	* 0: <NONE>
	*
	* Example:
	* [] spawn lmf_loadout_fnc_acreChannelPreset;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {([] call acre_api_fnc_isInitialized)};

private _id = groupID group player;
private _personalRadio = ["ACRE_PRC343"] call acre_api_fnc_getRadioByType;

//EXIT IF NO RADIO OR NOT LOCAL
if (!local player || {isNil "_personalRadio"}) exitWith {};


// APPLY CHANNEL IF RADIO /////////////////////////////////////////////////////////////////////////
if (_id == "PLT HQ") exitWith {
	[_personalRadio, 6] call acre_api_fnc_setRadioChannel;
};

if (_id == "ALPHA") exitWith {
	[_personalRadio, 1] call acre_api_fnc_setRadioChannel;
};

if (_id == "BRAVO") exitWith {
	[_personalRadio, 2] call acre_api_fnc_setRadioChannel;
};

if (_id == "CHARLIE") exitWith {
	[_personalRadio, 3] call acre_api_fnc_setRadioChannel;
};

if (_id == "DELTA") exitWith {
	[_personalRadio, 4] call acre_api_fnc_setRadioChannel;
};

if (_id == "ECHO") exitWith {
	[_personalRadio, 5] call acre_api_fnc_setRadioChannel;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////