// INIT ADMIN TP //////////////////////////////////////////////////////////////////////////////////
/*
	- Function to call the player admin teleport properly.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

#include "cfg_admin.sqf"

//REMOTE EXEC THE FUNCTION
[_unit] remoteExec ["lmf_admin_fnc_adminTP",0];