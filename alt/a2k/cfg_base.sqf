enableSaving [false,false];
enableEnvironment [false, true];
enableSentences false;

// COMPILE ////////////////////////////////////////////////////////////////////////////////////////
Zen_OccupyHouse = compileFinal preprocessFileLineNumbers "a2k\ai\task\Zen_OccupyHouse.sqf";
fn_TaskSuppress =  compile preprocessFileLineNumbers "a2k\ai\task\fn_taskSuppress.sqf";

// F3 /////////////////////////////////////////////////////////////////////////////////////////////
// MAPCLICK TELEPORT
if (a2k_deploy) then {
	f_var_mapClickTeleport_Uses = 1;				// How often the teleport action can be used. 0 = infinite usage.
	f_var_mapClickTeleport_TimeLimit = 0; 			// If higher than 0 the action will be removed after the given time.
	f_var_mapClickTeleport_GroupTeleport = true; 	// False: everyone can teleport. True: Only group leaders can teleport and will move their entire group.
	f_var_mapClickTeleport_Units = [];				// Restrict map click teleport to these units
	f_var_mapClickTeleport_Height = a2k_parachuteHeight;				// If > 0 map click teleport will act as a HALO drop and automatically assign parachutes to units
	[] execVM "f\mapClickTeleport\f_mapClickTeleportAction.sqf";
};

// INCLUDE ////////////////////////////////////////////////////////////////////////////////////////
#include "scripts\markers.sqf";
#include "scripts\aceActions.sqf";