// Suppressive fire script
// v1.0
// by nkenny -- Heavily inspired by Big_Wilk

/*
  1. Sort units
  2. Sort positions
  3. Execute
  4. end

  Parameters
  _u = Aray : Units doing the shooting
  _p = Array : Targets being hit
  _t = number : time being fired
  _a = Boolean : Endless ammo true/false

*/

//INIT
params ["_unit",objNull],["_target",objNull],["_timesFired",10],["_resetMagazine",false],["_mode","FullAuto"]];
if !(local _unit exitWith {};
if (_unit == objNull) exitWith {
	if (var_debug) exitWith {
		systemChat "No Suppressing Unit!";
	};
};
if (_target == objNull) exitWith {
	if (var_debug) exitWith {
		systemChat "No Targets to Suppress!";
	};
};

private _time = _timesFired + time;

//TARGET
private _positions = [];
if !((getpos _target) isEqualTo [0,0,0]) then {
    _positions pushback ((getPosATL _target) vectorAdd [0,0,random 0.5]);
    _positions pushback ((_target getpos [random 6,random 360]) vectorAdd [0,0,random 0.5]);
    _positions pushback ((_target getpos [random 6,random 360]) vectorAdd [0,0,random 0.5]);
};

//DEBUG
if (var_debug) then {
	{private _veh = "Sign_Arrow_Large_Blue_F" createVehicle _x; _veh enableSimulation false; false} count _positions;
};

//GET UNIT READY
_unit doWatch (selectRandom _positions);
(group _unit) setFormDir (_unit getDir (_positions select 0));
_unit doTarget _target;
_unit setVariable ["var_isSuppressing", true];
doStop _unit;
_unit disableAI "PATH";
sleep 0.1;

//MAKE IT HAPPEN
while {time < _time} do {
	if (alive _unit) then {
		if (_resetMagazine) then {_unit setAmmo [primaryWeapon _unit, 100]};
		_unit doWatch (selectRandom _positions);
		_unit forceWeaponFire [(primaryWeapon _unit), _fm];
	} else {};
	sleep 0.1;
};

//RESET THE UNIT IF STILL ALIVE
if !(alive _unit) exitWith {};

_unit setVariable ["var_isSuppressing",false];
_unit doFollow leader group _unit;
_unit enableAI "PATH";
if (var_debug) then {systemchat format ["%1 is ready (%2s)",name _unit,_timesFired]};