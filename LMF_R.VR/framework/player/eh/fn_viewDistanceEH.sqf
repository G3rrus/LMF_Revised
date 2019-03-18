// PLAYER VIEW DISTANCE EH ///////////////////////////////////////////////////////////////////////////
/*
	- This function handles view distance depending on if the player is on foot or in an air vehicle.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _veh = vehicle ACE_player;
if !(_veh isKindOf "Air") exitWith {
	setViewDistance var_onFootMax;
	setObjectViewDistance var_onFootMaxObj;
};

setViewDistance lmf_overwrite_viewDistanceCap;
setObjectViewDistance lmf_overwrite_objectViewDistanceCap;