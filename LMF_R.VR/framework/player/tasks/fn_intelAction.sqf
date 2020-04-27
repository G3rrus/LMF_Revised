// ADD ACE ACTION TO OBJECT ///////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Add ace action to object which on completion calls a CBA-event locally or globally.
	* Note: It's added locally, so it must be called on each machine it should show up on.
	* Player calling the action will be passed to the CBA event as 0 parameter.
	*
	* Arguments:
	* 0: Object <OBJECT> object the action is assigned to
	* 1: Action Name <STRING> what the action should be called
	* 2: Length <NUMBER> how long the action should last
	* 3: Event <STRING> CBA-Event being called
	* 4: Global <BOOL> should CBA event be called locally or globally
	* 5: Delete <BOOL> delete object on activation
	*
	* Example:
	* [cursorObject, "Test Action", 5, "acex_killtracker_death", false, true] call lmf_task_fnc_intelAction;
	*
	* Return Value:
	* <BOOL> true if action was added, else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [
	["_object",objNull,[objNull]],
	["_text","",[""]],
	["_length",5,[123]],
	["_event","",[""]],
	["_global",false,[true]],
	["_delete",true,[true]]
];

if (isNull _object || {_event isEqualTo ""}) exitWith {false};


// ADD THE ACTION /////////////////////////////////////////////////////////////////////////////////
private _actionName = "lmf_intel_" + _text;

// ACTION STATEMENT
private _statement = {

	params ["_object","_caller","_actionParams"];
	private _timeToSpent = _actionParams select 0;

	//PROGRESS BAR
	[_timeToSpent, [_object,_caller,_actionParams],
		{
			//ON SUCCESS
			(_this select 0) params [ "_object","_caller","_actionParams"];
			_actionParams params ["","_event","_global","_delete"];

			//IF GLOBAL CALL FOR EVERYONE ELSE LOCAL
			if (_global) then {
				[_event, [_caller]] call CBA_fnc_globalEvent;
			} else {
				[_event, [_caller]] call CBA_fnc_localEvent;
			};

			//IF DELETE AT THE END DELETE
			if (_delete) exitWith {
				deleteVehicle _object;
			};
		},
		{},
		"Processing..."
	] call ace_common_fnc_progressBar;
};

//CREATE ACTION
private _action = [
	_actionName,
	_text,
	"\A3\ui_f\data\Map\Diary\Icons\diaryLocateTask_ca.paa",
	_statement,
	{true},
	{},
	[_length,_event,_global,_delete]
] call ace_interact_menu_fnc_createAction;

//ADD ACTION TO OBJECT
[_object,0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToObject;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true