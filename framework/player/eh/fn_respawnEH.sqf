// PLAYER RESPAWN EH //////////////////////////////////////////////////////////////////////////////
/*
	- This function spawned by the player respawn EH handles what happens on a players respawn.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];


//JOIN NEW GROUP
[_unit] joinSilent grpNull;
clearRadio;

//BLACK FADE
cutText  ["", "BLACK FADED", 10, true];

//TERMINATE SPECTATOR
["Terminate"] call BIS_fnc_EGSpectator;
[false] call acre_api_fnc_setSpectator;

//REMOVE CUSTOM CHAT CHANNEL
[_unit,false] remoteExec ["lmf_server_fnc_spectatorChannel", 2];


//PLAYER GEAR
if (var_playerGear) then {
	if !(var_keepRole) then {
		[player, "Rifleman"] call lmf_player_fnc_initPlayerGear;
	} else {
		[player] call lmf_player_fnc_initPlayerGear;
	};
};

//CHANNEL SETUP
0 enableChannel false;
1 enableChannel true;
2 enableChannel false;
3 enableChannel true;
4 enableChannel false;
5 enableChannel false;

//FADE IN
sleep 5;
setCurrentChannel 3;
cutText  ["", "BLACK IN", 5, true];