// PROXIMITY CHECKER //////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Return if player in 2D proximity of position.
	*
	* Arguments:
	* 0: Position <POSITION>
	* 1: Radius <NUMBER>
	*
	* Example:
	* [position cursorObject, 500] call lmf_ai_fnc_proxyCheck;
	*
	* Return Value:
	* <NUMBER> 0 if no proximity breach, 1 for air or 2 for ground
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [
	["_pos",[0,0,0],[[]],[2,3]],
	["_range",500,[123]]
];

private _close = 0;


// CHECK WHO AND WHAT IS CLOSE ////////////////////////////////////////////////////////////////////
private _targetsToCheck = (switchableUnits + playableUnits - entities "HeadlessClient_F");
_targetsToCheck = _targetsToCheck select {
	!(side _x isEqualTo CIVILIAN)
	&& {_x distance2D _pos < _range}
};

if (_targetsToCheck isEqualTo []) exitWith {_close};

if (_targetsToCheck findIf {(getPosATL _x) select 2 < 75} isEqualTo -1) exitWith {
	_close = 1;
	_close
};

_close = 2;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_close