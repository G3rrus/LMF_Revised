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
if !(var_tfar) then {
	[] execVM "framework\shared\init\acreChannelLabels.sqf";
};

//DISABLE RHS ENGINE STARTUP
RHS_ENGINE_STARTUP_OFF = false;



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

    //VARIABLE FOR INITPLAYERSAFETY
	lmf_isSafe = false;

	//CREATE A RADIO CHANNEL FOR CHAT COMMANDS
	if (isNil "fpa_main") then {
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

	//FIRED NEAR EH
	_id = _unit addEventHandler ["FiredNear", {
		_this call lmf_ai_fnc_firedNearEH;
	}];
	_unit setvariable ["lmf_ai_firedNear_EH", _id];

	//LOKAL EH (To remove and reapply all EHs if locality changes.)
	private _id = _unit addEventHandler ["Local", {
		params ["_unit"];
		_unit removeEventHandler ["killed", _unit getVariable ["lmf_ai_killed_EH", -1]];
		_unit removeEventHandler ["FiredNear", _unit getVariable ["lmf_ai_firedNear_EH" ,-1]];
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
if !(var_tfar) then {
	[] spawn lmf_player_fnc_acreChannelPreset;
} else {
	["Set_SwFrq","OnRadiosReceived",{
		_this call lmf_player_fnc_tfarSetSr;
	},objNull] call TFAR_fnc_addEventHandler;
};

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
	player setDiaryRecordText [["Diary", lmf_toeBriefing], ["  TO/E",[] call lmf_player_fnc_toeBriefing]];
}] call CBA_fnc_addEventHandler;

//INTRO + WARMUP
[] execVM "framework\player\init\warmup.sqf";

//ZEUS MODULES
if !(isNil "zen_custom_modules_fnc_register") then {
	[] execVM "framework\player\init\zenModules.sqf";
};

//CHAT COMMANDS
if (isNil "fpa_main") then {
	[] execVM "framework\player\init\chatCommands.sqf";
};

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