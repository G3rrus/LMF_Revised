// ARES ZEUS FUNCTIONS  ///////////////////////////////////////////////////////////////////////////
/*
	- If Ares-Achilles is on this file will create several zeus modules in the spawn sections to
	  spawn AI performing various tasks.
	- Ares modules development halted, please use the addon ZEN instead!
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//GARRISON
LMF_groupTypes = ["TEAM", "SQUAD", "SENTRY","ATTEAM","AATEAM", "MGTEAM","Custom amount"];
["Spawn", "LMF Spawn AI Garrison", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Garrison",
		[
			["Group Type or Number", LMF_groupTypes],
			["Custom amount", "OPTION", "10"],
			["Garrison Radius", "RADIUS", "100"],
			["Fill Evenly", ["YES", "NO"], 1]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option", "_amount", "_radius", "_distribution"];
	if (_option == ((count LMF_groupTypes - 1))) then {
		_option = parseNumber _amount;
	} else {
		_option = LMF_groupTypes select _option;
	};

	//CALL FUNCTION
	[_pos, _option, parseNumber _radius, _distribution] remoteExec ["lmf_ai_fnc_garrison"];
}] call Ares_fnc_RegisterCustomModule;

//HUNTER
["Spawn", "LMF Spawn AI Hunter", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Hunter",
		[
			["Group Type or Number", LMF_groupTypes],
			["Custom amount", "OPTION", "10"],
			["Hunter Radius", "RADIUS", "500"],
			["Spawn Tickets", "NUMBER", "1"]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option", "_amount", "_radius", "_tickets"];
	if (_option == ((count LMF_groupTypes - 1))) then {
		_option = parseNumber _amount;
	} else {
		_option = LMF_groupTypes select _option;
	};

	//CALL FUNCTION
	[_pos, _option, parseNumber _radius, parseNumber _tickets] remoteExec ["lmf_ai_fnc_infantryHunter"];
}] call Ares_fnc_RegisterCustomModule;

//INFANTRY QRF
["Spawn", "LMF Spawn AI Infantry QRF", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Infantry QRF",
		[
			["Group Type or Number", LMF_groupTypes],
			["Custom amount", "OPTION", "10"],
			["Spawn Tickets", "Number", "1"]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option", "_amount", "_tickets"];
	if (_option == ((count LMF_groupTypes - 1))) then {
		_option = parseNumber _amount;
	} else {
		_option = LMF_groupTypes select _option;
	};

	//CALL FUNCTION
	[_pos, _option, parseNumber _tickets] remoteExec ["lmf_ai_fnc_infantryQRF"];
}] call Ares_fnc_RegisterCustomModule;

//PARATROOPER QRF
["Spawn", "LMF Spawn AI Para QRF", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CALL FUNCTION
	[_pos] remoteExec ["lmf_ai_fnc_paraQRF"];
}] call Ares_fnc_RegisterCustomModule;

//PATROL
["Spawn", "LMF Spawn AI Patrol", {
	//SPAWNPOS
	private _pos = _this select 0;

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Patrol",
		[
			["Group Type or Number", LMF_groupTypes],
			["Custom amount", "OPTION", "10"],
			["Patrol Radius", "RADIUS", "100"]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option", "_amount", "_radius"];
	if (_option == ((count LMF_groupTypes - 1))) then {
		_option = parseNumber _amount;
	} else {
		_option = LMF_groupTypes select _option;
	};

	//CALL FUNCTION
	[_pos, _option, parseNumber _radius] remoteExec ["lmf_ai_fnc_patrol"];
}] call Ares_fnc_RegisterCustomModule;

//VEHICLE QRF
["Spawn", "LMF Spawn AI Vehicle QRF", {
	//SPAWNPOS
	private _pos = _this select 0;
	private _options = ["CAR","CARARMED","TRUCK","APC","TANK","HELITRANSPORT","HELIATTACK"];

	//CHOSE OPTIONS
	private _dialogResult = [
		"LMF Spawn AI Vehicle QRF",
		[
			["Vehicle Type", _options, 2],
			["Spawn Tickets", "TICKETS", "1"],
			["Respawn Timer", "TIMER", "300"]
		]
	] call Ares_fnc_ShowChooseDialog;

	//PROCESS OPTIONS
	if (_dialogResult isEqualTo []) exitWith {};
	_dialogResult params ["_option","_tickets","_timer"];

	//CALL FUNCTION
	[_pos, _options select _option, parseNumber _tickets, parseNumber _timer] remoteExec ["lmf_ai_fnc_vehicleQRF"];
}] call Ares_fnc_RegisterCustomModule;

//GIVE GEAR
["Spawn", "LMF Player Gear",
{
	//GET PASSED PARAMS
	params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

	//EXIT IF NO UNIT UNDER CURSOR
	if (isNull _objectUnderCursor) exitWith {systemChat "Kill Target: No Unit!"};

	//IF THERE IS AN OBJECT TRY TO GIVE IT A LOADOUT
	[_objectUnderCursor] remoteExec ["lmf_player_fnc_initPlayerGear"];

}] call Ares_fnc_RegisterCustomModule;