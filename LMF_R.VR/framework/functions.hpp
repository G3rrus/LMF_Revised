class common {
	tag = "lmf_common";
	class common_init {
		file = "framework";
		class sortAirVics {};
		class sortGroundVics {};
		class sortSupplies {};
		class sortUnits {};
	};
};
class ai {
	tag = "lmf_ai";
	class ai_init {
		file = "framework\ai";
		class initAir {};
		class initMan {};
		class initVic {};
	};
	class ai_eventhandlers {
		file = "framework\ai\eh";
		class firedNearEH {};
		class killedEH {};
		class suppressEH {};
	};
	class ai_spawning {
		file = "framework\ai\spawning";
		class barricades {};
		class doSpawn {};
		class garrison {};
		class getClosest {};
		class infantryHunter {};
		class infantryQRF {};
		class makeType {};
		class paraQRF {};
		class patrol {};
		class staticQRF {};
		class vehicleQRF {};
	};
	class ai_tasks {
		file = "framework\ai\task";
		class taskSuppress {};
		class taskAssault {};
		class taskUpdateWP {};
		class taskHunt {};
		class mortarAttack {};
		class findCover {};
	};
};
class ai_civ {
	tag = "lmf_ai_civ";
	class ai_init_civ {
		file = "framework\ai\civ";
		class initCiv {};
	};
	class ai_eventhandlers_civ {
		file = "framework\ai\civ\eh";
		class firedNear {};
	};
};
class player {
	tag = "lmf_player";
	class player_init {
		file = "framework\player";
		class initPlayerAir {};
		class initPlayerGear {};
		class initPlayerSupp {};
		class initPlayerVic {};
	};
	class player_briefing {
		file = "framework\player\briefing";
		class loadoutBriefing {};
		class toeBriefing {};
	};
	class player_chat {
		file = "framework\player\chat";
		class getPlayer {};
		class sendChatMessage {};
	};
	class player_eventhandlers {
		file = "framework\player\eh";
		class explosionEH {};
		class hitEH {};
		class killedEH {};
		class respawnEH {};
		class viewDistanceEH {};
	};
	class player_jip {
		file = "framework\player\jip";
		class jipChooseTarget {};
		class jipEmptySeat {};
	};
};
class player_loadout {
	tag = "lmf_loadout";
	class player_loadout {
		file = "framework\player\loadouts";
		class acreChannelPreset {};
		class ammoBearer {};
		class atAssistant {};
		class atGunner {};
		class autorifleman {};
		class crew {};
		class engineer {};
		class fac {};
		class givePrimary {};
		class grenadier {};
		class heloCrew {};
		class heloPilot {};
		class machineGunner {};
		class machineGunnerAssistant {};
		class marksman {};
		class medic {};
		class pilot {};
		class platoonLeader {};
		class platoonSergeant {};
		class rifleman {};
		class rto {};
		class squadLeader {};
		class teamLeader {};
	};
};
class player_tasks {
	tag = "lmf_task";
	class player_tasks {
		file = "framework\player\tasks";
		class intelAction {};
	};
};