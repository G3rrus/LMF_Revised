// DELEGATE AI SPAWNING FUNCTION  /////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Delegate spawning to a HC if available otherwise spawn on server.
	* Note: Needs to be called on the Server.
	*
	* Arguments:
	* 0: Arguments <ARRAY> in format ["_type","_argument1","_argumentN"]
	* Note: Possible _types are: "barricades", "garrison", "hunter", "qrf", "para", "patrol", "staticqrf", "vicqrf"
	*
	* Example:
	* ["qrf", position player, "TEAM", 1] spawn lmf_ai_fnc_doSpawn;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(isServer) exitWith {};
waitUntil {CBA_missionTime > 0};

params [["_type","qrf",[""]]];

private _hcs = entities "HeadlessClient_F";
private _argsArray = _this - [(_this#0)];
_type = toLower _type;


// HC OR SERVER SPAWN /////////////////////////////////////////////////////////////////////////////
if (count _hcs < 1) then {
	switch (_type) do {
		case "barricades": {_argsArray spawn lmf_ai_fnc_barricades;};
		case "garrison": {_argsArray spawn lmf_ai_fnc_garrison;};
		case "hunter": {_argsArray spawn lmf_ai_fnc_infantryHunter;};
		case "qrf": {_argsArray spawn lmf_ai_fnc_infantryQRF;};
		case "para": {_argsArray spawn lmf_ai_fnc_paraQRF;};
		case "patrol": {_argsArray spawn lmf_ai_fnc_patrol;};
		case "staticqrf": {_argsArray spawn lmf_ai_fnc_staticQRF;};
		case "vicqrf": {_argsArray spawn lmf_ai_fnc_vehicleQRF;};
	};
} else {
	["lmf_hcSpawn", [_type,_argsArray],selectRandom _hcs] call CBA_fnc_targetEvent;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////