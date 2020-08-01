// BRIEFING ADMIN ACTIONS SERVER SIDE EVENT ///////////////////////////////////////////////////////
/*
	- This file adds an event which handles admin actions such as ending the briefing or doing
	  a respawn wave.
	- Arguments are: ["actionName",potential_admin_object,BOOL] (BOOL is for actions such as ending mission positive or negative)
	- Example: ["lmf_adminEventServer",["endmission",player,true]] call CBA_fnc_serverEvent;
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
["lmf_adminEventServer", {
	params ["_action","_unit","_positive"];

	if !([_unit] call lmf_server_fnc_isAdmin) exitWith {
		["lmf_adminEventClient", ["message",nil,false], _unit] call CBA_fnc_targetEvent;
	};


	// DO SPECIFIC EVENT //////////////////////////////////////////////////////////////////////////
	_action = toLower _action;
	switch (_action) do {
		//END BRIEFING
		case "endbriefing": {
			lmf_warmup = false;
			publicvariable "lmf_warmup";
		};
		//CALL GLOBAL EVENT RESPAWN
		case "respawn": {
			["lmf_adminEventClient", ["respawn"]] call CBA_fnc_globalEvent;
		};
		//CALL GLOBAL EVENT TELEPORT
		case "teleport": {
			["lmf_adminEventClient", ["teleport",_unit]] call CBA_fnc_globalEvent;
		};
		//ASSIGN ZEUS TO CALLER
		case "zeus": {
			if (isNull (getAssignedCuratorLogic _unit)) exitWith {
				private _grp = createGroup [sideLogic,true];
				private _curator = _grp createUnit ["ModuleCurator_F",[0,0,0],[],0,"NONE"];
				_curator setVariable ["Addons",3,true];

				_curator addCuratorEditableObjects [(allMissionObjects "Man"), false];
				_curator addCuratorEditableObjects [(allMissionObjects "Air"), true];
				_curator addCuratorEditableObjects [(allMissionObjects "Car"), true];
				_curator addCuratorEditableObjects [(allMissionObjects "Ammo"), false];
				_curator setVariable ["birdType",""];
				_curator setvariable ["owner","objnull"];
				_curator setVariable ["showNotification",false];
				_curator setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"];
				[_curator, [-1, -2, 2]] call bis_fnc_setCuratorVisionModes;

				_unit assignCurator _curator;
			};
		};
		//CALL GLOBAL EVENT PERFORMANCE
		case "performance": {
			["lmf_adminEventClient", ["performance",_unit]] call CBA_fnc_globalEvent;
		};
		//CALL TARGET/GLOBAL EVENT RELATING TO PLAYER SAFETY
		case "safe": {
			if (lmf_warmup) exitWith {["lmf_adminEventClient", ["message",nil,true], _unit] call CBA_fnc_targetEvent;};

			if (_positive) then {
				if !(missionNamespace getVariable ["lmf_isSafe",false]) then {
					["lmf_adminEventClient", ["safe",_unit,nil,true]] call CBA_fnc_globalEvent;
					lmf_isSafe = true;
				};
			} else {
				if (missionNamespace getVariable ["lmf_isSafe",false]) then {
					["lmf_adminEventClient", ["safe",_unit,nil,false]] call CBA_fnc_globalEvent;
					lmf_isSafe = false;
				};
			};
		};
		//END MISSION
		case "endmission": {
			if (_positive) then {
				"EveryoneWon" call BIS_fnc_endMissionServer;
			} else {
				"EveryoneLost" call BIS_fnc_endMissionServer;
			};
		};
	};
}] call CBA_fnc_addEventHandler;