// Warmup system
// version 1.0
// by nkenny (Messed up by Alex2k)
// USED TO BE EXECUTED IN INIT FOR EVERYONE.

if (!didJip) then {var_warmup = true;};
if (isServer) then {publicVariable "var_warmup";};

//REMAINING CODE FROM INTRO FILE

if (hasInterface) then {
	[] Spawn {
		player enableSimulation false;

		private _date = str (date select 1) + "/" + str (date select 2) + "/" + str (date select 0) + " " + str (date select 3) + ":" + str (date select 4);
		private _location = "Location: " + worldname;

		cutText  ["", "BLACK FADED", 10, true];
		sleep 3;
		cutText  [format ["<t color='#FFBA26' size='5'>%1</t>",briefingName], "BLACK FADED", 10, true,true];
		sleep 3;
		cutText  [format ["<t color='#FFBA26' size='5'>%1</t><br/><t color='#D7DBD5' size='3'>%2</t>",briefingName,_date], "BLACK FADED", 10, true,true];
		sleep 3;
		cutText  [format ["<t color='#FFBA26' size='5'>%1</t><br/><t color='#D7DBD5' size='3'>%2</t><br/><t color='#D7DBD5' size='2'>%3</t>",briefingName,_date,_location], "BLACK FADED", 10, true,true];
		sleep 3;
		cutText  [format ["<t color='#FFBA26' size='5'>%1</t><br/><t color='#D7DBD5' size='3'>%2</t><br/><t color='#D7DBD5' size='2'>%3</t>",briefingName,_date,_location], "BLACK IN", 10, true,true];

		player enableSimulation true;
	};
};




// No warmup phase
if (!var_warmup || var_debug) exitWith {};

// Save date
_date = date;

// Display information + Add eventhandler
if (hasInterface) then
{
  waitUntil {time > 12};
  waitUntil {simulationEnabled player};

  // Disable weapons, disallow damage to player
  a2k_noGuns = player addEventHandler ["Fired", {deleteVehicle (_this select 6);}];
  player allowDamage false;

  // Info loop
  while {var_warmup} do
    {
    _title = "<t font='PuristaBold' color='#ffba26' size='1.3' align='Center'>Mission Briefing Stage</t><br/>";
    _txt = format ["<t align='Center'>Safe start enabled  (%1)",[time, "MM:SS"] call BIS_fnc_secondsToString];
    //_txt2 = format ["<br/>%1%2%3",if (var_debug) then {"DEBUG MODE ACTIVE<br/>"} else {""},"WAITING FOR ADMIN"];
	_br = format ["<br/>"];

	_grpMrk = "";
	if (var_groupMarkers) then {_grpMrk = "On";};
	if (!var_groupMarkers) then {_grpMrk = "Off";};
	_groupMarkers = format ["<t color='#ffba26' size='1.0'align='left'>GROUP MARKERS:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_grpMrk];

	_resp = "";
	if (typename var_respawnType == "STRING") then {
		if (var_respawnType == "WAVE") then {_resp = "Wave";};
		if (var_respawnType == "OFF") then {_resp = "Off";};
	};
	if (typename var_respawnType == "SCALAR") then {_resp = var_respawnType};
	_respawn = format ["<t color='#ffba26' size='1.0'align='left'>RESPAWN:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_resp];

	_radio = "";
	if (a2k_personalRadio == "ALL") then {_radio = "All";};
	if (a2k_personalRadio == "NONE") then {_radio = "None";};
	_radios = format ["<t color='#ffba26' size='1.0'align='left'>AN/PRC-343:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_radio];

	_NVG = "";
	if (a2k_NVG == "ALL") then {_NVG = "All";};
	if (a2k_NVG == "PILOTS") then {_NVG = "Pilots";};
	if (a2k_NVG == "NONE") then {_NVG = "None";};
	_NVGs = format ["<t color='#ffba26' size='1.0'align='left'>NVG:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_NVG];

	_map = "";
	if (a2k_maps == "ALL") then {_map = "All";};
	if (a2k_maps == "LEADERS") then {_map = "Leaders";};
	if (a2k_maps == "NONE") then {_map = "None";};
	_maps = format ["<t color='#ffba26' size='1.0'align='left'>MAPS:  </t> <t color='#9DA698' size='1.0'align='right'>%1</t><br/>",_map];

    // Display
    hintSilent parseText (_title + _txt + _br + _br + _respawn + _radios + _maps + _NVGs + _groupMarkers);
    sleep 1;
    };

};


// Wait for end of briefing-stage
waitUntil {!var_warmup};
setDate _date;

// Mission start!
if (hasInterface) then
    {
      // Clear hint
      hintSilent "";

      // Countdown
      for "_i" from 1 to 10 do
        {
          systemChat format ["Mission live in %1s",10-_i];
          sleep 1;
        };

      // Enable weapons, allow damage to player
	  player removeEventHandler ["Fired", a2k_noGuns];
      player allowDamage true;

	  // Mission intro
		[
			[
				[format ["%1", var_name],"align = 'center' shadow = '1' size = '1.3' font='PuristaBold'"],
				["","<br/>"],
				//[format ["• "],"align = 'center' shadow = '1' size = '0.65' font='PuristaMedium'","#D6D6D6"],
				[format ["by: "],"align = 'center' shadow = '1' size = '0.55' font='PuristaBold'","#D6D6D6"],
				[format ["%1", var_author],"align = 'center' shadow = '1' size = '0.55' font='PuristaBold'",var_randomColor],
				//[format [" •"],"align = 'center' shadow = '1' size = '0.65' font='PuristaMedium'","#D6D6D6"],
				["","<br/>"]
			],safeZoneX+0.0,safeZoneY+0.8
		] spawn BIS_fnc_typeText2;
      sleep 5;
    };

// Broadcast variable
if (isServer) then {publicVariable "var_warmup";};

// End
true