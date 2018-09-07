// ADMIN List
// version 1.0
// by nkenny

waitUntil {time > 5};
var_admin = false;
_uid = getPlayerUID player; 

// logged admin
if (admin owner player > 0) then {var_admin = true};

// list
_admin_list = 
              [
              "76561197962792796", // nkenny
              "76561197972953971", // MoonDawg
              "76561197972498138", // Liquid Tracer
              "76561197968829665", // Alex2k
              "76561198202783595", // Aizen
              "76561197997590271", // G4rrus
			  ""
              ];

if (_uid in _admin_list) then {var_admin = true}; 

// singleplayer
if (!isMultiplayer) then {var_admin = true}; 

// end
if (!var_admin) exitWith {systemChat "ADMIN: Only for certified members"};