// ADMIN command : Check Server and Headless performance 
// by nkenny

if (hasinterface && !isserver) exitWith {}; 

// init
_p = param [0];

// Get FPS 
for "_i" from 1 to 10 do 
  {
  _txt = format ["ADMIN: %1 has %2 FPS (%3/10)",if (var_isSpawner && !isserver) then {"Headless client"} else {"Server"},round diag_fps,_i];
  [_txt] remoteExec ["Systemchat",_p,false];
  sleep 5; 
  }; 

// end
true
