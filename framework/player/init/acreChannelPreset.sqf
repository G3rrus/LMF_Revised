// ACRE CHANNEL PRESET ////////////////////////////////////////////////////////////////////////////
/*
    - File that presets the SR channel for selected infantry groups.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
waitUntil {([] call acre_api_fnc_isInitialized)};

private _id = groupID group player;

if (_id == "FOX6") exitWith {
	[(["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 6] call acre_api_fnc_setRadioChannel;
};

if (_id == "FOX1") exitWith {
	[(["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 1] call acre_api_fnc_setRadioChannel;
};

if (_id == "FOX2") exitWith {
	[(["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 2] call acre_api_fnc_setRadioChannel;
};

if (_id == "FOX3") exitWith {
	[(["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 3] call acre_api_fnc_setRadioChannel;
};

if (_id == "FOX4") exitWith {
	[(["ACRE_PRC343"] call acre_api_fnc_getRadioByType), 4] call acre_api_fnc_setRadioChannel;
};