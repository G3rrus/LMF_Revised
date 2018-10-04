// made by Alex2k, modified by G4rrus

["Preload"] call BIS_fnc_arsenal;

waitUntil {CBA_missionTime > 5};

waitUntil {!isNil "var_personalArsenal";};
if (!var_personalArsenal) exitWith {};

#include "cfg_player.sqf";

sleep 5;


// ADD GEAR BASED ON ROLES ////////////////////////////////////////////////////////////////////////
_role = roleDescription player;
_veh = _role find "Vehicle" >= 0;
_heli = _role find "Heli" >= 0;
_fighter = _role find "Fighter" >= 0;
_inf = _role find "Vehicle" != 0 AND _role find "Heli" != 0 AND _role find "Fighter" != 0;


if (_inf) then {
//	[player, _Headgear_A, false, false] call BIS_fnc_addVirtualItemCargo;
	[player, _Goggles_A, false, false] call BIS_fnc_addVirtualItemCargo;
};

if (_veh) then {
//	[player, _Headgear_A, false, false] call BIS_fnc_addVirtualItemCargo;
	[player, _Goggles_A, false, false] call BIS_fnc_addVirtualItemCargo;
};

if (_heli) then {
//	[player, _Headgear_A, false, false] call BIS_fnc_addVirtualItemCargo;
	[player, _Goggles_A, false, false] call BIS_fnc_addVirtualItemCargo;
};

if (_fighter) then {
//	[player, _Headgear_A, false, false] call BIS_fnc_addVirtualItemCargo;
	[player, _Goggles_A, false, false] call BIS_fnc_addVirtualItemCargo;
};



//REMOVE ABILITY TO RANDOMIZE/SAVE/LOAD/EXPORT/IMPORT LOADOUTS ////////////////////////////////////
[ missionNamespace, "arsenalOpened", {
    disableSerialization;
    _display = _this select 0;

    {
		( _display displayCtrl _x ) ctrlSetTextColor [ 1, 0, 0, 0.3 ];
        ( _display displayCtrl _x ) ctrlRemoveAllEventHandlers "buttonclick";
		( _display displayCtrl _x ) ctrlEnable false;
    }forEach [44150,44146,44147,44148,44149,44151,954,930,931,932,935,939,940,941,942,943,944,933,934,938,900,901,902,903,904,905,908,909,936,906];
	
	_display displayAddEventHandler ["KeyDown", "true"];

} ] call BIS_fnc_addScriptedEventHandler;


//ON ARSENAL OPENED
[missionNamespace, "arsenalOpened", {
		//Light in front of character
		a2k_arsenalLight1 = "#lightpoint" createVehicleLocal position player;
		a2k_arsenalLight1 setLightBrightness 1;
		a2k_arsenalLight1 setLightAmbient [0.0, 0.0, 0.0];
		a2k_arsenalLight1 setLightColor [1.0, 1.0, 1.0];
		a2k_arsenalLight1 lightAttachObject [player, [0,3,5]];
		
		//Light behind character
		a2k_arsenalLight2 = "#lightpoint" createVehicleLocal position player;
		a2k_arsenalLight2 setLightBrightness 1;
		a2k_arsenalLight2 setLightAmbient [0.0, 0.0, 0.0];
		a2k_arsenalLight2 setLightColor [1.0, 1.0, 1.0];
		a2k_arsenalLight2 lightAttachObject [player, [0,-3,5]];
}] call BIS_fnc_addScriptedEventHandler;

//ON ARSENAL CLOSED
[missionNamespace, "arsenalClosed", {
	[player,""] call bis_fnc_setUnitInsignia;
	[player,a2k_playerInsignia] call bis_fnc_setUnitInsignia;
	deleteVehicle a2k_arsenalLight1;
	deleteVehicle a2k_arsenalLight2;
}] call BIS_fnc_addScriptedEventHandler;




// ADJUST GEAR
a2k_a_arsenal = ["personalarsenal","Personal Arsenal","\A3\ui_f\data\igui\cfg\weaponicons\MG_ca.paa",{["Open",[false,player, player]] spawn bis_fnc_arsenal; player action ["SwitchWeapon", player, player, 100];},{var_warmup},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","ACE_Equipment"], a2k_a_arsenal] call ace_interact_menu_fnc_addActionToObject;

// RESET GEAR
//a2k_a_resetGear = ["resetgear","Reset Gear","\a3\3DEN\Data\CfgWaypoints\Cycle_ca.paa",{[player] spawn a2k_fnc_playerGear; titleText ["Gear Reset", "PLAIN"]; titleFadeOut 5;},{var_warmup},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
//[player, 1, ["ACE_SelfActions","ACE_Equipment"], a2k_a_resetGear] call ace_interact_menu_fnc_addActionToObject;
/*
// SAVE GEAR
a2k_a_saveGear = ["savegear","Save Gear","\a3\3DEN\Data\Displays\Display3DEN\ToolBar\save_ca.paa",{ a2k_savedGear = getUnitLoadout player; titleText ["Gear Saved", "PLAIN"]; titleFadeOut 5; },{player distance LAMBS_Flag < 100},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","ACE_Equipment"], a2k_a_saveGear] call ace_interact_menu_fnc_addActionToObject;

// LOAD GEAR
a2k_a_loadGear = ["loadgear","Load Gear","\a3\3DEN\Data\Displays\Display3DEN\ToolBar\open_ca.paa",{ player setUnitLoadout a2k_savedGear; titleText ["Gear Loaded", "PLAIN"]; titleFadeOut 5; },{player distance LAMBS_Flag < 100 AND !isNil "a2k_savedGear"},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","ACE_Equipment"], a2k_a_loadGear] call ace_interact_menu_fnc_addActionToObject;