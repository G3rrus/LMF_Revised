// AI SUPPRESSION FUNCTION ////////////////////////////////////////////////////////////////////////
/*
	* Author: nkenny, diwako, G4rrus
	* Makes AI suppress target position.
    * Note: Needs to be local to the object.
	*
	* Arguments:
	* 0: Unit <OBJECT>
    * 1: Target <OBJECT>
	* 2: Times to Fire <NUMBER>
	* 3: Reset Magazine <BOOL>
	* 4: Fire mode <STRING>
	*
	* Example:
	* [cursorObject, player, 10, false, "manual"] spawn lmf_ai_fnc_taskSuppress;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [
	["_unit",objNull,[objNull]],
	["_target",objNull,[objNull]],
	["_timesFired",10,[123]],
	["_resetMagazine",true,[true]],
	["_mode","manual",[""]]
];

if (isNull _unit || {isNull _target || {!local _unit}}) exitWith {
	if (var_debug) then {
		if (isNull _unit) then {
			systemChat "DEBUG taskSuppress: No Suppressing Unit!";
		};
		if (isNull _target) then {
			systemChat "DEBUG taskSuppress: No Targets to Suppress!";
		};
	};
};

private _time = _timesFired + time;

//POSITIONS (give _unit positions to watch and make suppression less deadly)
private _positions = [];
_positions pushback ((getPosATL _target) vectorAdd [0,0,random 0.5]);
_positions pushback ((_target getpos [random 6,random 360]) vectorAdd [0,0,random 0.5]);
_positions pushback ((_target getpos [random 6,random 360]) vectorAdd [0,0,random 0.5]);

//DEBUG
if (var_debug) then {
	{
		private _veh = "Sign_Arrow_Large_Blue_F" createVehicle _x;
		_veh enableSimulation false;
	} count _positions;
};

//GET UNIT READY
_unit doWatch (selectRandom _positions);
(group _unit) setFormDir (_unit getDir (_positions select 0));
_unit doTarget _target;
_unit setVariable ["var_isSuppressing", true];
doStop _unit;
_unit disableAI "PATH";
sleep 0.1;


// MAKE IT HAPPEN /////////////////////////////////////////////////////////////////////////////////
while {time < _time && {alive _unit}} do {
	if (_resetMagazine) then {_unit setAmmo [primaryWeapon _unit, 100]};
	_unit doWatch (selectRandom _positions);
	_unit forceWeaponFire [(primaryWeapon _unit), _mode];
	sleep 0.1;
};

//RESET THE UNIT IF STILL ALIVE
if !(alive _unit) exitWith {};

_unit setVariable ["var_isSuppressing",false];
_unit doFollow leader group _unit;
_unit enableAI "PATH";
if (var_debug) then {systemChat format ["DEBUG taskSuppress: %1 is ready (%2s)",name _unit,_timesFired]};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////