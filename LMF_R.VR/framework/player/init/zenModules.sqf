// ZEN ZEUS FUNCTIONS  ///////////////////////////////////////////////////////////////////////////
/*
	- If Zen is on this file will create several zeus modules in the "LMF" section.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//DEFINE AVAILABLE OPTIONS FOR MODULES
LMF_groupTypes = ["TEAM", "SQUAD", "SENTRY","ATTEAM","AATEAM", "MGTEAM","CUSTOM AMOUNT"];

//RE-APPLY LOADOUT
["LMF", "Re-apply Loadout", {
	//GET PASSED PARAMS
	params ["", "_obj"];

	//EXIT IF NO UNIT
	if (isNull _obj) exitWith {["ERROR: No Unit"] call zen_common_fnc_showMessage};

	//IF THERE IS A DUDE GIVE LOADOUT
	[_obj] remoteExec ["lmf_player_fnc_initPlayerGear"];

}] call zen_custom_modules_fnc_register;

//AI GARRISON
["LMF", "AI Garrison",{
	["Garrison",[
		//PARAMS
		["COMBO","Group Type",[LMF_groupTypes,LMF_groupTypes,0]],
		["SLIDER","Custom Amount",[1,60,4,0]],
		["EDIT","Garrison Radius",["100"]],
		["CHECKBOX","Fill Evenly",false]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type","_amount","_radius","_distrib"];

		_pos = ASLToATL _pos;
		_radius = parseNumber _radius;
		_distrib = [0,1] select !_distrib;
		if (_type == "CUSTOM AMOUNT") then {
			_type = round _amount;
		};

		// CALL FUNCTION
		[_pos,_type,_radius,_distrib] remoteExec ["lmf_ai_fnc_garrison"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//AI PATROL
["LMF", "AI Patrol",{
	["Patrol",[
		//PARAMS
		["COMBO","Group Type",[LMF_groupTypes,LMF_groupTypes,0]],
		["SLIDER","Custom Amount",[1,60,4,0]],
		["EDIT","Patrol Radius",["100"]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type","_amount","_radius"];

		_pos = ASLToATL _pos;
		_radius = parseNumber _radius;
		if (_type == "CUSTOM AMOUNT") then {
			_type = round _amount;
		};

		// CALL FUNCTION
		[_pos,_type,_radius] remoteExec ["lmf_ai_fnc_patrol"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//AI QRF
["LMF", "AI QRF",{
	["QRF",[
		//PARAMS
		["COMBO","Group Type",[LMF_groupTypes,LMF_groupTypes,0]],
		["SLIDER","Custom Amount",[1,60,4,0]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type","_amount"];

		_pos = ASLToATL _pos;
		if (_type == "CUSTOM AMOUNT") then {
			_type = round _amount;
		};

		// CALL FUNCTION
		[_pos,_type] remoteExec ["lmf_ai_fnc_infantryQRF"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//AI HUNTER
["LMF", "AI Hunter",{
	["Hunter",[
		//PARAMS
		["COMBO","Group Type",[LMF_groupTypes,LMF_groupTypes,0]],
		["SLIDER","Custom Amount",[1,60,4,0]],
		["EDIT","Hunting Radius",["500"]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type","_amount","_radius"];

		_pos = ASLToATL _pos;
		_radius = parseNumber _radius;
		if (_type == "CUSTOM AMOUNT") then {
			_type = round _amount;
		};

		// CALL FUNCTION
		[_pos,_type,_radius] remoteExec ["lmf_ai_fnc_infantryHunter"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//VEHICLE QRF
["LMF", "Vehicle QRF",{
	private _options = ["CAR","CARARMED","TRUCK","APC","TANK","HELITRANSPORT","HELIATTACK"];
	["Vehicle QRF",[
		//PARAMS
		["COMBO","Vehicle Type",[_options,_options,2]]
	],{
		//PARSE PARAMS
		params ["_dialog","_pos"];
		_dialog params ["_type"];

		_pos = ASLToATL _pos;

		// CALL FUNCTION
		[_pos,_type] remoteExec ["lmf_ai_fnc_vehicleQRF"];

	},{},_this#0] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;

//PARA QRF
["LMF", "PARA QRF",{
	//PARAMS
	private _pos = ASLToATL (_this#0);

	//CALL FUNCTION
	[_pos] remoteExec ["lmf_ai_fnc_paraQRF"];
}] call zen_custom_modules_fnc_register;

//AI MORTAR ATTACK
["LMF", "Mortar Attack",{
	private _players = [] call CBA_fnc_players;
	if (count _players == 0) exitWith {["ERROR: No Targets"] call zen_common_fnc_showMessage};
	private _names = _players apply {name _x};
	private _ammo = getArtilleryAmmo [_this#1];
	private _names_ammo = _ammo apply {getText(configFile >> "CfgMagazines" >> _x >> "displayName")};
	["Mortar Attack",[
		//PARAMS
		["COMBO", "Target", [_players, _names]],
		["COMBO","Type of Round",[_ammo,_names_ammo,0]],
		["SLIDER","Rounds",[1,5,2,0]],
		["SLIDER","Accuracy",[60,600,200,0]]
	],{
		//PARSE PARAMS
		params ["_dialog","_mortar"];
		_dialog params ["_target","_type","_amount","_accuracy"];

		if (isNull _target) exitWith {["ERROR: Unable To Find Target"] call zen_common_fnc_showMessage};
		if (isNull _mortar) exitWith {["ERROR: Unable To Find Mortar"] call zen_common_fnc_showMessage};

		_amount = round _amount;
		_accuracy = round _accuracy;

		// CALL FUNCTION
		[_target,_mortar,_type,_amount,_accuracy] remoteExec ["lmf_ai_fnc_mortarattack"];

	},{},_this#1] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;