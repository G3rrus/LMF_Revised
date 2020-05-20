// PLAYER KILLED EH ///////////////////////////////////////////////////////////////////////////////
/*
	* Author: G4rrus, Alex2k
	* EH that handles what happens if the player gets killed.
	*
	* Arguments:
	* 0: <NONE>
	*
	* Return Value:
	* <NONE>
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//CALCULATE RESPAWNTIME
if (typename var_respawnType == "STRING") then {

	if (var_respawnType == "WAVE") then {
		setPlayerRespawnTime (var_respawnTime - ((floor CBA_missionTime) % var_respawnTime));
	};

	if (var_respawnType == "OFF") then {
		setPlayerRespawnTime 1000000;
	};

};

if (typename var_respawnType == "SCALAR") then {
	setPlayerRespawnTime var_respawnType;
};

if (playerRespawnTime < 10 || {var_useJRM}) then {
	setPlayerRespawnTime 10;
};

sleep 3;


// BLACK OUT //////////////////////////////////////////////////////////////////////////////////////
cutText ["","BLACK OUT",4,true];

//SLEEP FOR A WHILE
sleep 6;

//ACE SPECTATOR INTERFACE
if !(var_useJRM) then {
	[true] call ace_spectator_fnc_setSpectator;
};

//REMOTE CONTROL DISPLAY EVENT
if (!isNull (getAssignedCuratorLogic player) && {ace_spectator_enableAI}) then {
	[{!isNull findDisplay 60000},{
		private _lmf_spec_remote_control = (findDisplay 60000) displayAddEventHandler ["KeyUp",{
			_this call lmf_player_fnc_remoteControl;
		}];
	},[],120] call CBA_fnc_waitUntilAndExecute;
};

//SPECTATOR SETTINGS
0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
4 enableChannel false;
5 enableChannel false;

//FADE IN
cutText ["","BLACK IN",4,true];


// RETURN /////////////////////////////////////////////////////////////////////////////////////////