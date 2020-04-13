// CFG FOR ADMINS /////////////////////////////////////////////////////////////////////////////////
/*
	- This file handles who is an admin and gets to execute admin functions. It is included in all
	  admin related functions.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
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

//CHECK IF ADMIN
if (admin owner _unit > 0 || {_adminList findIf {_x == _uid} != -1}) then {_admin = true};

//IF NOT
if !(_admin) exitWith {"Only for certified members!!!" remoteExec ["systemChat",_unit]};