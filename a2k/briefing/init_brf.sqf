// BRIEFING 
// version 2.0
// by nkenny

/*
version 2.0
- Rewrite of certain functions
- Added automated platoon tally
- moved testers to own file (for easier updating)
- Added ADMIN tab

version 1.7
- RANGER framework

version 1.6
- Project Lizard Framework

version 1.41
- Project Honor codework
- Task Force MIKE

version 1.4
- Moved into two files : init_brf.sqf and txt_brf.sqf   Update mission specific text in txt_brf.sqf :) 
- Updated testers list

version 1.31 
- Addded _brf_mission
- Some minor textual tweaks

version 1.3
- Extensive text and organizational tweaks

version 1.21
- Misc text tweaks

version 1.2
- Heavily colourized 
- Slightly changed things around. 

version 1.01
- Created

version 1.01
- Updated description

*/

waitUntil { !isNull player };
waitUntil { player == player };
#include "txt_brf.sqf";
#include "tst_brf.sqf";

// FUNCTION ------------------------------------------------
_nk_collect = {
_l = _this;
_nl = "";
  {
  _nl = _nl + " - " + _x + "<br/>";
  } foreach _l;
  _nl
};

// ---------------- AUTOMATION BELOW HERE -------------------------------------------
// As per 13.02.2018
// nkenny

// ADMIN ----------------------------------------------------------------------------

[] spawn 
{
  sleep 5;
  player createDiarySubject ["Admin","Admin Tools"];
  player creatediaryrecord ["Admin",["Admin", format ["
  <font face='PuristaBold' color='#ffba26' size='16'>ADMIN FRAMEWORK</font><br/>
  <font color='#9DA698'>The admin framework is available to select players only.</font color><br/><br/>

  <font color='#d7dbd5'>BRIEFING STAGE</font><br/>
  - <execute expression='[] call a2k_fnc_EndWarmup'>PRESS HERE TO END BRIEFING STAGE</execute><br/><br/>

  <font color='#d7dbd5'>RESPAWN</font><br/>
  - <execute expression='[] call a2k_fnc_RespawnWave'>PRESS HERE TO CREATE RESPAWN WAVE</execute><br/><br/>

  <font color='#d7dbd5'>ADD ZEUS</font><br/>
  - <execute expression='[] call a2k_fnc_ZEUS'>PRESS HERE TO ADD ZEUS</execute><br/><br/>

  <font color='#d7dbd5'>CHECK SERVER/HEADLESS CLIENT PERFORMANCE</font><br/>
  - <execute expression='[] call a2k_fnc_performance'>PRESS HERE TO CHECK PERFORMANCE</execute>

  ",var_debug]]];
}; 

// PLATOON TAB -----------------------------------------------------------------------
// Function 
  // init
  _grp = ""; 
  _grp2 = grpNull; 

  // platoon Description
  _brf_platoon = ""; 


  {
    // get info 
    _grp = group _x; 
    _id = groupID group _x;
	_role = roleDescription _x;
    
    // new group? 
    if (_grp != _grp2) then 
      {
       _brf_platoon = _brf_platoon + "<br/> <font face='PuristaBold' color='#ffba26'>" + _id + "<br/></font>";    
      };  
    
    // make entry
    _rank = if (rank _x != "PRIVATE") then {[rank _x] call CBA_fnc_capitalize} else {""};
	if (_role find "Platoon Leader" >= 0) then {_role = "Platoon Leader"};
	if (_role find "Squad Leader" >= 0) then {_role = "Squad Leader"};
	if (_role find "Vehicle Commander" >= 0) then {_role = "Vehicle Commander"};
	if (_role find "Helicopter Pilot" >= 0) then {_role = "Helicopter Pilot"};
	if (_role find "Fighter Pilot" >= 0) then {_role = "Fighter Pilot"};
  if (_role find "Gamemaster" >= 0) then {_role = "Zeus"};
    _brf_platoon = _brf_platoon + "  <font color='#9DA698'>- " + _role + ": " +  name _x + "</font color><br/>";
    
    // update old 
    _grp2 = _grp; 
    

} foreach (playableUnits + switchableUnits); 


player creatediaryrecord ["Diary",["  TO/E",format ["
<font face='PuristaBold' color='#d7dbd5'>Overview<br/></font>
<font color='#9DA698'>
 - This page is only accurate at mission start.<br/>
 - Unit strength is <font color='#ffba26'>%3<font color='#9DA698'> pax.<br/>
</font color>

%4<br/>
",roleDescription player,groupID group player,count (switchableUnits + playableUnits - entities 'HeadlessClient_F'),_brf_platoon]]];

// SIGNALS --------------------------------------------------------------------------
player createDiaryrecord ["Diary",["  Signals",format ["
<font face='PuristaBold' color='#ffba26'>LONG RANGE NETS</font color><br/>
 <font color='#d7dbd5'>1PLT:  </font> <font color='#9DA698'>Channel 01</font color><br/>
 <font color='#d7dbd5'>2PLT:  </font> <font color='#9DA698'>Channel 02</font color><br/>
 <font color='#d7dbd5'>3PLT:  </font> <font color='#9DA698'>Channel 03</font color><br/>
 <font color='#d7dbd5'>AIR:    </font> <font color='#9DA698'>Channel 06</font color><br/>
 <font color='#d7dbd5'>CAS:   </font> <font color='#9DA698'>Channel 07</font color><br/>

<br/>

<font face='PuristaBold' color='#ffba26'>1ST PLATOON NETS</font color><br/>
 <font color='#d7dbd5'>Platoon HQ:   </font color> <font color='#9DA698'>Channel 06</font color><br/>
 <font color='#d7dbd5'>1st Squad:     </font color> <font color='#9DA698'>Channel 01</font color><br/>
 <font color='#d7dbd5'>2nd Squad:     </font color> <font color='#9DA698'>Channel 02</font color><br/>
 <font color='#d7dbd5'>3rd Squad:     </font color> <font color='#9DA698'>Channel 03</font color><br/>
 <font color='#d7dbd5'>4th Squad:     </font color> <font color='#9DA698'>Channel 04</font color><br/>

",groupID (group player)]]];


// Temporarily comment shit out here 
/*
<font color='#d7dbd5'>2PLT:  </font> <font color='#9DA698'>Channel 02</font color><br/>
<font color='#d7dbd5'>3PLT:  </font> <font color='#9DA698'>Channel 03</font color><br/>
<font color='#d7dbd5'>CAS:    </font> <font color='#9DA698'>Channel 07</font color><br/>

 <font color='#d7dbd5'>Platoon HQ:   </font color> <font color='#9DA698'>Channel 06</font color><br/>
 <font color='#d7dbd5'>3rd Squad:     </font color> <font color='#9DA698'>Channel 03</font color><br/>
 <font color='#d7dbd5'>4th Squad:     </font color> <font color='#9DA698'>Channel 04</font color><br/>
*/
// WHERE IT HAPPENS ---------------------------------------------------------------
player creatediaryrecord ["Diary",[format ["OPORD"],format ["
<font face='PuristaBold' color='#ffba26' size='16'>SITUATION</font><br/>
%2<br/><br/>
<font face='PuristaBold' color='#d7dbd5'>Enemy Forces</font><br/>
%3
  <br/><font face='PuristaBold' color='#d7dbd5'>Friendly Forces</font><br/>
%4
  <br/><font face='PuristaBold' color='#d7dbd5'>Other Considerations</font><br/>
%5
<br/><font face='PuristaBold' size='16' color='#ffba26'>MISSION:</font><br/>
%6
<br/><br/><font face='PuristaBold' size='16' color='#ffba26'>EXECUTION:</font><br/>
%7
<br/><font face='PuristaBold' size='16' color='#ffba26'>ADMINISTRATION:</font><br/>
%8

",var_name,_brf_situation,_brf_enemy call _nk_collect,_brf_friend call _nk_collect,_brf_remarks call _nk_collect,_brf_mission,_brf_execution call _nk_collect,_brf_administration call _nk_collect]]];


// end
true 