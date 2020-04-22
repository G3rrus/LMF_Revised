// AI TASK ASSAULT FUNCTION ///////////////////////////////////////////////////////////////////////
/*
	* Author: nkenny, Alex2k, G4rrus, diwako
	* Makes AI assault targets rather aggressively if in range.
	* Note: Needs to be local to the group.
    *
	* Arguments:
	* 0: Group <GROUP>
    * 1: Range <NUMBER>
	*
	* Example:
	* [group cursorObject, 500] spawn lmf_ai_fnc_taskAssault;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]],["_range",500,[123]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _grp || {!local _grp}) exitWith {};

private _cycle = 30;
_grp enableIRLasers false;
_grp enableGunLights "ForceOff";


// START THE ASSAULT SCRIPT ///////////////////////////////////////////////////////////////////////
while {count units _grp > 0} do {
	private _tracker = leader _grp;
	private _nearestdist = _range;
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

		//DISMOUNT VEHICLES
		if !(isNull objectParent leader _grp) then {
			{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
			private _wp1 =_grp addWaypoint [getPos leader _grp, 0];
			_wp1 setWaypointType "GETOUT";
			private _wp2 =_grp addWaypoint [getPos leader _grp, 0];
			_wp2 setWaypointType "GUARD";
			sleep 10;
		};

		//MOVE IN
		if (_nearestdist < 150) then {
			if (_tracker knowsAbout _nearest > 1) then {
				{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
				{_x doMove (getposATL _nearest);} count units _grp;
				{_x enableAttack false;} count units _grp;
				_grp enableIRLasers true;
				if (20 > (random 100)) then {_grp enableGunLights "ForceOn"};
			};
		};

		//AGGRESSIVE WHEN CLOSE
		if (_nearestdist < 50) then {
			{deleteWaypoint ((wayPoints _grp) select 0);} count wayPoints _grp;
			{_x doMove (getposATL _nearest);} count units _grp;
			{
				_x disableAI "FSM";
				_x disableAI "COVER";
				_x disableAI "SUPPRESSION";
			} count units _grp;
			_grp setbehaviourstrong "AWARE";
			{_x enableAttack false;} count units _grp;
			_grp enableIRLasers true;
			_grp enableGunLights "ForceOn";
		};

		//REGULAR WHEN FURTHER OUT
		if (_nearestdist > 150) then {
			{
				_x enableAI "FSM";
				_x enableAI "COVER";
				_x enableAI "SUPPRESSION";
			} count units _grp;
			_grp setBehaviour "AWARE";
			{_x enableAttack true;} count units _grp;
			if (waypoints _grp isEqualTo []) then {
				private _wp =_grp addWaypoint [getPos leader _grp, 0];
				_wp setWaypointType "GUARD";
			};
			if (20 > (random 100)) then {_grp enableIRLasers true};
			_grp enableGunLights "ForceOff";
		};

		_cycle = _nearestdist/8;

    	//DEBUG
    	if (var_debug) then {systemChat format ["DEBUG: taskAssault: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
    } else {
		_cycle = 90;
		if (waypoints _grp isEqualTo []) then {
			private _wp =_grp addWaypoint [getPos leader _grp, 0];
			_wp setWaypointType "GUARD";
		};
		{
			_x enableAI "FSM";
			_x enableAI "COVER";
			_x enableAI "SUPPRESSION";
		} count units _grp;
		_grp setBehaviour "AWARE";
		_grp enableIRLasers false;
		_grp enableGunLights "ForceOff";
	};

  	//WAIT
  	if (_cycle < 30) then {_cycle = 30};
  	if (_cycle > 180) then {_cycle = 180};
  	sleep _cycle;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////