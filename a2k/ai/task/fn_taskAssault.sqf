// Tracker script
// version 3.5
// by nkenny (mangled by Alex2k)


// 1. FIND TRACKER
_grp = _this select 0;
_range = if (count _this > 1) then {_this select 1} else {500};                   // Range of search
_position = getPos (leader _grp);
_cycle = 30;

// 2. SET DEFAULT BEHAVIOR
//{_x disableAI "AUTOCOMBAT"} forEach units _grp;
//_grp setCombatMode "RED";

// 3. DO THE HUNT SCRIPT!
while {count units _grp > 0} do
{
  _tracker = leader _grp;
  _nearestdist = _range;
  _availabletargets = (switchableUnits + playableUnits - entities "HeadlessClient_F");
  _nearest = objNull;
  
  // 3a. CHOOSE CLOSEST PLAYER
    {
      _dist=vehicle _x distance _tracker;
      if ((side _x != civilian) AND (getposATL _x select 2 < 25) AND isPlayer _x AND _dist<_nearestdist) then 
        {
        _nearest=_x;
        _nearestdist=_dist;
        };
    } forEach _availabletargets;
  
  // 3.b GIVE ORDERS 
  if (!isNull _nearest) then 
    {

		if (_nearestdist < 200) then {

			//Dismount vehicle
			if (vehicle leader _grp != leader _grp) then {
				{deleteWaypoint ((wayPoints _grp) select 0);} forEach wayPoints _grp;
				_wp1 =_grp addWaypoint [getPos leader _grp, 0];
				[_grp, 0] setWaypointType "GETOUT";
				_wp2 =_grp addWaypoint [getPos leader _grp, 0];
				[_grp, 1] setWaypointType "GUARD";
			};

			//Crouch a little, sometimes
			if (50 > random 100) then { {_x setUnitPos "MIDDLE"} forEach units _grp; } else { {_x setUnitPos "AUTO"} forEach units _grp; };

			sleep 10;

			//Move in!
			if (_tracker knowsAbout _nearest > 1) then {
				{deleteWaypoint ((wayPoints _grp) select 0);} forEach wayPoints _grp;
				{_x doMove (getposATL _nearest)} forEach units _grp;
				{_x enableAttack false} forEach units _grp;
			};
		};

		//Agressive when very close
		if (_nearestdist < 50) then {
			{deleteWaypoint ((wayPoints _grp) select 0);} forEach wayPoints _grp;
			{_x doMove (getposATL _nearest)} forEach units _grp;

			{_x disableAI "AUTOCOMBAT"} forEach units _grp;
			_grp setBehaviour "AWARE";
			{_x setUnitPos "AUTO"} forEach units _grp;
			{_x enableAttack false} forEach units _grp;
		};

		//Regular behaviour when further out
		if (_nearestdist > 200) then {
			{_x enableAI "AUTOCOMBAT"} forEach units _grp;
			_grp setBehaviour "AWARE";
			{_x setUnitPos "AUTO"} forEach units _grp;
			{_x enableAttack true} forEach units _grp;

			if (count waypoints _grp == 0) then {
				_wp =_grp addWaypoint [getPos leader _grp, 0];
				[_grp, 0] setWaypointType "GUARD";
			};
		};


		/*
		if (_tracker knowsAbout _nearest > 1) then {
			[_grp, 1] setWaypointPosition [getPosATL _nearest, 0];
		};
		*/

    _cycle = _nearestdist/8;

    // DEBUG
    if (var_debug) then {systemChat format ["DEBUG: taskAssault: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
    } else {
		_cycle = 90;
		if (count waypoints _grp == 0) then {
			_wp =_grp addWaypoint [getPos leader _grp, 0];
			[_grp, 0] setWaypointType "GUARD";
		};
		{_x enableAI "AUTOCOMBAT"} forEach units _grp;
		_grp setBehaviour "AWARE";
		{_x setUnitPos "AUTO"} forEach units _grp;
	};

  // WAIT FOR IT!
  if (_cycle < 30) then {_cycle = 30};
  if (_cycle > 180) then {_cycle = 180};
  sleep _cycle;
    
};