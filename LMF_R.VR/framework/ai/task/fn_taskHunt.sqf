// AI TASK HUNT ///////////////////////////////////////////////////////////////////////////////////
/*
	* Author: nkenny, diwako, Alex2k, G4rrus
	* Makes AI hunt down players once in given radius.
	* Note: Needs to be local to the group.
    * Player position is known 'magically'.
	*
	* Arguments:
	* 0: Group <GROUP>
    * 1: Radius <NUMBER>
	*
	* Example:
	* [group cursorObject, 500] spawn lmf_ai_fnc_taskHunt;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]],["_radius",500,[123]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _grp || {!local _grp}) exitWith {};

private _cycle = 30;
_grp setBehaviour "SAFE";
_grp enableGunLights "ForceOff";
_grp allowFleeing 0;
_grp enableAttack false;


// DO THE HUNTING /////////////////////////////////////////////////////////////////////////////////
while {count units _grp > 0} do {
	private _tracker = leader _grp;
	private _nearestdist = _radius;
	private _availabletargets = (switchableUnits + playableUnits - entities "HeadlessClient_F");
	private _nearest = objNull;

	//CHOOSE CLOSEST TARGET
	{
		private _dist = vehicle _x distance2D _tracker;
		if ((_dist < _nearestdist) && {(side _x != civilian) && {((getposATL _x) select 2 < 25) && {isPlayer _x}}}) then {
			_nearest = _x;
			_nearestdist = _dist;
		};
	} forEach _availabletargets;

	//ORDERS
	if !(isNull _nearest) then {
		private _units = units _grp;
		{
			private _targetPos = getposATL _nearest;
			private _number = _nearestdist/4;
			private _rallypoint = [(_targetPos select 0) - (_number/2) + random _number, (_targetPos select 1) - (_number/2) + random _number, _targetPos select 2];
			_x doMove _rallypoint;
			_x disableAI "AUTOCOMBAT";
		} count _units;

		_grp setbehaviourstrong "AWARE";
		_grp setSpeedMode "FULL";
		_grp enableGunLights "ForceOn";

		_cycle = _nearestdist/8;

		//DEBUG
		if (var_debug) then {systemChat format ["DEBUG: taskHunt: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
	} else {
		_cycle = 120;
	};

	//WAIT
	_cycle = _cycle min 300;
	_cycle = _cycle max 30;
	sleep _cycle;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////