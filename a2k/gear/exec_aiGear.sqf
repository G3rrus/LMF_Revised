private ["_p"];
_p = _this select 0;
_type = typeOf _p;

_p allowDamage false;

#include "cfg_ai.sqf";

// DEFAULT PRIMARY
_weapon = "rifle";

/// REMOVE ////////////////////////////////////////////////////////////////////////////////////////
removeAllItems _p;
removeAllAssignedItems _p;
removeAllWeapons _p;
removeBackpack _p;

// ADD CUSTOM UNIFORMS ////////////////////////////////////////////////////////////////////////////
if (a2k_customUniformsAI) then {
removeHeadgear _p;
removeUniform _p;
removeVest _p;
removeGoggles _p;
_p addHeadgear _Headgear;
_p forceAddUniform _Uniform;
_p addVest _Vest;
if (10 > random 100) then { _p addGoggles _Goggles; };
};

sleep 10;

// SET IDENTITY ///////////////////////////////////////////////////////////////////////////////////
/*
_f = [
"AsianHead_A3_01",
"AsianHead_A3_02",
"AsianHead_A3_03", 
"GreekHead_A3_01", 
"GreekHead_A3_02", 
"GreekHead_A3_03", 
"GreekHead_A3_04", 
"GreekHead_A3_05", 
"GreekHead_A3_06", 
"GreekHead_A3_07", 
"GreekHead_A3_08", 
"GreekHead_A3_09",
"WhiteHead_02", 
"WhiteHead_03", 
"WhiteHead_04", 
"WhiteHead_05", 
"WhiteHead_06", 
"WhiteHead_07", 
"WhiteHead_08", 
"WhiteHead_09", 
"WhiteHead_10", 
"WhiteHead_11", 
"WhiteHead_12", 
"WhiteHead_13", 
"WhiteHead_14",
"WhiteHead_15"
];

_f = selectRandom _f;
_face = [_p, _f] remoteExecCall ["setface", 0];
_voice = [_p, SelectRandom ["rhs_male01rus","rhs_male02rus","rhs_male03rus","rhs_male04rus","rhs_male05rus"]] remoteExecCall ["setSpeaker", 0];

_fruit = selectRandom 
  [
"Speermann"
  ];
_name = [_p,[format ["Agent %1",_fruit],"Agent",_fruit]] remoteExecCall ["SetName", 0];
*/
/// SELECT WEAPON /////////////////////////////////////////////////////////////////////////////////
if (_type == _Officer) then {_weapon = "pistol";};
if (_type == _Squad_Leader) then {_weapon = "riflegl";};
if (_type == _Rifleman) then {_weapon = "rifle";};
if (_type == _Grenadier) then{_weapon = "riflegl";};
if (_type == _Autorifleman) then {_weapon = "lmg";};
if (_type == _MMG_Gunner) then {_weapon = "mmg";};
if (_type == _Marksman) then {_weapon = "riflem";};

if (_type == _Rifleman_AT) then {
		_weapon = "rifle";
		_p addBackpack _Backpack_Light; clearAllItemsFromBackpack _p;
		_p addWeapon _LAT;
		_p addItem _LAT_Ammo;
};

if (_type == _MAT_Gunner) then {
	_weapon = "rifleNoAmmo";
	_p addBackpack _Backpack_MAT; clearAllItemsFromBackpack _p;
	_p addWeapon _MAT;
	for "_i" from 1 to 8 do {_p addItem _MAT_Ammo;};
};

if (_type == _AA_Gunner) then {
		_weapon = "rifle";
		_p addWeapon _AA;
		_p addBackpack _Backpack_Heavy; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 4 do {_p addItem _AA_Ammo;};
};

if (_type == _Vehicle_Crew) then {
	if (a2k_customUniformsAI) then {
		removeHeadgear _p;
		removeUniform _p;
		removeVest _p;
		_p addHeadgear _Crew_Headgear;
		_p forceAddUniform _Crew_Uniform;
		_p addVest _Crew_Vest;
	};
	_weapon = "carbine";
	_p addWeapon "Binocular";
};

if (_type == _Heli_Pilot) then {
	if (a2k_customUniformsAI) then {
		removeHeadgear _p;
		removeUniform _p;
		removeVest _p;
		_p addHeadgear _Heli_Headgear;
		_p forceAddUniform _Heli_Uniform;
		_p addVest _Heli_Vest;
	};
	_weapon = "carbine";
	_p addBackpack "B_parachute";
};


/// SWITCH WEAPON /////////////////////////////////////////////////////////////////////////////////
switch (_weapon) do 
{
	case "pistol":
	{
		for "_i" from 1 to 4 do {_p addItem _Pistol_Ammo;};
		_p addWeapon _Pistol;
	};

	case "rifleNoAmmo":
	{
		//_p addMagazine [_Rifle_Ammo, 1 + (random 4)];
		_p addWeapon _Rifle;
	};

	case "carbine":
	{
		for "_i" from 1 to 8 do {_p addItem _Carbine_Ammo;};
		_p addWeapon _Carbine;
	};

	case "rifle":
	{
		for "_i" from 1 to 12 do {_p addItem _Rifle_Ammo;};
		_p addWeapon _Rifle;
	};
  
	case "riflegl":
	{
		for "_i" from 1 to 10 do {_p addItem _Rifle_GL_Ammo;};
		_random40 = selectRandom [_Rifle_GL_Flare,_Rifle_GL_Smoke];
		for "_i" from 1 to 4 do {_p addItem _random40;};
		_p addWeapon _Rifle_GL;
	};
  
	case "lmg":
	{
		_p addBackpack _Backpack_Heavy; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 10 do {_p addItem _LMG_Ammo;};
		_p addWeapon _LMG;
	};

	case "mmg":
	{
		_p addBackpack _Backpack_Heavy; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 10 do {_p addItem _MMG_Ammo;};
		_p addWeapon _MMG;
	};
	case "riflem":
	{
		for "_i" from 1 to 10 do {_p addItem _Sniper_Ammo;};
		_p addWeapon _Sniper;
	};
};

//ADD GRENADES
if (50 > random 100) then {_p addItem _Grenade;};
if (75 > random 100) then {_p addItem _Grenade_Smoke;};

//ADD FAK
if (80 > random 100) then {for "_i" from 1 to 2 do {_p addItem "FirstAidKit";};};

// WEAPON ATTACH //////////////////////////////////////////////////////////////////////////////////
removeAllPrimaryWeaponItems _p;
if (_type != _Vehicle_Crew AND _type != _Heli_Pilot) then {
	if (75 > random 100) then {_p addPrimaryWeaponItem _Attach;};
	if (25 > random 100) then {_p addPrimaryWeaponItem _Optic;};
};

// MISC ///////////////////////////////////////////////////////////////////////////////////////////
if (_p == leader group _p OR _type == _MAT_Gunner) then {_p addWeapon "Binocular"};

// NVG DURING NIGHT ///////////////////////////////////////////////////////////////////////////////
if (a2k_aiNVG) then {

	X_fnc_SunElev = {
		private ["_lat", "_day", "_hour", "_angle", "_isday"];
		_lat = -1 * getNumber(configFile >> "CfgWorlds" >> worldName >> "latitude");
		_day = 360 * (dateToNumber date);
		_hour = (daytime / 24) * 360;
		_angle = ((12 * cos(_day) - 78) * cos(_lat) * cos(_hour)) - (24 * sin(_lat) * cos(_day));
		_angle
	};

	[_p] spawn {
		_p = _this select 0;

		for "_i" from 0 to 1 step 0 do {
			if (call X_fnc_SunElev < 0) then {
				_p linkItem "NVGoggles_INDEP";
				waitUntil {sleep 30; call X_fnc_SunElev > 0};
				_p unlinkItem "NVGoggles_INDEP";
			} else
			{
				_p unlinkItem "NVGoggles_INDEP";
				waitUntil {sleep 30; call X_fnc_SunElev < 0};
				_p linkItem "NVGoggles_INDEP";
			};
		sleep 30;
		};
	};
};

// WAKEY WAKEY ////////////////////////////////////////////////////////////////////////////////////
if (ace_medical_enableUnconsciousnessAI != 0) then {
	[_p] spawn {
		_p = _this select 0;

		for "_i" from 0 to 1 step 0 do {
			waitUntil {sleep 5; _p getVariable ["ACE_isUnconscious", false];};
			if (12.5 > random 100) then {
				[_p, false] call ace_medical_fnc_setUnconscious;
			};
		sleep 15;
		};
	};
};

// ADD SOME MEDICAL FOR PLAYERS ///////////////////////////////////////////////////////////////////
//_loot_common = ["ACE_fieldDressing", "ACE_morphine", "ACE_epinephrine", "ACE_BloodIV"];
//if (40 > random 100) then {for "_i" from 1 to 5 do {_p addItem (selectRandom _loot_common)}};

// HANDLE GEAR ON DEATH ///////////////////////////////////////////////////////////////////////////
_p addEventhandler ["KILLED",{
	_this spawn {_unit = _this select 0; removeAllPrimaryWeaponItems _unit; _unit unlinkItem "NVGoggles_INDEP"; _unit removeWeapon "Binocular";};
}];

// SUPPRESS EVENTHANDLER //////////////////////////////////////////////////////////////////////////
if (_type == _Autorifleman OR _type == _MMG_Gunner) then {
	_p addEventHandler ["Fired", {
		// init
		_p = param [0];
		_Zzz = round (3 + random 6);

		_modes = (getArray (configFile >> "CfgWeapons" >> currentWeapon _p >> "modes"));
		_auto = "FullAuto";
		if (_modes find "FullAuto" == -1) then {_auto = "close"};
       
		// do it
		if (_p getVariable ["var_isSuppressing",false]) exitWith {};
		_e = (_p findNearestenemy _p);
		if (_p distance _e < 50 || _p distance _e > 800) exitWith {};
		[[_p],[_e],_Zzz,false,_auto] spawn fn_TaskSuppress;
		}
	];
};

// SKILL
_skill_untrained = skill _p * selectRandom [0.01,0.03,0.05,0.10,0.15];
_skill_regular = skill _p * selectRandom [0.35,0.45,0.50,0.55,0.60];
_skill_elite = skill _p * selectRandom [0.85,0.90,0.95,1.05,1.10];
if (a2k_aiSkill == 0) then {_p setSkill _skill_untrained;};
if (a2k_aiSkill == 1) then {_p setSkill _skill_regular;};
if (a2k_aiSkill == 2) then {_p setSkill _skill_elite;};

_p setSkill ["spotDistance",1];
_p setSkill ["spotTime",1];

_p allowDamage true;