// F3 - Mission Maker Teleport
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// Only run this for players
if (isDedicated) exitWith{};

// ====================================================================================

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

_role = roleDescription player;
if (_role find "Vehicle" >= 0 OR _role find "Heli" >= 0 OR _role find "Fighter" >= 0) exitWith {};

// ====================================================================================

// SET UP VARIABLES
// Make sure all global variables are initialized
if (isNil "f_var_mapClickTeleport_Uses") then {f_var_mapClickTeleport_Uses = 0};
if (isNil "f_var_mapClickTeleport_TimeLimit") then {f_var_mapClickTeleport_TimeLimit = 0};
if (isNil "f_var_mapClickTeleport_GroupTeleport") then {f_var_mapClickTeleport_GroupTeleport = false};
if (isNil "f_var_mapClickTeleport_Units") then {f_var_mapClickTeleport_Units = []};
if (isNil "f_var_mapClickTeleport_Height") then {f_var_mapClickTeleport_Height = 0};

// Make sure that no non-existing units have been parsed
{
	if (isNil _x) then {
		f_var_mapClickTeleport_Units set [_forEachIndex,objNull];
	} else {
		f_var_mapClickTeleport_Units set [_forEachIndex,call compile format ["%1",_x]];
	};
} forEach f_var_mapClickTeleport_Units;

// Reduce the array to valid units only
f_var_mapClickTeleport_Units = f_var_mapClickTeleport_Units - [objNull];

// ====================================================================================

// CHECK IF COMPONENT SHOULD BE ENABLED
// We end the script if it is not running on a server or if only group leaders can use
// the action and the player is not the leader of his/her group

if (count f_var_mapClickTeleport_Units > 0 && !(player in f_var_mapClickTeleport_Units)) exitWith {};
if (f_var_mapClickTeleport_GroupTeleport && player != leader group player)  exitWith {};

// ====================================================================================

// SET KEY VARIABLES
// Setup the localized strings for the various stages of the component
// Depending on the setting of the height variable the strings either use the teleport or the HALO option.

a2k_f_deploy = format ["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa'/> %1", "DEPLOY"];
a2k_f_paradrop = format ["<img image='\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\supplydrop_ca.paa'/> %1", "PARADROP"];

deployAction = if (f_var_mapClickTeleport_Height == 0) then {a2k_f_deploy} else {a2k_f_paradrop};

//f_var_mapClickTeleport_textAction = localize format ["STR_f_mapClick%1Action",_string];
//f_var_mapClickTeleport_textDone = localize format ["STR_f_mapClick%1Done",_string];
//f_var_mapClickTeleport_textSelect = localize format ["STR_f_mapClick%1Select",_string];

// ====================================================================================

// ADD TELEPORT ACTION TO PLAYER ACTION MENU
// Whilst the player is alive we add the teleport action to the player's action menu.
// If the player dies we wait until he is alive again and re-add the action.

waitUntil {!isNil "var_warmup"};
waitUntil {!var_warmup};
sleep 5;

//_img2 = "a2k\fx\lambs.paa"; // "\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa"

a2k_a_mapClickTele = ["mapclicktele","DEPLOY","\A3\ui_f\data\map\vehicleicons\iconParachute_ca.paa",{[] spawn f_fnc_mapClickTeleportUnit},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], a2k_a_mapClickTele] call ace_interact_menu_fnc_addActionToObject;

if (f_var_mapClickTeleport_TimeLimit > 0) then {
	sleep f_var_mapClickTeleport_TimeLimit;
	[player, 1,["ACE_SelfActions","mapclicktele"]] call ace_interact_menu_fnc_removeActionFromObject;
};



