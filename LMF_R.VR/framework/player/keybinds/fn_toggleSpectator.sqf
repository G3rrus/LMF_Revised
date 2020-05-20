// TOGGLE SPECTATOR ///////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Toggles if player is in ACRE spectator voice or not.
	*
	* Arguments:
	* 0: <NONE>
	*
	* Example:
	* [] call lmf_player_fnc_toggleSpectator;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if (time < 1 || {isNull (getAssignedCuratorLogic player)}) exitWith {};


// SET SPECTATOR //////////////////////////////////////////////////////////////////////////////////
if (lmf_acreToggle) then {
	[true] call acre_api_fnc_setSpectator;
	systemChat "LMF: Entered ACRE Spectator!";
} else {
	[false] call acre_api_fnc_setSpectator;
	systemChat "LMF: Exited ACRE Spectator!";
};
lmf_acreToggle = !lmf_acreToggle;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////