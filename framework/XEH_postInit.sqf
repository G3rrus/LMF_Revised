// THIS FILE HANDLES WHAT NEEDS TO HAPPEN POST INIT ///////////////////////////////////////////////

//CHANCE FOR AI TO WAKE UP
["ace_unconscious", {
    params [["_unit", objNull],["_state", false]];
    if (ace_medical_enableUnconsciousnessAI == 0 || {!_state || {!(local _unit) || {isPlayer _unit}}}) exitWith {};

    [_unit] spawn {
        params [["_unit", objNull]];
        while {alive _unit && {_unit getVariable ["ACE_isUnconscious", false]}} do {
            sleep 5;
            if (12.5 > random 100) then {
                [_unit, false] call ace_medical_fnc_setUnconscious;
            };
            sleep 15;
        };
    };
}] call CBA_fnc_addEventHandler;

///////////////////////////////////////////////////////////////////////////////////////////////////
// PLAYER /////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

// MAKE SURE ITS REALLY A PLAYER
if !(hasinterface) exitWith {};
waitUntil {!isNull player};
/*
// ACRE CHANNELS //////////////////////////////////////////////////////////////////////////////////
[] execVM "a2k\scripts\acreChannels.sqf";

// PLAYER GEAR ////////////////////////////////////////////////////////////////////////////////////

*/
// GROUP MARKERS //////////////////////////////////////////////////////////////////////////////////
if (var_groupMarkers) then {[] execVM "framework\player\init\groupMarkers.sqf";};

// UNIT TRACKER ///////////////////////////////////////////////////////////////////////////////////
if (var_unitTracker) then {[] execVM "framework\player\init\unitTracker.sqf";};
/*
// TEAM COLORS ////////////////////////////////////////////////////////////////////////////////////
[] execVM "a2k\scripts\teamColors.sqf";

// JIP ////////////////////////////////////////////////////////////////////////////////////////////
[] execVM "a2k\scripts\jipTeleport.sqf";

// ARSENAL ////////////////////////////////////////////////////////////////////////////////////////
[] execVM "a2k\gear\arsenal.sqf";

// VISUAL FEEDBACK ////////////////////////////////////////////////////////////////////////////////
a2k_hitBlur = {
    if (alive player) then {

        _blur = ppEffectCreate ["dynamicBlur", 401];
        _blur ppEffectEnable true;
        _blur ppEffectAdjust [7];
        _blur ppEffectCommit 0;
        _blur ppEffectAdjust [0.0];
        _blur ppEffectCommit 1.25;

        if (50 > random 100) then {

        _blink = ppEffectCreate ["colorCorrections", 1501];
        _blink ppEffectEnable true;
        _blink ppEffectAdjust [1,1,0,[0,0,0,1],[1,1,1,1],[0.33,0.33,0.33,0],[0.25,0.25,0,0,0,0,4]];
        _blink ppEffectCommit 0;

            _h1 = 0.24;
            _h2 = 0.24;
            for "_i" from 0 to 75 step 1 do {
                _h1 = _h1 + 0.01;
                _h2 = _h2 + 0.01;
                _blink ppEffectAdjust [1,1,0,[0,0,0,1],[1,1,1,1],[0.33,0.33,0.33,0],[_h1,_h2,0,0,0,0,4]];
                _blink ppEffectCommit 0;
                sleep 0.01;
            };
        _blink ppEffectAdjust [1,1,0,[0,0,0,0],[1,1,1,1],[0.33,0.33,0.33,0],[0,0,0,0,0,0,4]];
        _blink ppEffectCommit 0;
        };
    };
};
player addEventHandler ["Hit", { (_this select 0) spawn a2k_hitBlur; }];

a2k_explBlur = {
    if (alive player) then {
        _blur = ppEffectCreate ["dynamicBlur", 402];
        _blur ppEffectEnable true;
        _blur ppEffectAdjust [10];
        _blur ppEffectCommit 0;
        _blur ppEffectAdjust [0.0];
        _blur ppEffectCommit 1.5;
    };
};
player addEventHandler ["Explosion", { (_this select 0) spawn a2k_explBlur; }];

// KILLED BY //////////////////////////////////////////////////////////////////////////////////////
a2k_fnc_killedMsg = {
	params ["_unit","_killer"];
	_killerName = name _killer;
	_dist = floor (player distance _killer);
	_weaponName = getText (configFile >> "cfgWeapons" >> currentWeapon _killer >> "displayname");

	sleep 5;

	if (!isNull _killer AND _killer != player) then {
		systemChat format ["You were killed by %1 from %2m",_killerName,_dist,_weaponName];
	};
};
player addEventHandler ["Killed", { _this spawn a2k_fnc_killedMsg; }];

// THE MOONDAWG FIX ///////////////////////////////////////////////////////////////////////////////
player addEventHandler ["HandleRating", {0}];

// ANGRY ENEMIES //////////////////////////////////////////////////////////////////////////////////
[player] spawn {
waitUntil {CBA_missionTime > 0};
sleep 15;
_camoCoef = player getUnitTrait "camouflageCoef";
	for "_i" from 0 to 1 step 0 do {
		waitUntil {sleep 10; player getUnitTrait "camouflageCoef" != _camoCoef};
		player setUnitTrait ["camouflageCoef",_camoCoef];
	};
};

// CHANNEL SETUP //////////////////////////////////////////////////////////////////////////////////
0 enableChannel false;
1 enableChannel true;
2 enableChannel false;
3 enableChannel true;
4 enableChannel false;
5 enableChannel false;

// HEALZ //////////////////////////////////////////////////////////////////////////////////////////
if (!isNil "LAMBS_Hospital") then {
	[player] spawn {
		while {true} do {
			waitUntil {sleep 1; typeOf vehicle player == "Land_Pod_Heli_Transport_04_medevac_F"};
			player setDamage 0;
			[player,player] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
			//systemChat format ["You've been fully treated %1, The LAMBS Hospital wishes you a good day!", name player];
			waitUntil {sleep 1; typeOf vehicle player != "Land_Pod_Heli_Transport_04_medevac_F"};
		};
	};
};

// INSIGNIA FIX ///////////////////////////////////////////////////////////////////////////////////
player addEventHandler ["InventoryClosed", {
	params ["_unit", "_container"];
	_insignia = "";
	if ([_unit] call BIS_fnc_getUnitInsignia != "") then {
		_insignia = [_unit] call BIS_fnc_getUnitInsignia;
	};
	[_unit,""] call bis_fnc_setUnitInsignia;
	[_unit,_insignia] call bis_fnc_setUnitInsignia;
}];