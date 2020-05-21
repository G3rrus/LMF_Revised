// AI PARA QRF ////////////////////////////////////////////////////////////////////////////////////
/*
	* Author: Alex2k, G4rrus
	* Spawn AI helicopter (on the ground) that functions as paradrop QRF, after paradrop helo flies away and despawns.
	* Note: Needs to be called on the Server or a HC.
	*
	* Arguments:
	* 0: Spawn Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	*
	* Example:
	* [player] spawn lmf_ai_fnc_paraQRF;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if (hasInterface && {!isServer}) exitWith {};
waitUntil {CBA_missionTime > 0};

params [["_spawnPos",objNull,[objNull,grpNull,"",locationNull,taskNull,[],123]]];

private _dir = random 360;
if ((typeName _spawnPos) isEqualTo "OBJECT") then {
	_dir = getDir _spawnPos;
};
if ((typeName _spawnPos) isEqualTo "STRING") then {
	_dir = markerDir _spawnPos;
};

_spawnPos = _spawnPos call CBA_fnc_getPos;
if (_spawnPos isEqualTo  [0,0,0]) exitWith {};


// PREPARE AND SPAWN //////////////////////////////////////////////////////////////////////////////
private _type = ["HELITRANSPORT"] call lmf_ai_fnc_makeType;
private _veh = createVehicle [_type, _spawnPos, [], 0, "CAN_COLLIDE"];
_veh setDir _dir;

//CREW
private _type = ["HCREW"] call lmf_ai_fnc_makeType;
private _grp = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
_grp deleteGroupWhenEmpty true;
_grp setGroupIDGlobal [format ["Para QRF: %1", groupId _grp]];
_grp addVehicle _veh;
{_x moveInAny _veh} forEach units _grp;
{_x disableAI "AUTOCOMBAT"} count units _grp;

//PASSENGERS
private _type = ["SQUAD"] call lmf_ai_fnc_makeType;
private _grp2 = [_spawnPos,var_enemySide,_type] call BIS_fnc_spawnGroup;
_grp2 deleteGroupWhenEmpty true;
_grp2 setGroupIDGlobal [format ["Para QRF: %1", groupId _grp2]];
{_x moveInCargo _veh} count units _grp2;

//ORDERS
private _wp = _grp addWaypoint [getPos _veh,0];
_wp setWaypointType "GUARD";
private _flyHeight = 300 + random 200;
_veh flyInHeightASL [_flyHeight, _flyHeight, _flyHeight];

//WAIT UNTIL THEY SHALL DEPLOY
waitUntil {sleep 2; allPlayers findIf {_x distance2D _veh < 500 + random 200} != -1 || {{alive _x} count units _grp < 1 || {!alive _veh}}};
waitUntil {sleep 3; !(position _veh isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []) || {{alive _x} count units _grp < 1 || {!alive _veh}}};


//DEPLOY THE PARATROOPS IF VEHICLE AND TROOPERS ARE ALIVE
if (alive _veh && {count units _grp2 > 0}) then {
	private _flyDir = getDir _veh;
	{
		if !(alive _veh) exitWith {};
		private _unit = _x;
		private _bag = backpack _unit;
		private _bagItems = backpackItems _unit;
		removeBackpack _unit;
		_unit addBackpack "ACE_NonSteerableParachute";
		sleep 1;
		_unit action ["openParachute", vehicle _unit];
		sleep 1;
		_unit addBackpack _bag;
		{_unit addItem _x} forEach _bagItems;
	} forEach units _grp2;

	//CBA WAITUNTIL AND EXECUTE THE TASK ASSAULT
	[
		{
			{isTouchingGround _x} count units (_this select 0) > 0 || {{alive _x} count units (_this select 0) < 1}
		},{
			_grp2 = _this select 0;
			private _pos = getPosATL leader _grp2;
			private _wp2 = _grp2 addWaypoint [[_pos#0,_pos#1,0],0];
			_wp2 setWaypointType "GUARD";
			{_x disableAI "AUTOCOMBAT"} count units _grp2;
			if (isClass (configfile >> "CfgPatches" >> "lambs_wp")) then {
				[_grp2,150,30] spawn lambs_wp_fnc_taskRush;
			} else {
				[_grp2] spawn lmf_ai_fnc_taskAssault;
			};
		}, [_grp2], 300, {}
	] call CBA_fnc_waitUntilAndExecute;
	_grp2 leaveVehicle _veh;

	//EXIT IF VEHICLE OR CREW IS NOT ALIVE ANYMORE
	if (!alive _veh || {count units _grp < 1}) exitWith {};

	//MAKE HELICOPTER FLY AWAY AND DESPAWN ONCE OUT OF SIGHT
	{deleteWaypoint ((waypoints _grp) select 0)} count waypoints _grp;
	_veh doMove (_veh getPos [10000,_flyDir - 180]);
	_veh flyInHeightASL [100, 100, 100];
	waitUntil {allPlayers findIf {_x distance2D _veh < 5000} == -1 || {!alive _veh || {count units _grp < 1}}};
	if (alive _veh && {count units _grp > 0}) then {
		{_veh deleteVehicleCrew _x} count crew _veh;
		deleteVehicle _veh;
	};
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////