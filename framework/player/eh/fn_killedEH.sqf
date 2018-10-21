// PLAYER RESPAWN EH //////////////////////////////////////////////////////////////////////////////
/*
	- This function spawned by the player respawn EH handles what happens on a players respawn.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit","_killer"];


//BLACK OUT ///////////////////////////////////////////////////////////////////////////////////////
cutText  ["", "BLACK OUT", 4, true];
[false] call ace_common_fnc_setVolume;

//DISPLAY KILLER
private _killerName = name _killer;
private _distance = floor (_unit distance _killer);
private _weaponName = getText (configFile >> "cfgWeapons" >> currentWeapon _killer >> "displayname");
sleep 3;
if (!isNull _killer && {_killer != _unit}) then {
		systemChat format ["You were killed by %1 from %2m",_killerName,_distance,_weaponName];
};


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



//SET ACRE SPECTATOR
[true] call acre_api_fnc_setSpectator;
sleep 4;


// INITIALIZE SPECTATOR ///////////////////////////////////////////////////////////////////////////
["Initialize", [_unit, [], false, true, true, false, false, false, false, true]] call BIS_fnc_EGSpectator;
[true] call ace_common_fnc_setVolume;


//ADD CUSTOM CHAT CHANNEL AND NOTIFY PLAYER
[_unit,false] remoteExec ["lmf_server_fnc_spectatorChannel", 2];

sleep 1;

0 enableChannel false;
1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
4 enableChannel false;
5 enableChannel false;


//FADE IN
cutText  ["", "BLACK IN", 5, true];

//RESPAWN COUNTER
[] spawn 
{
nk_fnc_timemagic = {
  private ["_n"];
  _n = _this select 0; 
  if (_n < 10) then {_n = format ["0%1",_n]};
  _n
};

  waitUntil {playerRespawnTime < 4000};

  while {playerRespawnTime > 0 and !alive player} do 
  {
  if (typename var_respawnType == "STRING") then {
  if (var_respawnType == "WAVE") then {
  _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call nk_fnc_timemagic,[(playerRespawnTime mod 60)] call nk_fnc_timemagic];
  //_stitle = "<t size='1.4' align='Center'>Respawn</t><br/>";
  _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
  hintSilent parsetext (_time);
  uiSleep 1;
  };

  if (var_respawnType == "OFF") then {
  _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call nk_fnc_timemagic,[(playerRespawnTime mod 60)] call nk_fnc_timemagic];
  //_stitle = "<t size='1.4' align='Center'>Respawn</t><br/>";
  _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
  hintSilent parsetext (_time);
  uiSleep 1;
  };
};
  if (typename var_respawnType == "SCALAR") then {
  _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call nk_fnc_timemagic,[(playerRespawnTime mod 60)] call nk_fnc_timemagic];
  //_stitle = "<t size='1.4' align='Center'>Respawn</t><br/>";
  _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
  hintSilent parsetext (_time);
  uiSleep 1;
  };



  };
  // End it! 
  hintSilent ""; 
};