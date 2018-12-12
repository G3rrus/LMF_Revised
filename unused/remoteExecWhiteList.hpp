//COMPONENT TO MAKE LMF WORK ON BE ENABLED SERVER (UNTESTED) //////////////////////////////////////
/*
1. Move this file into the framework folder (where functions.hpp is located)
2. Put the following below cfgFunctions in your description.ext

	class CfgRemoteExec {
		#include "framework\remoteExecWhiteList.hpp"
	};

*/
///////////////////////////////////////////////////////////////////////////////////////////////////
class Functions {
	mode = 1;
	jip = 0;

	class BIS_fnc_debugConsoleExec {
		jip = 1;
	};
	class lmf_admin_fnc_adminTP {};
	class lmf_admin_fnc_performanceCheck {};
	class lmf_admin_fnc_playerSafety {};
	class lmf_ai_fnc_garrison {};
	class lmf_ai_fnc_infantryHunter {};
	class lmf_ai_fnc_infantryQRF {};
	class lmf_ai_fnc_paraQRF {};
	class lmf_ai_fnc_patrol {};
	class lmf_ai_fnc_vehicleQRF {};
	class lmf_admin_fnc_endWarmup {
		allowedTargets = 2;
	};
	class lmf_admin_fnc_respawnWave {
		allowedTargets = 2;
	};
	class lmf_admin_fnc_initAdminTP {
		allowedTargets = 2;
	};
	class lmf_admin_fnc_assignZeus {
		allowedTargets = 2;
	};
	class lmf_admin_fnc_initPerformance {
		allowedTargets = 2;
	};
	class lmf_admin_fnc_initPlayerSafety {
		allowedTargets = 2;
	};
	class lmf_admin_fnc_endMission {
		allowedTargets = 2;
	};
	class ace_interact_menu_fnc_addActionToObject {
		jip = 1;
	};

};
class Commands
{
	class switchMove {};
	class systemChat {};
	class setPlayerRespawnTime {};
	class setDate {};
};