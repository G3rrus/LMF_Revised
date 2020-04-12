// GET PLAYER FUNCTION ////////////////////////////////////////////////////////////////////////////
/*
    - by cuel.
    - takes string (player name, full or partial) and returns player object or objNull if nothing is found.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
params ["_name"];
private _matches = [];
{
  if ([_name, name _x] call BIS_fnc_inString) then {
    _matches pushBack _x;
  };
} forEach ([] call CBA_fnc_players);

if (count _matches == 1) exitWith {_matches select 0};
objNull