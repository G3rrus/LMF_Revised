class framework {
    tag = "lmf";
	class general {
		class sortUnits {file="framework\fn_sortUnits.sqf";};
		class sortGroundVics {file="framework\fn_sortGroundVics.sqf";};
		class sortAirVics {file="framework\fn_sortAirVics.sqf";};
		class sortSupplies {file="framework\fn_sortSupplies.sqf";};
    };
	class aiSettings {
		file = "framework\ai";
		class execAI {};
		class execVic {};
		class execAir {};
	};
    class aiEventHandlers {
        file = "framework\ai\eh";
    	class killedAI {};
		class suppressAI {};
    };
	class playerEquipment {
		file = "framework\player";
		class execPlayerAir {};
		class execPlayerVic {};
		class execPlayerSupp {};
	};
};
class alex2k {
    tag = "a2k";
	class aiTasks {
		file = "framework\ai\task";
    	class taskSuppress {};
	};
};