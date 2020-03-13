// AI SPAWNER PICKER //////////////////////////////////////////////////////////////////////////////
/*
	- This file is included in the XEH_preInit.sqf.
	- It adds CBA events. One of which can be called as a server event that will automatically handle if
	  AI spawning functions should be called on the server or on a headless by the other event.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//SERVER AND HEADLESS AI SPAWNING EVENT
if (isServer || {!hasInterface}) then {
	["lmf_doSpawn", {
		_this call lmf_ai_fnc_doSpawn;
	}] call CBA_fnc_addEventHandler;
};

//AI SPAWNING DELEGATION SERVER EVENT
if (isServer) then {
	["lmf_spawnAI", {
		params ["_args"];
		private _hcs = entities "HeadlessClient_F";
		if ((count _hcs) > 0) then {
			["lmf_doSpawn", [_args], selectRandom _hcs] call CBA_fnc_targetEvent;
		} else {
			["lmf_doSpawn", [_args]] call CBA_fnc_localEvent;
		};
	}] call CBA_fnc_addEventHandler;
};