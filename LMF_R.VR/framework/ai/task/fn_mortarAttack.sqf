// AI TASK HUNT ///////////////////////////////////////////////////////////////////////////////////
/*
  - Originally by nkenny.
	- Revised by Drgn V4karian.
	- The function is ment to make AI artillery fire at a given position
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//PARAMS
params [["_target",objNull],["_mortar",objNull],["_type","8Rnd_82mm_Mo_Smoke_white"],["_rounds",2],["_accuracy",100]];

//EXIT IF NOT LOCAL
if (!local _mortar || {!canFire _mortar}) exitWith {};

//DO THE STUFF
for "_i" from 1 to _rounds do {
	// Randomize target location
	private _pos = _target getPos [_accuracy,random 360];

	_mortar commandArtilleryFire [_pos,_type,1];

	waitUntil {unitReady _mortar};
};

//RESET MORTAR
_mortar setVehicleAmmo 1;