// AI TASK ASSAULT FUNCTION ///////////////////////////////////////////////////////////////////////
/*
	- originally by nkenny, altered by Drgn V4karian.
	- This function assigns the AI with a task to assault targets rather aggressively if in range.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]],["_range",500,[0]]];
private _cycle = 30;


// START THE HUNT SCRIPT //////////////////////////////////////////////////////////////////////////
while {count units _grp > 0} do {
	private _tracker = leader _grp;
	private _nearestdist = _range;
	private _availabletargets = (switchableUnits + playableUnits - entities "HeadlessClient_F");
	private _nearest = objNull;

	//CHOOSE CLOSEST TARGET
	{
		private _dist = vehicle _x distance2D _tracker;
		if ((_dist < _nearestdist) && {(side _x != civilian) && {((getposATL _x)#2 < 25) && isPlayer _x}}) then {
			_nearest = _x;
			_nearestdist = _dist;
		};
		false
	} count _availabletargets;


	// ORDERS ///////////////////////////////////////////////////////////////////////////////////////
	if !(isNull _nearest) then {
		if (_nearestdist < 200) then {
			//DISMOUNT VEHICLES
			if (vehicle leader _grp != leader _grp) then {
				[_grp] call CBA_fnc_clearWaypoints;
				private _wp1 =_grp addWaypoint [getPos leader _grp, 0];
				[_grp, 0] setWaypointType "GETOUT";
				private _wp2 =_grp addWaypoint [getPos leader _grp, 0];
				[_grp, 1] setWaypointType "GUARD";
			};
			//CROUCH SOMETIMES
			if (50 > random 100) then {
				{_x setUnitPos "MIDDLE"; false} count units _grp;
			} else {
				{_x setUnitPos "AUTO"; false} count units _grp;
			};

			sleep 10;

			//MOVE IN
			if (_tracker knowsAbout _nearest > 1) then {
				[_grp] call CBA_fnc_clearWaypoints;
				{_x doMove (getposATL _nearest); false} count units _grp;
				{_x enableAttack false; false} count units _grp;
			};
		};

		//AGGRESSIVE WHEN CLOSE
		if (_nearestdist < 50) then {
			[_grp] call CBA_fnc_clearWaypoints;
			{_x doMove (getposATL _nearest); false} count units _grp;
			{_x disableAI "AUTOCOMBAT"; false} count units _grp;
			_grp setBehaviour "AWARE";
			{_x setUnitPos "AUTO"; false} count units _grp;
			{_x enableAttack false; false} count units _grp;
		};

		//REGULAR WHEN FURTHER OUT
		if (_nearestdist > 200) then {
			{_x enableAI "AUTOCOMBAT"; false} count units _grp;
			_grp setBehaviour "AWARE";
			{_x setUnitPos "AUTO"; false} count units _grp;
			{_x enableAttack true; false} count units _grp;
			if (count waypoints _grp == 0) then {
				private _wp =_grp addWaypoint [getPos leader _grp, 0];
				[_grp, 0] setWaypointType "GUARD";
			};
		};

		_cycle = _nearestdist/8;

    	// DEBUG
    	if (var_debug) then {systemChat format ["DEBUG: taskAssault: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
    } else {
		_cycle = 90;
		if (count waypoints _grp == 0) then {
			private _wp =_grp addWaypoint [getPos leader _grp, 0];
			[_grp, 0] setWaypointType "GUARD";
		};
		{_x enableAI "AUTOCOMBAT"; false} count units _grp;
		_grp setBehaviour "AWARE";
		{_x setUnitPos "AUTO"; false} count units _grp;
	};

  	// WAIT FOR IT!
  	if (_cycle < 30) then {_cycle = 30};
  	if (_cycle > 180) then {_cycle = 180};
  	sleep _cycle;
};