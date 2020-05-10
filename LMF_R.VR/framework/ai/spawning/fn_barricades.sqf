//RANDOM BARRICADE SCRIPT /////////////////////////////////////////////////////////////////////////
/*
	* Author: nkenny, G4rrus
	* Spawn ambient barricade clutter.
	* Note: Needs to be called on the Server or a HC.
	*
	* Arguments:
	* 0: Spawn Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
	* 1: Radius <NUMBER>
	* 2: Amount <NUMBER>
	*
	* Example:
	* [player, 100, 10] spawn lmf_ai_fnc_barricades;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if (hasInterface && {!isServer}) exitWith {};
waitUntil {CBA_missionTime > 0};

params [
	["_spawnPos",objNull,[objNull,grpNull,"",locationNull,taskNull,[],123]],
	["_radius",100,[123]],
	["_amount",10,[123]]
];

_spawnPos = _spawnPos call CBA_fnc_getPos;
if (_spawnPos isEqualTo  [0,0,0]) exitWith {};

private _roadList = _spawnPos nearroads _radius;
if (var_debug && {count _roadlist < 2}) exitWith {
	systemChat format ["DEBUG Barricades: No roads found! (%1)",count _roadlist];
};

private _wrecklist = ["Land_Barricade_01_10m_F","Land_Barricade_01_10m_F","Land_Barricade_01_10m_F","Land_Barricade_01_4m_F"];

// SHUFFLE ROADS
_roadlist = _roadlist call BIS_fnc_arrayShuffle;
if (count _roadlist < _amount) then {_amount = count _roadlist};


// SPAWN IN STUFF /////////////////////////////////////////////////////////////////////////////////
for "_i" from 0 to (_amount -1 ) do {

	// ROAD
	private _direction = (Random 360);
	private _currentRoad = _roadlist select _i;
	if (count (roadsConnectedTo _currentRoad) > 1) then {
		private _connectedRoad = ((roadsConnectedTo _currentRoad) select 0);
		_direction = [_currentRoad, _connectedRoad] call BIS_fnc_DirTo;
	};

	// VEHICLE
 	private _car = selectRandom _wrecklist;
	private _veh = createVehicle [_car,_currentRoad,[],0,"CAN_COLLIDE"];
	_veh setdir _direction;
	private _rel_pos = [_veh,0.5 + (random 5),(_direction+90)] call BIS_fnc_relPos;
	_veh setpos _rel_pos;
	addToRemainsCollector [_veh];

	// BURNING BARREL
	if (random 1 < 0.1) then {
		private _veh2 = createVehicle ["MetalBarrel_burning_F",_veh,[],0,"NONE"];
		_veh2 setVectorUp surfaceNormal position _veh2;
		addToRemainsCollector [_veh2];
	};

	// BURNING WHEELS
	if (random 1 < 0.1) then {
		private _center = createCenter sideLogic;
		private _grp = createGroup [_center,true];
		private _veh3 = createVehicle ["Land_Tyres_F",_veh,[],150,"NONE"];
		private _smoke = _grp createUnit ["ModuleEffectsSmoke_F",getposATL _veh3,[],0,"CAN_COLLIDE"];
		_veh3 setVectorUp surfaceNormal position _veh3;
		addToRemainsCollector [_smoke,_veh3];
	};
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////