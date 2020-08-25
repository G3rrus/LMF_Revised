// UNIT ADMIN CHECK ///////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Check wether passed unit is admin.
	* Note: Can only be called on the server.
	*
	* Arguments:
	* 0: Unit <OBJECT>
	*
	* Example:
	* [player] call lmf_server_fnc_isAdmin;
	*
	* Return Value:
	* <BOOL> true if is admin else false
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(isServer) exitWith {};

params [["_unit",objNull,[objNull]]];

if (isNull _unit) exitWith {};

private _admin = false;
private _uid = getPlayerUID _unit;
private _adminList =  [
	"76561197970604257", // Cuel
	"76561197997030424", // Terry
	"76561197980328722", // Diwako
	"76561198009543420", // Croguy
	"76561198023751916", // Exabit
	"76561197997590271", // G4rrus
	"76561198000443724", // Anog
	"76561198090259557", // Castiel
	var_creatorUID,
	"_SP_PLAYER_"
];


//CHECK IF ADMIN AND RETURN BOOL
if (admin (owner _unit) > 0 || {_adminList findIf {_x == _uid} != -1 || {hasInterface}}) then {_admin = true};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_admin