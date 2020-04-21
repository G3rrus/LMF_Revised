// JIP TELEPORT EMPTY SEAT BOOLEAN ////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus, diwako
	* Check targets vehicle for empty seat.
	*
	* Arguments:
	* 0: Target <OBJECT>
	*
	* Example:
	* [player] call lmf_player_fnc_jipEmptySeat;
	*
	* Return Value:
	* <BOOL> true if targets vehicle has free seat else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [["_target",objNull,[objNull]]];

private _freeSeat = false;

//EXIT IF NO TARGET
if (isNull _target) exitWith {_freeSeat};


// CHECK FOR EMPTY POS ////////////////////////////////////////////////////////////////////////////
private _hasDriver = vehicle _target emptyPositions "driver";
private _hasCommander = vehicle _target emptyPositions "commander";
private _hasGunner = vehicle _target emptyPositions "gunner";
private _hasTurret = vehicle _target emptyPositions "turret";
private _hasCargo = vehicle _target emptyPositions "cargo";
if (_hasDriver > 0 || {_hasCommander > 0 || {_hasGunner > 0 || {_hasTurret > 0 || {_hasCargo > 0}}}}) then {
	_freeSeat = true;
};

// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_freeSeat