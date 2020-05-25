// MISSION RELEVANT SETTINGS //////////////////////////////////////////////////////////////////////
/*
	- In this file you define mission relevant settings. It is important these settings are
	  configured properly.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
//VARIOUS
var_author = "Author"; // Your name, which shows up at the end of the warmup.
var_location = "Virtual Reality"; // Location where scenario takes place, which can be seen in intro.
var_creatorUID = "76561197997590271"; // Player UID that is being added to the list for admin tool access.
var_debug = false; // For mission testing, will turn on some debug options. (default: false)
var_warmup = true; // Start mission with warmup? (default: true)
var_jipTP = true; // Allow players that JIP to teleport? (default: false)
var_enemySide = EAST; // What side is the enemy? (WEST,EAST,INDEPENDENT) (default: EAST)
var_civPanic = false; // Will civs panic when there is a firefight? (default: true)

//RESPAWN
var_respawnType = "OFF"; // What type of Respawn? ("WAVE", "OFF" or number in seconds) (default: "OFF")
var_respawnTime = 1500; // Respawn countdown in seconds in case of "WAVE". (default: 1500)

//JRM RESPAWN
var_useJRM = false; // Use FP internal JRM respawn system instead of custom LMF one? (default: false)
var_livesJRM = 0; // Amount of JRM respawn lives (default: 0)

// PLAYERS ////////////////////////////////////////////////////////////////////////////////////////
var_playerGear = true; // Should players get custom gear? (default: true)
var_camoCoef = 1; // How easy should players be spotted by AI? Higher number = easier spotted (default: 1)

//VIEW DISTANCE (if enabled available in CBA Settings --> LMF Viewdistance Cap)
var_viewEnabled = false; //Should view distance overwrite be enabled

var_onFootMax = 2500; // Max Viewdistance on foot
var_onFootMaxObj = 2500; // Max object Viewdistance on foot

var_airMax = 5000; // Max Viewdistance in air vehicle
var_airMaxObj = 4500; // Max object Viewdistance in air vehicle

//VEHICLES AND CRATES
var_vic1 = "B_Truck_01_covered_F"; // Ground Spawnpad Vehicle
var_vic2 = "B_APC_Wheeled_01_cannon_F"; // Ground Spawnpad Vehicle
var_vic3 = "B_MBT_01_TUSK_F"; // Ground Spawnpad Vehicle
var_vic4 = "B_AFV_Wheeled_01_up_cannon_F"; // Ground Spawnpad Vehicle

var_air1 = "B_Heli_Transport_01_F"; // Air Spawnpad Vehicle
var_air2 = "B_Heli_Light_01_dynamicLoadout_F"; // Air Spawnpad Vehicle
var_air3 = "B_Heli_Attack_01_dynamicLoadout_F"; // Air Spawnpad Vehicle
var_air4 = "B_Plane_Fighter_01_F"; // Air Spawnpad Vehicle

var_supSmall = "Box_NATO_Ammo_F"; // Supply Spawnpad small supplies
var_supLarge = "B_supplyCrate_F"; // Supply Spawnpad large supplies
var_supSpecial = "Box_NATO_WpsSpecial_F"; // Supply Spawnpad special supplies
var_supExplosives = "Box_NATO_AmmoOrd_F"; // Supply Spawnpad explosives supplies

//SUPPLY DROP
var_supplyDropLimit = 0; // How many supply drops should team leaders be able to call in?
var_suppDropPlane = "C_Plane_Civil_01_F"; // What plane should do the supply drop?

//FORWARD DEPLOY (check framework\shared\init\forwardDeploy.sqf for info)
var_forwardDeploy = false; // Should group leaders be able to register for a forward deployment during warmup?
var_deployHeight = 200; // At what height should players forward deploy? 0 = ground (everything higher than 0 but lower than 200 will become 200)

//PLAYER GEAR (Only relevant if var_playerGear = true;)
var_personalArsenal = false; // Give players access to a limited arsenal during briefing stage. (default: false)
var_personalRadio = true; // Does everyone get a short range radio (AN/PRC 343)? (default: true)
var_backpacksAll = false; // Give all players backpacks? (Certain roles will have backpacks regardless) (default: false)
var_pistolAll = false; // Give all players sidearms? (default: false)
var_playerNVG = 2; // Who gets NVGs? (0=ALL, 1=PILOTS, 2=NONE) (default: 2)
var_playerMaps = 0; // Who gets Maps? (0=ALL, 1=LEADERS, 2=NONE) (default: 0)
var_keepRole = true; // Should players keep their role upon respawn? (default: true)
var_helpMessages = true; // Should players receive notification when they're being helped while unconscious? (default: true)


// MARKERS ////////////////////////////////////////////////////////////////////////////////////////
var_markerSide = "ColorWEST"; // What colorsheme should markers on playerside use? ("ColorWEST", "ColorEAST", "ColorGUER") (default: "ColorWEST")
var_groupTracker = true; // Use group-icons on map. (default: true)
var_unitTracker = true; // Use unit-icons on map. (default: false)