// eventhandler function that handles the AI suppressive fire task
params ["_unit"];

// exit if not ready
if (_unit getVariable ["var_isSuppressing",false]) exitWith {};

// exit if range is wrong
private _target = (_unit findNearestenemy _unit);
private _dist = _unit distance _target;
if (_dist < 50 || {_dist  > 800}) exitWith {};

// define some params to pass
private _timesFired = round (3 + random 6);
private _modes = (getArray (configFile >> "CfgWeapons" >> currentWeapon _unit >> "modes"));
private _mode = "FullAuto";
if (_modes findif {"FullAuto" == _x} == -1) then {_mode = "close"};
private _resetMagazine = false;

// do the suppression task
[_unit,_target,_timesFired,_resetMagazine,_mode] spawn lmf_ai_fnc_taskSuppress;