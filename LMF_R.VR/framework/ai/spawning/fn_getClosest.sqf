// GET CLOSEST PLAYER /////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Return Closest non civilian player.
	*
	* Arguments:
	* 0: Group <OBJECT or GROUP>
	* 1: Radius <NUMBER>
	*
	* Example:
	* [group cursorObject, 500] call lmf_ai_fnc_getClosest;
	*
	* Return Value:
	* <OBJECT> objNull if no player found within radius
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [
	["_tracker",objNull,[objNull,grpNull]],
	["_radius",500,[123]]
];

_tracker = leader _tracker;


// FIND CLOSEST TARGET ////////////////////////////////////////////////////////////////////////////
private _availabletargets = (switchableUnits + playableUnits - entities "HeadlessClient_F");
_availabletargets = _availabletargets select {
    !(side _x isEqualTo CIVILIAN)
    && {_x distance2D _tracker < _radius}
    && {(getPosATL _x) select 2 < 100}
};

//CHOOSE CLOSEST TARGET
if (_availabletargets isEqualTo []) exitWith {objNull};
private _nearestdist = _radius;
private _nearest = objNull;
{
	private _dist = vehicle _x distance2D _tracker;
	if (_dist < _nearestdist) then {
		_nearest = _x;
		_nearestdist = _dist;
	};
} forEach _availabletargets;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_nearest