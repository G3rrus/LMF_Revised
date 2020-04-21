// SORTING FUNCTION FOR AIR VEHICLES //////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Sort between potential AI and Player air vehicles and execute their respective functions.
	* Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Vehicle <OBJECT>
	*
	* Example:
	* [cursorObject] call lmf_common_fnc_sortAirVics;
	*
	* Return Value:
	* <BOOL> true if settings were applied, else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_air",objNull,[objNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _air || {!local _air}) exitWith {false};


// SORT ///////////////////////////////////////////////////////////////////////////////////////////
#include "..\settings\cfg_AI.sqf"
private _type = typeOf _air;
private _AirVics = [_heli_Transport, _heli_Attack];

//AI DEFINED VEHICLES
if (
	(_AirVics select 0) findif {_type == _x} != -1 ||
	{(_AirVics select 1) findif {_type == _x} != -1}
) exitWith {
	[_air] call lmf_ai_fnc_initAir;
};

//PLAYER VEHICLES
if !(var_playerGear) exitWith {false};
if (_type == var_air1 || {_type == var_air2 || {_type == var_air3 || {_type == var_air4}}}) exitWith {
	[_air] call lmf_player_fnc_initPlayerAir;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
false