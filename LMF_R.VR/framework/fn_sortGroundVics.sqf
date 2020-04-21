// SORTING FUNCTION FOR GROUND VEHICLES ///////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Sort between potential AI and Player ground vehicles and execute their respective functions.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Vehicle <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_common_fnc_sortGroundVics;
	*
	* Return Value:
	* <BOOL> true if settings were applied, else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_vic",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _vic || {!local _vic}) exitWith {false};


// SORT ///////////////////////////////////////////////////////////////////////////////////////////
#include "..\settings\cfg_AI.sqf"
private _type = typeOf _vic;
private _groundVics = [_car, _carArmed, _truck, _apc, _tank];

//AI DEFINED VEHICLES
if (
	(_groundVics select 0) findif {_type == _x} != -1 ||
	{(_groundVics select 1) findif {_type == _x} != -1 ||
	{(_groundVics select 2) findif {_type == _x} != -1 ||
	{(_groundVics select 3) findif {_type == _x} != -1 ||
	{(_groundVics select 4) findif {_type == _x} != -1 }}}}
) exitWith {
	[_vic] call lmf_ai_fnc_initVic;
};

//PLAYER DEFINED VEHICLES
if !(var_playerGear) exitWith {false};
if (_type == var_vic1 || {_type == var_vic2 || {_type == var_vic3 || {_type == var_vic4}}}) exitWith {
	[_vic] call lmf_player_fnc_initPlayerVic;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
false