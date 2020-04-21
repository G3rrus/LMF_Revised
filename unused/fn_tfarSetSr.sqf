// TFAR SR FRQ PRESET /////////////////////////////////////////////////////////////////////////////
/*
    - Functions that sets the frequencies for SR radios.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit","_radioArray"];

if !(local _unit) exitWith {};
private _id = groupID group _unit;
private _swRadio = _radioArray#0;
private _uid = getPlayerUID player;
private _persRadioCount = ({_x in (toLower (call TFAR_fnc_activeSwRadio))} count ["tfar_pnr1000a","tfar_rf7800str","tfar_anprc154"]);

//APPLY FREQUENCY
if (_id == "PLT HQ") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "ALPHA") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "BRAVO") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "CHARLIE") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "DELTA") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "ECHO") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[1,8,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

/*
//XEH POST INIT
//RADIO CHANNEL LABLES
if !(var_tfar) then {
	[] execVM "framework\shared\init\acreChannelLabels.sqf";
};

//RADIO CHANNEL PRESET
if !(var_tfar) then {
	[] spawn lmf_loadout_fnc_acreChannelPreset;
} else {
	["Set_SwFrq","OnRadiosReceived",{
		_this call lmf_loadout_fnc_tfarSetSr;
	},objNull] call TFAR_fnc_addEventHandler;
};

//KILLED EH
//ACE SPECTATOR INTERFACE
if !(var_useJRM) then {
	[true] call ace_spectator_fnc_setSpectator;
	if (var_tfar) then {[_unit, true] call TFAR_fnc_forceSpectator;};
};

//RESPAWN EH
[] spawn {
    sleep 5;
    setCurrentChannel 3;
    [{player setUnitTrait ["camouflageCoef",var_camoCoef];}, [], 5] call CBA_fnc_waitAndExecute;
    if !(var_tfar) then {[] spawn lmf_loadout_fnc_acreChannelPreset;};
    cutText  ["", "BLACK IN", 5, true];
};

if !(var_useJRM) then {
	[] spawn _doOnRespawn;
} else {
	sleep 2;
	[{!ace_spectator_isSet},_doOnRespawn, []] call CBA_fnc_waitUntilAndExecute;
	if (var_tfar) then {[_unit, false] call TFAR_fnc_forceSpectator;};
};

//INIT PLAYER SUPPLY
_supp addItemCargoGlobal ["TFAR_anprc152", 10];
_supp addItemCargoGlobal ["TFAR_rf7800str", 20];
_supp addItemCargoGlobal ["TFAR_microdagr",20];

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

// TFAR - Global settings
force TFAR_giveLongRangeRadioToGroupLeaders = false; // Already given by Loadout
force TFAR_giveMicroDagrToSoldier = false; // Already given by Loadout
force TFAR_givePersonalRadioToRegularSoldier = false; // Already given by Loadout
force tfar_radioCodesDisabled = true; // Not a TvT Framework, hence same Encryption
force TFAR_SameLRFrequenciesForSide = true; // Important for accurate radio preset and Signals Briefing
force TFAR_SameSRFrequenciesForSide = true; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_lr_east = "31,32,33,34,35,36,37,38,39"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_lr_independent = "31,32,33,34,35,36,37,38,39"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_lr_west = "31,32,33,34,35,36,37,38,39"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_sr_east = "31,101,102,103,104,105,106,107,108"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_sr_independent = "31,101,102,103,104,105,106,107,108"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_sr_west = "31,101,102,103,104,105,106,107,108"; // Important for accurate radio preset and Signals Briefing

//LOADOUT RADIO SETUP EXAMPLE
//RADIO SETUP
if !(var_tfar) then {
	_unit linkItem "ItemWatch";
	_unit linkItem "ItemRadioAcreFlagged";
	_unit addItem _Radio_L;
	_unit addItem _Radio_B;
	if (var_personalRadio) then {
		_unit addItem _Radio_R;
	};
} else {
	_unit linkItem "ItemWatch";
	_unit linkItem _Radio_L;
};