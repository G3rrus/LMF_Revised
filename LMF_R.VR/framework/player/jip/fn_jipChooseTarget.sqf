// JIP TELEPORT TARGET SELECT /////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus, diwako
	* Choose JIP target.
	* Note: Needs to be local to player.
	*
	* Arguments:
	* 0: <NONE>
	*
	* Example:
	* [] call lmf_player_fnc_jipChooseTarget;
	*
	* Return Value:
	* <OBJECT> teleportation target
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _tpTarget = objNull;
private _partGroup = units group player;


// IF THE PLAYER IS NOT THE LEADER AND THE LEADER IS ALIVE THEN LEADER IS TARGET //////////////////
if (player != leader group player && {alive leader group player}) then {
	_tpTarget = leader group player;
};

//IF PLAYER IS LEADER OR LEADER IS DEAD THEN PICK NEXT BEST ONE
if (player == leader group player || {!alive leader group player}) then {
	_partGroup = _partGroup - [(leader group player)];
	_tpTarget = _partGroup select (_partGroup findIf {alive _x});
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_tpTarget