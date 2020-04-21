// AI TASK HUNT ///////////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus
	* Make AI artillery fire at a given position.
	* Note: Needs to be local to the object.
	* Each artillery piece will for some reason only have a very specific actual firing range.
    *
	* Arguments:
	* 0: Target <OBJECT>
    * 1: Artillery Gunner <OBJECT>
    * 2: Ammo Type <STRING>
	* 3: Amount <NUMBER>
    * 4: Accuracy <NUMBER>
	*
	* Example:
	* [player, cursorObject, "8Rnd_82mm_Mo_Smoke_white", 2, 100] spawn lmf_ai_fnc_mortarattack;
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//PARAMS
params [
	["_target",objNull,[objNull]],
	["_mortar",objNull,[objNull]],
	["_type","8Rnd_82mm_Mo_Smoke_white",[""]],
	["_rounds",2,[123]],
	["_accuracy",100,[123]]
];

//EXIT IF NOT LOCAL IS NULL OR CAN NOT FIRE
if (isNull _mortar || {isNull _target || {!local _mortar || {!canFire _mortar}}}) exitWith {};


// DO THE STUFF ///////////////////////////////////////////////////////////////////////////////////
for "_i" from 1 to _rounds do {
	//RANDOMIZE TARGET LOCATION
	private _pos = _target getPos [_accuracy,random 360];

	_mortar commandArtilleryFire [_pos,_type,1];

	waitUntil {unitReady _mortar};
};

//RESET MORTAR
_mortar setVehicleAmmo 1;


// RETURN /////////////////////////////////////////////////////////////////////////////////////////