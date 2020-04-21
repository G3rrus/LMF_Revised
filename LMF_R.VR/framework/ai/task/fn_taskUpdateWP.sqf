// AI UPDATE WAYPOINT FUNCTION ////////////////////////////////////////////////////////////////////
/*
	* Author: Alex2k, G4rrus
	* Reset groups Guard WP every 180 seconds.
	* Note: Needs to be local to the group.
	*
	* Arguments:
	* 0: Group <GROUP>
	*
	* Example:
	* [group cursorObject] spawn lmf_ai_fnc_taskUpdateWP;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_grp",grpNull,[grpNull]]];

//EXIT IF NOT LOCAL OR NULL
if (isNull _grp || {!local _grp}) exitWith {};


// RESET WAYPOINT /////////////////////////////////////////////////////////////////////////////////
while {count units _grp > 0} do {

	{deleteWaypoint ((wayPoints _grp) select 0)} count wayPoints _grp;
	private _wp =_grp addWaypoint [getpos leader _grp, 0];
	_wp setWaypointType "GUARD";

	//SET WAYPOINT ON ENEMY IF POSSIBLE (SOMETIMES WAYPOINT IS 0 SOMETIMES 1)
	private _nearestEnemy = (leader _grp) findNearestEnemy (leader _grp);
	if (!isNull _nearestEnemy) then {
		{[_grp,_x] setWaypointPosition [getPosATL _nearestEnemy,25]} forEach [0,1];
	};

	sleep 180;
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////