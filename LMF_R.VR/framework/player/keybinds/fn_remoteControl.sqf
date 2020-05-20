// REMOTE CONTROL /////////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* If valid, let's spectator with zeus module remote control AI.
	*
	* Arguments:
	* 0: <DISPLAY CTRL>
	* 1: <KEY>
	* 2: <BOOL>
	* 3: <BOOL>
	* 4: <BOOL>
	*
	* Example:
	* [Display #60000,42,true,false,false] call lmf_player_fnc_remoteControl;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_ctrl", "_key", "_shift", "_ctrl", "_alt"];

if !([_key,[_shift,_ctrl,_alt]] isEqualTo ((["LMF Revised", "enter_spec_remote"] call CBA_fnc_getKeybind) select 5)) exitWith {};


// REMOTE CONTROL /////////////////////////////////////////////////////////////////////////////////
if (
	isNil "ace_spectator_camFocus" ||
	{isNull ace_spectator_camFocus ||
	{isplayer ace_spectator_camFocus ||
	{!alive ace_spectator_camFocus ||
	{!isNull (ace_spectator_camFocus getvariable ["bis_fnc_moduleRemoteControl_owner",objnull]) ||
	{!isNull (ace_spectator_camFocus getVariable ["lmf_isControlled",objnull]) ||
	{isuavconnected vehicle ace_spectator_camFocus
}}}}}}) exitWith {
	systemChat "LMF: Cannot Remote Control!"
};

//SWITCH TO TARGET
private _target = ace_spectator_camFocus;
_target setVariable ["lmf_isControlled",player,true];
_target setVariable ["bis_fnc_moduleRemoteControl_owner",player,true];
[false] call ace_spectator_fnc_setSpectator;
player remoteControl _target;
_target switchCamera "Internal";

//WAIT AND SWITCH BACK
[
	{
		private _target = _this select 0;
		!(cameraon isEqualTo _target) &&
		!(cameraon isEqualTo vehicle _target) ||
		!alive _target
	},
	{
		private _target = _this select 0;
		objnull remotecontrol _target;
		[true] call ace_spectator_fnc_setSpectator;
		player switchcamera cameraview;
		_target setVariable ["lmf_isControlled",nil,true];
		_target setVariable ["bis_fnc_moduleRemoteControl_owner",nil,true];
		ace_spectator_camera setPosATL (getPosATL _target);
		if !(isNull (getAssignedCuratorLogic player)) then {
			[{!isNull findDisplay 60000},{
				private _lmf_spec_remote_control = (findDisplay 60000) displayAddEventHandler ["KeyUp",{
					_this call lmf_player_fnc_remoteControl;
				}];
			},[],120] call CBA_fnc_waitUntilAndExecute;
		};
	},
	[_target]
] call CBA_fnc_waitUntilAndExecute;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////