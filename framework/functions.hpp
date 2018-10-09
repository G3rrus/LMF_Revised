class common {
    tag = "lmf_common";
    class functions {
        file = "framework";
        class sortUnits {};
        class sortGroundVics {};
        class sortAirVics {};
        class sortSupplies {};
    };
};
class ai {
    tag = "lmf_ai";
    class functions {
        file = "framework\ai";
        class initMan {};
        class initVic {};
        class initAir {};
    };
    class eventhandlers {
        file = "framework\ai\eh";
        class killedEH {};
        class suppressEH {};
    };
	class aitasks {
		file = "framework\ai\task";
    	class taskSuppress {};
	};
    class spawning {
        file = "framework\ai\spawning";
        class returnSpawner {};
        class patrol {};
    };
};
class player {
	tag = "lmf_player";
	class functions {
		file = "framework\player";
        class initPlayerGear {};
		class initPlayerAir {};
		class initPlayerVic {};
		class initPlayerSupp {};
	};
};