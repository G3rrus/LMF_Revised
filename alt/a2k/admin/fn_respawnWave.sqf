// ADMIN command : Respawn Wave 
// version 1.0
// by nkenny

#include "cfg_admin.sqf"

// Run on clients
[] spawn
  {
  [5] remoteExec ["setPlayerRespawnTime",playerSide];
  sleep 6; 
  [var_respawnTime] remoteExec ["setPlayerRespawnTime",playerSide];

  // admin
  //systemChat format ["ADMIN: Respawn Wave (Default time %1 min)",round var_respawnTime/60]; 

  }; 

// end
true
