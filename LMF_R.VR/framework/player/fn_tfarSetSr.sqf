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
        [_swRadio,[6,9,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[6,9,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "ALPHA") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[1,9,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[1,9,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "BRAVO") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[2,9,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[2,9,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "CHARLIE") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[3,9,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[3,9,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "DELTA") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[4,9,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[4,9,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};

if (_id == "ECHO") exitWith {
    if (_persRadioCount < 1) then {
        [_swRadio,[5,9,["31","101","102","103","104","105","106","107","108"],2,"_bluefor",0,1,_uid,false],true] call TFAR_fnc_setSwSettings;
    } else {
        [_swRadio,[5,9,["31","101","102","103","104","105","106","107","108"],0,"_bluefor",-1,0,_uid,false],true] call TFAR_fnc_setSwSettings;
    };
};