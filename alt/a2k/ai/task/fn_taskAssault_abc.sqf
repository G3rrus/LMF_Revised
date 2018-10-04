// Assault Script
// v1.0
// by Alex2k


_grp = _this select 0;
_randDist = 150 + 150;


//Dismount in case of vehicle
if (vehicle leader _grp != leader _grp) then {
	{deleteWaypoint ((wayPoints _grp) select 0);} forEach wayPoints _grp;
	_wp1 =_grp addWaypoint [getPos leader _grp, 0];
	[_grp, 0] setWaypointType "GETOUT";
	_wp2 =_grp addWaypoint [getPos leader _grp, 0];
	[_grp, 1] setWaypointType "GUARD";
};

//Get group on line
_grp setCombatMode "GREEN";
_grp setSpeedMode "LIMITED";
_grp setFormation "LINE";
sleep 10;
_grp setCombatMode "YELLOW";
_grp setSpeedMode "FULL";

//Assault loop
while {count units _grp > 0} do {

	_nearEnemy = (leader _grp) findNearestEnemy (leader _grp);
	_ePos = getPosATL _nearEnemy;

	[_grp, 1] setWaypointPosition [getPosATL leader _grp, 0];

	sleep 10;

	if (!isNull _nearEnemy) then {
		if (leader _grp distance _ePos < _randDist AND _ePos select 2 < 50) then {
			//[_grp, 1] setWaypointPosition [_ePos, 0];
			{_x doMove _ePos} forEach units _grp;
			_grp setSpeedMode "FULL";
		};
	};

	sleep 30;

};