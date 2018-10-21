// JIP TELEPORT TO GROUP
// Gives a player that JIPs an ACE self-interaction to teleport themselves to their group
// Checks if the groupleader is in a vehicle and tries to move the player into an available seat if it exists

waitUntil {!isNull player};
if (player == leader group player) exitWith {};

if (didJIP) then {
	[] spawn {
	sleep 1;
	
	// Create ACE action and add to player self-interact
	a2k_jipTeleAction = ["teletogroup","TELEPORT TO SQUAD","\a3\Ui_f\data\GUI\Cfg\CommunicationMenu\transport_ca.paa",{[] spawn a2k_teleportToGroup},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], a2k_jipTeleAction] call ace_interact_menu_fnc_addActionToObject;

	
	a2k_teleportToGroup = {

		_leadGrp = leader group player;

		// Move player to groups leader (into vehicle if it exists and has a free seat)
		_avDriver = vehicle _leadGrp emptyPositions "driver";
		_avCommander = vehicle _leadGrp emptyPositions "commander";
		_avGunner = vehicle _leadGrp emptyPositions "gunner";
		_avTurret = vehicle _leadGrp emptyPositions "turret";
		_avCargo = vehicle _leadGrp emptyPositions "cargo";
		_freeSeat = if (_avDriver > 0 OR _avCommander > 0 OR _avGunner > 0 OR _avTurret > 0 OR _avCargo > 0) then {true};

		if (_freeSeat) then
		{
			cutText  ["", "BLACK OUT", 1, true];
			player moveInAny vehicle _leadGrp;
			cutText  ["", "BLACK IN", 1, true];
		} else
		{
			cutText  ["", "BLACK OUT", 1, true];
			player setVehiclePosition [getPos _leadGrp, [], 10];
			cutText  ["", "BLACK IN", 1, true];
		};

		// Remove ACE action after use
		[player, 1,["ACE_SelfActions","teletogroup"]] call ace_interact_menu_fnc_removeActionFromObject;

	};

	// Wait 5min and then remove ACE action if it still exists/not used
	sleep 300;
	[player, 1,["ACE_SelfActions","teletogroup"]] call ace_interact_menu_fnc_removeActionFromObject;
	};
};