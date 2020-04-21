// BRIEFING ADMIN ACTIONS CLIENT SIDE EVENT ///////////////////////////////////////////////////////
/*
	- This file adds an event which handles admin actions such as ending the briefing or doing
	  a respawn wave.
	- Arguments are: ["actionName",UNIT,BOOL or "MESSAGE",BOOL]
	- Note: UNIT is the admin that is often just passed to receive an info message or a non admin
	  being informed that he is not permitted to use these actions. Third param is either passed
	  as a bool to get 1 out of 2 info messages or as text in case of the performance check.
	  last bool is to turn safety on or off
	- Example: ["lmf_adminEventClient", ["message",objNull,"Test",true]] call CBA_fnc_globalEvent;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
["lmf_adminEventClient", {
	params ["_action","_unit","_message","_positive"];


	// DO SPECIFIC EVENT //////////////////////////////////////////////////////////////////////////
	_action = toLower _action;
	switch (_action) do {
		//SYSTEMCHAT NOTIFICATIONS (if bool was passed exitWith 1 of 2 warning messages else exit with performance message)
		case "message": {
			if (typeName _message isEqualTo "BOOL") exitWith {
				if !(_message) then {
					systemChat "Only for certified members!!!";
				} else {
					systemChat "Warmup has not even ended yet!!!";
				};
			};
			systemChat _message;
		};
		//RESPAWN PLAYERS
		case "respawn": {
			setPlayerRespawnTime 5;
		};
		//TELEPORT SOME PLAYERS
		case "teleport": {
			if (!hasInterface || {!alive player || {vehicle player isKindOf "Air" || {player == _unit}}}) exitWith {};

			player allowDamage false;
			player setVelocity [0,0,0];
			player action ["Eject",vehicle player];
			player setPosATL (_unit getPos [random 10, random 360]);
			player switchMove "";
			player allowDamage true;
		};
		//EXIT EVERYONE BUT SERVER AND HCs THEN SPAWN THE SENDING OF MESSAGES
		case "performance": {
			if (hasinterface && {!isserver}) exitWith {};
			if (isServer) then {
				["lmf_adminEventClient", ["message",nil,"Checking Performance!!!"], _unit] call CBA_fnc_targetEvent;
			};
			[_unit] spawn {
				for "_i" from 1 to 10 do {
					private _text = format ["%1 has %2 FPS (%3/10)", ["Headless client","Server"] select (isServer),round diag_fps,_i];
					["lmf_adminEventClient", ["message",nil,_text], _this#0] call CBA_fnc_targetEvent;
					sleep 5;
				};
			};
		};
		//ENTER OR EXIT SAFETY, DISPLAY MESSAGE TO CALLER
		case "safe": {
			if !(hasInterface) exitWith {};

			if (_positive) then {
				lmf_noGuns = player addEventHandler ["Fired", {deleteVehicle (_this select 6);}];
				player allowDamage false;
				[player,currentWeapon player,currentMuzzle player] call ace_safemode_fnc_lockSafety;
				if (player == _unit) then {systemChat "Safety On!!!";};
			} else {
				player removeEventHandler ["Fired",lmf_noGuns];
				player allowDamage true;
				[player,currentWeapon player,currentMuzzle player] call ace_safemode_fnc_unlockSafety;
				if (player == _unit) then {systemChat "Safety Off!!!";};
			};
		};
	};
}] call CBA_fnc_addEventHandler;