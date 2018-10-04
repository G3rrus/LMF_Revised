// eventhandler function that handles the AI suppressive fire task
params ["_unit"];

// exit if not ready
if (_unit getVariable ["var_isSuppressing",false]) exitWith {};

// exit if range is wrong
private _suppTarget = (_unit findNearestenemy _unit);
private _dist = _unit distance _suppTarget;
if (_dist < 50 || {_dist  > 800}) exitWith {};

// define some params to pass
private _timesFired = round (3 + random 6);
private _modes = (getArray (configFile >> "CfgWeapons" >> currentWeapon _unit >> "modes"));
private _auto = "FullAuto";
if (_modes findif {"FullAuto" == _x} == -1) then {_auto = "close"};

// do the suppression task
[[_unit],[_suppTarget],_timesFired,false,_auto] spawn lmf_ai_fnc_taskSuppress;