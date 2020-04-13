// PLAYER BRIEFING ////////////////////////////////////////////////////////////////////////////////
/*
	- Minimally rewritten by Drgn V4karian, most code originally by nkenny.
	- File that handles player briefing. Collects data from cfg_Briefing.sqf.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\settings\cfg_Briefing.sqf"

//FUNCTION TO COLLECT AND FORMAT STRING FROM CFG_BRIEFING CORRECLTY
private _collect = {
	_lines = _this;
	private _newline = "";
	{
		_newline = _newline + " <font color='#D7DBD5'>- " + _x + "</font><br/>";
	} foreach _lines;
	_newline
};

//FUNCTION TO GET CBA SETTING TEXT RETURNED PROPERLY
private _getLocalizedString = {
	params ["_setting"];

	_setting = toUpper (localize (((cba_settings_default getVariable _setting select 3) select 1) select (missionNamespace getVariable _setting)));

	_setting
};

// ADMIN TOOLS (only added after map screen) //////////////////////////////////////////////////////
[] spawn {
	sleep 5;
	player createDiarySubject ["Admin","LMF"];

	player creatediaryrecord ["Admin",["Info", format ["
	<font face='PuristaBold' color='#FFBA26' size='16'>LAMBS MISSION FRAMEWORK</font><br/>
	<font color='#D7DBD5'>Version: %1</font color><br/>
	", var_version]]];

	player creatediaryrecord ["Admin",["Admin", format ["
	<font face='PuristaBold' color='#FFBA26' size='16'>ADMIN TOOLS</font><br/>
	<font color='#D7DBD5'>This will only work if you are an admin or whitelisted as one.</font color><br/><br/>

	<font color='#A34747'>END BRIEFING STAGE</font><br/>
	- <execute expression='[player] remoteExec [""lmf_admin_fnc_endWarmup"",2]'>PRESS HERE TO END BRIEFING STAGE</execute><br/><br/>

	<font color='#A3FFA3'>RESPAWN</font><br/>
	- <execute expression='[player] remoteExec [""lmf_admin_fnc_respawnWave"",2]'>PRESS HERE TO CREATE RESPAWN WAVE</execute><br/><br/>

	<font color='#A3FFA3'>TELEPORT PLAYERS</font><br/>
	- <execute expression='[player] remoteExec [""lmf_admin_fnc_initAdminTP"",2]'>PRESS HERE TELEPORT PLAYERS TO YOU</execute><br/><br/>

	<font color='#A3FFA3'>ADD ZEUS</font><br/>
	- <execute expression='[player] remoteExec [""lmf_admin_fnc_assignZeus"",2]'>PRESS HERE TO ADD ZEUS</execute><br/><br/>

	<font color='#A3FFA3'>CHECK SERVER/HEADLESS CLIENT PERFORMANCE</font><br/>
	- <execute expression='[player] remoteExec [""lmf_admin_fnc_initPerformance"",2]'>PRESS HERE TO CHECK PERFORMANCE</execute><br/><br/>

	<font color='#A3E0FF'>ENTER SAFEMODE</font><br/>
	- <execute expression='[player,true] remoteExec [""lmf_admin_fnc_initPlayerSafety"",2]'>PRESS HERE TO ENTER SAFEMODE</execute><br/><br/>

	<font color='#A34747'>EXIT SAFEMODE</font><br/>
	- <execute expression='[player,false] remoteExec [""lmf_admin_fnc_initPlayerSafety"",2]'>PRESS HERE TO EXIT SAFEMODE</execute><br/><br/>

	<font color='#A3E0FF'>END MISSION COMPLETED</font><br/>
	- <execute expression='[player,true] remoteExec [""lmf_admin_fnc_endMission"",2]'>PRESS HERE TO END MISSION</execute><br/><br/>

	<font color='#A34747'>END MISSION FAILED</font><br/>
	- <execute expression='[player,false] remoteExec [""lmf_admin_fnc_endMission"",2]'>PRESS HERE TO END MISSION</execute>
	"]]];
};


// TESTERS ////////////////////////////////////////////////////////////////////////////////////////
if (_testers != "") then {
player createDiaryrecord ["Diary",["  Credits",format ["
<font color='#D7DBD5'>%1</font color>
",_testers]]];
};

// CBA MEDICAL ////////////////////////////////////////////////////////////////////////////////////
private _fatalPlayer = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["ace_medical_statemachine_fatalInjuriesPlayer"] call _getLocalizedString];
private _fatalAi = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["ace_medical_statemachine_fatalInjuriesAI"] call _getLocalizedString];
private _unconAi = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["DISABLED","ENABLED"] select ace_medical_statemachine_AIUnconsciousness];


private _advBand = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["ace_medical_treatment_advancedBandages"] call _getLocalizedString];
private _advMedi = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["DISABLED","ENABLED"] select ace_medical_treatment_advancedMedication];

private _bleedCoeff = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",ace_medical_bleedingCoefficient];
private _sponWake = format ["<font face='PuristaBold' color='#A3E0FF'>%1%2</font><br/>",(ace_medical_spontaneousWakeUpChance*100),"%"];
private _cprSuccess = format ["<font face='PuristaBold' color='#A3E0FF'>%1%2</font><br/>",(ace_medical_treatment_cprSuccessChance*100),"%"];
private _cardiTime = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",[ace_medical_statemachine_cardiacArrestTime] call BIS_fnc_secondsToString];

private _whoEpi = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["ace_medical_treatment_medicEpinephrine"] call _getLocalizedString];
private _whoIv = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["ace_medical_treatment_medicIV"] call _getLocalizedString];
private _whoPak = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["ace_medical_treatment_medicPAK"] call _getLocalizedString];
private _conPak = format ["<font face='PuristaBold' color='#A3E0FF'>%1</font><br/>",["DISABLED","ENABLED"] select ace_medical_treatment_consumePAK];

player creatediaryrecord ["Diary",["  Medical",format ["
<font face='PuristaBold' color='#FFBA26' size='16'>Medical Settings</font><br/><br/>
<font color='#D7DBD5'>- Fatal Injury Player: </font>%1
<font color='#D7DBD5'>- Fatal Injury AI: </font>%2
<font color='#D7DBD5'>- AI Unconsciousness: </font>%3
<br/>
<font color='#D7DBD5'>- Advanced Bandages: </font>%4
<font color='#D7DBD5'>- Advanced Medication: </font>%5
<br/>
<font color='#D7DBD5'>- Bleeding Coefficient: </font>%6
<font color='#D7DBD5'>- Wake Up Chance: </font>%7
<font color='#D7DBD5'>- CPR Success Chance: </font>%8
<font color='#D7DBD5'>- Cardiac Arrest Time: </font>%9
<br/>
<font color='#D7DBD5'>- Epinephrine: </font>%10
<font color='#D7DBD5'>- IV Transfusion: </font>%11
<font color='#D7DBD5'>- PAK: </font>%12
<font color='#D7DBD5'>- Consume PAK: </font>%13
",_fatalPlayer,_fatalAi,_unconAi,_advBand,_advMedi,_bleedCoeff,_sponWake,_cprSuccess,_cardiTime,_whoEpi,_whoIv,_whoPak,_conPak]]];


// LOADOUT ////////////////////////////////////////////////////////////////////////////////////////
[] call lmf_player_fnc_loadoutBriefing;


// TO/E ///////////////////////////////////////////////////////////////////////////////////////////
lmf_toeBriefing = player creatediaryrecord ["Diary",["  TO/E",[] call lmf_player_fnc_toeBriefing]];


// SIGNALS ////////////////////////////////////////////////////////////////////////////////////////
if !(var_tfar) then {
	player createDiaryrecord ["Diary",["  Signals",format ["
	<font face='PuristaBold' color='#FFBA26' size='16'>LONG RANGE NETS</font><br/>
	<font color='#db4343'>Channel 01:		</font> <font color='#D7DBD5'>1PLT</font color><br/>
	<font color='#A3FFA3'>Channel 06:		</font> <font color='#D7DBD5'>AIR</font color><br/>
	<br/>

	<font face='PuristaBold' color='#FFBA26' size='16'>1ST PLATOON NET</font><br/>
	<font color='#A3E0FF'>Channel 06:		</font color> <font color='#D7DBD5'>Platoon HQ</font color><br/>
	<font color='#A3E0FF'>Channel 01:		</font color> <font color='#D7DBD5'>1st Squad</font color><br/>
	<font color='#A3E0FF'>Channel 02:		</font color> <font color='#D7DBD5'>2nd Squad</font color><br/>
	<font color='#A3E0FF'>Channel 03:		</font color> <font color='#D7DBD5'>3rd Squad</font color><br/>
	<font color='#A3E0FF'>Channel 04:		</font color> <font color='#D7DBD5'>4th Squad</font color><br/>
	<font color='#A3E0FF'>Channel 05:		</font color> <font color='#D7DBD5'>5th Squad</font color><br/>
	"]]];
} else {
	player createDiaryrecord ["Diary",["  Signals",format ["
	<font face='PuristaBold' color='#FFBA26' size='16'>LONG RANGE NETS</font><br/>
	<font color='#db4343'>FRQ.31:		</font> <font color='#D7DBD5'>1PLT</font color><br/>
	<font color='#A3FFA3'>FRQ.32:		</font> <font color='#D7DBD5'>AIR</font color><br/>
	<br/>

	<font face='PuristaBold' color='#FFBA26' size='16'>1ST PLATOON NET</font><br/>
	<font color='#A3E0FF'>FRQ.106:		</font color> <font color='#D7DBD5'>Platoon HQ</font color><br/>
	<font color='#A3E0FF'>FRQ.101:		</font color> <font color='#D7DBD5'>1st Squad</font color><br/>
	<font color='#A3E0FF'>FRQ.102:		</font color> <font color='#D7DBD5'>2nd Squad</font color><br/>
	<font color='#A3E0FF'>FRQ.103:		</font color> <font color='#D7DBD5'>3rd Squad</font color><br/>
	<font color='#A3E0FF'>FRQ.104:		</font color> <font color='#D7DBD5'>4th Squad</font color><br/>
	<font color='#A3E0FF'>FRQ.105:		</font color> <font color='#D7DBD5'>5th Squad</font color><br/>
	"]]];
};


// BRIEFING ///////////////////////////////////////////////////////////////////////////////////////
player creatediaryrecord ["Diary",[format ["OPORD"],format ["
<font face='PuristaBold' color='#FFBA26' size='16'>SITUATION</font><br/>
<font color='#D7DBD5'>%1</font color>
<br/><br/><font face='PuristaBold' color='#A34747'>Enemy Forces</font><br/>
%2
<br/><font face='PuristaBold' color='#A3E0FF'>Friendly Forces</font><br/>
%3
<br/><font face='PuristaBold' color='#A3FFA3'>Other Considerations</font><br/>
%4
<br/><font face='PuristaBold' size='16' color='#FFBA26'>MISSION:</font><br/>
<font color='#D7DBD5'>%5</font color>
<br/><br/><font face='PuristaBold' size='16' color='#FFBA26'>EXECUTION:</font><br/>
%6
<br/><font face='PuristaBold' size='16' color='#FFBA26'>ADMINISTRATION:</font><br/>
%7
",_brf_situation,_brf_enemy call _collect,_brf_friend call _collect,_brf_remarks call _collect,_brf_mission,_brf_execution call _collect,_brf_administration call _collect]]];