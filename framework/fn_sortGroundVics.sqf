// SORTING FUNCTION FOR GROUND VEHICLES ///////////////////////////////////////////////////////////

//SELECT UNIT
private _var_vic = _this select 0;

//EXIT IF NOT LOCAL
if !(local _var_vic) exitWith {};

//WHICH VEHICLES CONTINUE?
#include "..\settings\cfg_AI.sqf"
private _type = typeOf _var_vic;
private _groundVics = [_car, _carArmed, _truck, _apc, _tank];

//AI DEFINED VEHICLES
if (
	(_groundVics select 0) findif {_type == _x} != -1 ||
	{(_groundVics select 1) findif {_type == _x} != -1 ||
	{(_groundVics select 2) findif {_type == _x} != -1 ||
	{(_groundVics select 3) findif {_type == _x} != -1 ||
	{(_groundVics select 4) findif {_type == _x} != -1 }}}}
) then {[_var_vic] call lmf_ai_fnc_initVic;};

//PLAYER DEFINED VEHICLES
if (_type == var_vic1 || {_type == var_vic2 || {_type == var_vic3 || {_type == var_vic4}}}) then {
	[_var_vic] call lmf_player_fnc_initPlayerVic;
};