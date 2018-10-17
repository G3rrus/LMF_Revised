// AI TASK ASSAULT FUNCTION ///////////////////////////////////////////////////////////////////////
/*
	- originally by alex2k, altered by Drgn V4karian.
	- This function assigns the AI with a guard type waypoint each 180 seconds.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]]];

while {count units _grp > 0} do {

	if (count waypoints _grp > 0) then {
		[_grp] call CBA_fnc_clearWaypoints;
	};
	private _wp =_grp addWaypoint [getpos leader _grp, 0];
	[_grp, 0] setWaypointType "GUARD";

	sleep 180;
};