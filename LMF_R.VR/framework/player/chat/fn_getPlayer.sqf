// GET PLAYER FUNCTION ////////////////////////////////////////////////////////////////////////////
/*
	* Author: cuel, G4rrus
	* URL: https://github.com/fparma/fparma-mods/blob/master/addons/common/functions/fnc_getPlayer.sqf
	* Takes string (player name, full or partial) and see if it matches any players.
	*
	* Arguments:
	* 0: Name <STRING>
	*
	* Example:
	* [name player] call lmf_player_fnc_getPlayer;
	*
	* Return Value:
	* <OBJECT> either first matching player or objNull if nothing is found.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_name"];


// FIND MATCHING PLAYERS //////////////////////////////////////////////////////////////////////////
private _matches = [];
{
	if ([_name, name _x] call BIS_fnc_inString) then {
		_matches pushBack _x;
	};
} forEach ([] call CBA_fnc_players);
if (count _matches == 1) exitWith {_matches select 0};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
objNull