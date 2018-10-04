// Waypoint Updater
// version 0.2
// by Alex2k


_grp = _this select 0;

while {count units _grp > 0} do {

	if (count waypoints _grp > 0) then {
		{deleteWaypoint ((waypoints _grp) select 0);} forEach waypoints _grp;
	};

	_wp =_grp addWaypoint [getpos leader _grp, 0];
	[_grp, 0] setWaypointType "GUARD";

/*
	if (behaviour leader _grp == "COMBAT") then {
		_wp setWaypointFormation selectRandom ["LINE","WEDGE"];
	} else
	{
		_wp setWaypointFormation "DIAMOND";
	};
*/

	sleep 180;

};