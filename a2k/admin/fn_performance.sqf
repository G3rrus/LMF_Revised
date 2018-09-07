// ADMIN command : Check Server and Headless performance 
// by nkenny

#include "cfg_admin.sqf"

// init
_p = player; 

// code
[_p,"a2k\admin\fn_performance_check.sqf"] remoteExec ["Bis_fnc_execVM",0,false];

// feedback
systemchat "ADMIN : Checking FPS";

// end
true
