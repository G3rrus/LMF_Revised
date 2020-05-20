// XEH POST INIT //////////////////////////////////////////////////////////////////////////////////
/*
	- Big thanks to diwako for the help with assembling most of the more complicated code in here.
	- File that handles what happens post init.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
// EVERYONE ///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//DISABLE VARIOUS
enableSentences false;
enableEnvironment [false, true];
enableSaving [false,false];

//ZEUS PINGED EH
["ModuleCurator_F", "initPost", {
	params ["_module"];
	_module addEventHandler ["CuratorPinged", {
		params ["_curator", "_unit"];
		private _zeus = getAssignedCuratorUnit _curator;
		if (isNull _zeus) then {
			unassignCurator _curator;
			deleteVehicle _curator;
		} else {
			if (_zeus == player) then {
				systemChat format ["%1 just pinged", name _unit];
				format ["Ping received by %1!",name player] remoteExec ["systemChat", _unit];
			};
		};
	}];
}, false, [], true] call CBA_fnc_addClassEventHandler;

//RADIO CHANNEL LABLES
[] execVM "framework\shared\init\acreChannelLabels.sqf";

//DISABLE RHS ENGINE STARTUP
RHS_ENGINE_STARTUP_OFF = false;

//ADMIN ACTIONS
[] execVM "framework\shared\init\adminActionsClient.sqf";



///////////////////////////////////////////////////////////////////////////////////////////////////
// SERVER /////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
if (isServer) then {
	//BROADCAST WARMUP IF ENABLED
	if (var_warmup) then {
		lmf_warmup = true;
		publicVariable "lmf_warmup";
		[] execVM "framework\server\init\resetDate.sqf";
	} else {
		lmf_warmup = false;
		publicVariable "lmf_warmup";
	};

	//CREATE VARIOUS MARKERS
	[] execVM "framework\server\init\markers.sqf";

	//CREATE A RADIO CHANNEL FOR CHAT COMMANDS
	if !(isClass (configfile >> "CfgPatches" >> "fpa_main")) then {
		lmf_chatChannel = radioChannelCreate [[0.9,0.1,0.1,1], "Chat", "Chat", [], true];
    	publicVariable "lmf_chatChannel";
	};

	//UPDATE TOE BRIEFING ENTRY
	addMissionEventHandler ["PlayerConnected",{
		["lmf_updateToe",[]] call CBA_fnc_globalEvent;
	}];

	addMissionEventHandler ["PlayerDisconnected",{
		[{["lmf_updateToe",[]] call CBA_fnc_globalEvent;}, [], 5] call CBA_fnc_waitAndExecute;
	}];

	//ADMIN ACTIONS
	[] execVM "framework\server\init\adminActionsServer.sqf";
};



///////////////////////////////////////////////////////////////////////////////////////////////////
// HEADLESS ///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
if (!isServer || !hasInterface) then {
	["lmf_hcSpawn",{
		params ["_type","_argsArray"];

		switch (_type) do {
			case "barricades": {_argsArray spawn lmf_ai_fnc_barricades;};
			case "garrison": {_argsArray spawn lmf_ai_fnc_garrison;};
			case "hunter": {_argsArray spawn lmf_ai_fnc_infantryHunter;};
			case "qrf": {_argsArray spawn lmf_ai_fnc_infantryQRF;};
			case "para": {_argsArray spawn lmf_ai_fnc_paraQRF;};
			case "patrol": {_argsArray spawn lmf_ai_fnc_patrol;};
			case "staticqrf": {_argsArray spawn lmf_ai_fnc_staticQRF;};
			case "vicqrf": {_argsArray spawn lmf_ai_fnc_vehicleQRF;};
		};
	}] call CBA_fnc_addEventHandler;
};



///////////////////////////////////////////////////////////////////////////////////////////////////
// AI /////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//'APPLY EVENTHANDLERS' EVENT (To avoid problems with locality change. (thanks Diwako))
["lmf_ai_listener", {
	//PARAMS INITIALLY PASSED FROM LOCAL EVENT IN INITMAN.SQF
	params ["_unit", ["_getSuppression", false]];

	//KILLED EH
	private _id = _unit addEventHandler ["Killed", {
		_this call lmf_ai_fnc_killedEH;
	}];
	_unit setvariable ["lmf_ai_killed_EH", _id];

	//SUPPRESSION EH
	if (_getSuppression) then {
		_unit setSkill ((skill _unit) * 1.4);
		private _id = _unit addEventHandler ["Fired", {
			_this call lmf_ai_fnc_suppressEH;
		}];
		_unit setvariable ["lmf_ai_suppression_EH", _id];
	};
	_unit setvariable ["lmf_ai_suppression",_getSuppression];

	//FIRED NEAR EH (if no LAMBS DANGER)
	if !(isClass (configfile >> "CfgPatches" >> "lambs_main")) then {
		_id = _unit addEventHandler ["FiredNear", {
			_this call lmf_ai_fnc_firedNearEH;
		}];
		_unit setvariable ["lmf_ai_firedNear_EH", _id];
	};

	//LOKAL EH (To remove and reapply all EHs if locality changes.)
	private _id = _unit addEventHandler ["Local", {
		params ["_unit"];
		_unit removeEventHandler ["killed", _unit getVariable ["lmf_ai_killed_EH", -1]];
		if !(isClass (configfile >> "CfgPatches" >> "lambs_main")) then {
			_unit removeEventHandler ["FiredNear", _unit getVariable ["lmf_ai_firedNear_EH" ,-1]];
		};
		if (_unit getVariable ["lmf_ai_suppression_EH" ,-1] >= 0) then {
			_unit removeEventHandler ["Fired", _unit getVariable ["lmf_ai_suppression_EH" ,-1]];
		};
		_unit removeEventHandler ["Local", _unit getVariable ["lmf_ai_local_EH" ,-1]];
		//REAPPLY EHS
		["lmf_ai_listener", [_unit, _unit getVariable ["lmf_ai_suppression" ,false]], _unit] call CBA_fnc_targetEvent;
	}];
	_unit setvariable ["lmf_ai_local_EH", _id];
}] call CBA_fnc_addEventHandler;

//CIV PANIC LISTENER
["lmf_ai_civ_listener", {
	params ["_unit"];
	[_unit] call lmf_ai_civ_fnc_initCiv;
}] call CBA_fnc_addEventHandler;



///////////////////////////////////////////////////////////////////////////////////////////////////
// PLAYER /////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
//MAKE SURE ITS REALLY A PLAYER
if !(hasinterface) exitWith {};
waitUntil {!isNull player};

//GROUP MARKERS
if (var_groupTracker && !(missionNamespace getVariable ["ace_map_BFT_Enabled",false])) then {
	[] execVM "framework\player\init\groupTracker.sqf";
};

//UNIT TRACKER
if (var_unitTracker) then {[] execVM "framework\player\init\unitTracker.sqf";};

//TEAM COLORS
[] execVM "framework\player\init\teamColors.sqf";

//PLAYER RATING
player addEventHandler ["HandleRating", {0}];

//EXPLOSION EFFECT
player addEventHandler ["Explosion", {
	_this spawn lmf_player_fnc_explosionEH;
}];

//HIT EFFECT
player addEventHandler ["Hit", {
	_this spawn lmf_player_fnc_hitEH;
}];

//KILLED EH
player addEventHandler ["Killed", {
	_this spawn lmf_player_fnc_killedEH;
}];

//KILLED MESSAGES
["acex_killtracker_death",{
	params ["_killerName", "_killInfo"];
	[{titleText [format ["Died: %1 %2", _this select 0, _this select 1], "PLAIN", 0.5, true,true];}, [_killerName,_killInfo], 4] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

//RESPAWN EH
player addEventHandler ["Respawn", {
	_this spawn lmf_player_fnc_respawnEH;
}];

//PLAYER GEAR
if (var_playerGear) then {
	[player] call lmf_player_fnc_initPlayerGear;
};

//BRIEFING
[] execVM "framework\player\init\briefing.sqf";

//RADIO CHANNEL PRESET
[] spawn lmf_loadout_fnc_acreChannelPreset;

//PLAYER CAMOCOEF
[{player setUnitTrait ["camouflageCoef",var_camoCoef];}, [], 5] call CBA_fnc_waitAndExecute;

//PLAYER VIEWDISTANCE
if (var_viewEnabled) then {
	["vehicle",{
		[] call lmf_player_fnc_viewDistanceEH;
	}] call CBA_fnc_addPlayerEventHandler;
};

//ACE ACTIONS
[] execVM "framework\player\init\aceActions.sqf";

//ARSENAL
if (var_personalArsenal) then {
	[] execVM "framework\player\init\personalArsenal.sqf";
};

//JIP
if (var_jipTP && {CBA_missionTime > 5*60}) then {
	[] execVM "framework\player\init\jipTeleport.sqf";
};

//JRM RESPAWN
if (!isNil "fpa_jrm_fnc_init" && {var_useJRM}) then {
	[var_livesJRM] call fpa_jrm_fnc_init;
};

//UPDATE TOE EVENT
["lmf_updateToe",{
	player setDiaryRecordText [["Briefing",lmf_toeBriefing], ["TO/E",[] call lmf_player_fnc_toeBriefing]];
}] call CBA_fnc_addEventHandler;

//INTRO + WARMUP
[] execVM "framework\player\init\warmup.sqf";

//ZEUS MODULES
if !(isNil "zen_custom_modules_fnc_register") then {
	[] execVM "framework\player\init\zenModules.sqf";
};

//CHAT COMMANDS AND HELPER MESSAGES
if !(isClass (configfile >> "CfgPatches" >> "fpa_main")) then {
	[] execVM "framework\player\init\chatCommands.sqf";
	if (var_helpMessages) then {
		[] execVM "framework\player\init\medicalHelpMessages.sqf";
	};
};

//MAKE VEHICLES HOT (thx veteran29 for feedback)
["visionMode",{
    params ["_unit", "_newVisionMode"];
    if (_newVisionMode isEqualTo 2 && {missionNamespace getVariable ["lmf_thermalReady",true]}) then {

		private _maxDistance = 3500 min (getObjectViewDistance select 0);
		private _vicsToChange = nearestObjects [_unit, ["Car","Tank","StaticWeapon"],_maxDistance];
		{
			_x setVehicleTIPars [1, 1, 1];
		} count _vicsToChange;

		lmf_thermalReady = false;
		[{lmf_thermalReady = true},[],60] call CBA_fnc_waitAndExecute;
	};
}, true] call CBA_fnc_addPlayerEventHandler;

//GRANT RC TOKEN EVENT
["lmf_grantRemote",{
	if !(isNull (getAssignedCuratorLogic player)) exitWith {};
	private _lmf_spec_remote_control = (findDisplay 60000) displayAddEventHandler ["KeyUp",{
		_this call lmf_player_fnc_remoteControl;
	}];
	titleText ["<t color='#FFBA26' size='2'>RC Token Granted!</t>","PLAIN DOWN",1,true,true];
}] call CBA_fnc_addEventHandler;

//CHANNEL SETUP
0 enableChannel false;
1 enableChannel true;
2 enableChannel false;
3 enableChannel true;
4 enableChannel false;
5 enableChannel false;

//APPLY TEXTURES TO LAPTOPS
if !(isNil "ammoSpawner") then {ammoSpawner setObjectTexture [0, "framework\fx\supplies.jpg"];};
if !(isNil "airSpawner") then {airSpawner setObjectTexture [0, "framework\fx\airVehicles.jpg"];};
if !(isNil "crateRoles") then {crateRoles setObjectTexture [0, "framework\fx\roles.jpg"];};
if !(isNil "groundSpawner") then {groundSpawner setObjectTexture [0, "framework\fx\groundVehicles.jpg"];};