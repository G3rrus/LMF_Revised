// SORTING FUNCTION FOR AIR VEHICLES //////////////////////////////////////////////////////////////

//SELECT UNIT
private _var_air = _this select 0;

//EXIT IF NOT LOCAL
if !(local _var_air) exitWith {};

//WHICH VEHICLES CONTINUE?
#include "..\settings\cfg_AI.sqf"
private _type = typeOf _var_air;
private _AirVics = [_heli_Transport, _heli_Attack, _plane];

//AI DEFINED VEHICLES
if (
	(_AirVics select 0) findif {_type == _x} != -1 ||
	{(_AirVics select 1) findif {_type == _x} != -1 ||
	{(_AirVics select 2) findif {_type == _x} != -1 }}
) then {[_var_air] call lmf_ai_fnc_initAir;};

//PLAYER VEHICLES
if (_type == var_air1 || {_type == var_air2 || {_type == var_air3 || {_type == var_air4}}}) then {
	[_var_air] call lmf_player_fnc_initPlayerAir;
};