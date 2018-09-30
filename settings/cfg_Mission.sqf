///////////////////////////////////////////////////////////////////////////////////////////////////
// MISSION SETTINGS ///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/*


DESCRIPTION

In this File all Mission related settings are defined.


*/
// MISSION ////////////////////////////////////////////////////////////////////////////////////////
//VARIOUS
var_author = "Author"; // Your name, which shows up at the end of the warmup.
var_debug = false; // For mission testing, will start without warmup and turn on debug options. (default: false)
var_jipTP = false; // Allow players that JIP to teleport? (default: false)

//RESPAWN
var_respawnType = "OFF"; // What type of Respawn? ("WAVE", "OFF" or number in seconds) (default: "OFF")
var_respawnTime = 1500; // Respawn countdown in seconds in case of "WAVE". (default: 1500)
var_keepRole = true; // Should players keep their role upon respawn? (default: true)

// PLAYERS ////////////////////////////////////////////////////////////////////////////////////////
var_playerGear = true; // Should players get custom gear? (default: true)
var_camoCoef = 1; // How easy should players be spotted by AI? Higher number = easier spotted (default: 1)
var_personalArsenal = false; // Give players access to a limited arsenal during briefing stage. (default: false)

// PLAYER GEAR (Only relevant if var_playerGear = true;)
var_personalRadio = true; // Does everyone get a short range radio (AN/PRC 343)? (default: true)
var_backpacksAll = false; // Give all players backpacks? (Certain roles will have backpacks regardless) (default: false)
var_playerNVG = 2; // Who gets NVGs? (0=ALL, 1=PILOTS, 2=NONE) (default: 2)
var_playerMaps = 0; // Who gets Maps? (0=ALL, 1=LEADERS, 2=NONE) (default: 0)

// AI /////////////////////////////////////////////////////////////////////////////////////////////
var_enemySide = EAST; // What side is the enemy? (WEST,EAST,INDEPENDENT) (default: EAST)
var_enemySkill = 1; // What skill does the enemy have? (0=UNTRAINED, 1=REGULAR, 2=ELITE) (default: 1)
var_enemyGear = true; // Should AI get custom gear? (default: true)
var_enemyNVG = false; // Should AI get NVGs? (default: false)

// MARKERS ////////////////////////////////////////////////////////////////////////////////////////
var_markerSide = "ColorWEST"; // What colorsheme should markers on playerside use? ("ColorWEST", "ColorEAST", "ColorGUER") (default: "ColorWEST")
var_groupMarkers = true; // Use group-icons on map. (default: true)
var_unitTracker = false; // Use unit-icons on map. (default: false)