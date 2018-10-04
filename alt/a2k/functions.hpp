class alex2k
    {
       tag = "a2k";
       class gear
       {
       class playerGear {file="a2k\gear\exec_playerGear.sqf";};
       class aiGear {file="a2k\gear\exec_aiGear.sqf";};             
       };

       class aiSpawn
       {
       file = "a2k\ai";
       class infantryGarrison {};
       class infantryQRF {};
       class infantryQRF_re {};
       class infantryHunter {};
       class infantryHunter_re {};
       class infantryPatrol {};
       class vehicleQRF_re {};
       };

       class aiTask 
       {
       file = "a2k\ai\task";
       class taskAssault {};
       class taskCrew {};
	   class taskHunt {};
	   class taskUpdateWP {};
       };

       class admin
       {
       file = "a2k\admin";
       class endWarmup {};
       class performance {};
       class performance_check {};
       class respawnWave {};
       class ZEUS {};
       class ZEUS_spawn {};
       };
    };