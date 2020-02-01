// UNGARRISON (FIRED NEAR EH) FUNCTION //////////////////////////////////////////////////////////////
/*
  - by alex2k
	- This function called in the firedNear EH applied to all defined AI handles what happens if
	  the (garrisoned) AI has weapons nearby firing.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit","_firer"];

if (alive _unit) then {
	//NEARBY ENEMY FIRE
	if (side _firer != var_enemySide) exitWith {
		if (50 > random 100) then {
			[[_unit]] call ace_ai_fnc_unGarrison;
			if (50 > random 100 && {_unit knowsAbout _firer > 1}) then {
				_unit doMove (getPosATL _firer);}
			;
		};
	};
	//OWN FIRE
	if (_firer == _unit) exitWith {
		if (50 > random 100) then {
			[[_unit]] call ace_ai_fnc_unGarrison;
		};
	};
	//NEARBY FRIENDLY FIRE
	if (_firer != _unit && {side _firer == var_enemySide}) exitWith {
		if (20 > random 100) then {
			[[_unit]] call ace_ai_fnc_unGarrison;
			_unit doMove (getPosATL _firer);
		};
	};
};