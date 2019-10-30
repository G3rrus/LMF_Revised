// PLAYER SAFETY //////////////////////////////////////////////////////////////////////////////////
/*
    - This function makes the players weapon harmless and disables player dammage.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(hasInterface) exitWith {};
params [["_state", false]];

if (_state) then {
	lmf_noGuns = player addEventHandler ["Fired", {deleteVehicle (_this select 6);}];
	player allowDamage false;
	[player,currentWeapon player,currentMuzzle player] call ace_safemode_fnc_lockSafety;
} else {
	player removeEventHandler ["Fired",lmf_noGuns];
	player allowDamage true;
	[player,currentWeapon player,currentMuzzle player] call ace_safemode_fnc_unlockSafety;
};