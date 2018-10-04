///////////////////////////////////////////////////////////////////////////////////////////////////
// MISSION FRAMEWORK ////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
// MISSION SETTINGS ///////////////////////////////////////////////////////////////////////////////

//VARIOUS
var_author = "Drgn V4karian"; // Your name, shows up in intro.
var_debug = false; // For testing mission without intro + turn on some debug options.

//RESPAWN
var_respawnType = "WAVE"; // "WAVE", "OFF" or number in seconds.
var_respawnTime = 1500; // Respawn countdown in seconds in case of "WAVE"

//BRIEFING STAGE
var_personalArsenal = false; // Give players access to a limited arsenal with some gear variations during briefing stage?

//MARKERS
var_groupMarkers = true; // true = use group-icons on map.
var_unitTracker = false; // true = track units via markers on map.

//DEPLOY
a2k_deploy = false; // true = Group leaders can deploy their group on ground, or freefalling(with a parachute) at mission start.
a2k_parachuteHeight = 300; // any value > 0 will deploy players at that altitude(in meters) with a parachute.
a2k_autoDeploy = true; // true = Automatically deploys parachute immediately after jumping.


///////////////////////////////////////////////////////////////////////////////////////////////////
// DON'T EDIT BELOW! //////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
var_versionLMF = "uv1.98b";
var_randomColor = selectRandom ["#F09595","#F095E4","#BC95F0","#95C7F0","#95EEF0","#95F0CA","#A9F095","#D6F095","#F0F095","#F0C495"];
var_name = briefingName; // Name of the mission. (3DEN > Attributes > General > Title)

#include "a2k\cfg_base.sqf";
#include "a2k\gear\inv\config_inv.sqf";

[] execVM "initMission.sqf";
[] execVM "a2k\scripts\customChannels.sqf";


// HEADLESS CLIENT ////////////////////////////////////////////////////////////////////////////////
var_isSpawner = false;
var_headless = if (count entities "HeadlessClient_F" > 0) then {true} else {false};
  if (var_headless AND isMultiplayer) then
    {
      if (!isServer AND !hasInterface) then
        {
          var_isSpawner = true;
        };
    } else
    {
      if (isServer) then
        {
          var_isSpawner = true;
        };
    };


[] execVM "a2k\init_warmup.sqf";
[] execVM "a2k\briefing\init_brf.sqf";
[] execVM "a2k\init_intro.sqf";
[] execVM "a2k\init_removeDead.sqf";


f_var_debugMode = 0;
f_param_debugMode = 0;