// APPLY SETTINGS TO CAMANBASE OF VAR_ENEMYSIDE ///////////////////////////////////////////////////

// START THE FUNCTION /////////////////////////////////////////////////////////////////////////////
params [["_var_unit",objNull,[objNull]]];
if (isNull _var_unit) exitWith {};

#include "..\..\settings\cfg_AI.sqf"



// CHECK WHO GETS WHAT GEAR ///////////////////////////////////////////////////////////////////////
private _type = typeOf _var_unit;
private _allTypesAA = [_Autorifleman, _Crew, _Grenadier, _MMG_Gunner, _Marksman, _AA_Gunner, _MAT_Gunner, _Officer, _Pilot, _Rifleman, _Rifleman_AT, _Squad_Leader];
private _someTypes = [_Autorifleman,_Grenadier, _Marksman, _Rifleman_AT];

if (_allTypesAA findif {_type == _x} == -1) then {
	_type = [_Rifleman, selectRandom _someTypes] select (40 > random 100); // select a random Loadout for people that aren't a defined _type
};



// APPLY EVENT HANDLERS ///////////////////////////////////////////////////////////////////////////
//KILLED EH
_var_unit addEventHandler ["Killed", {
	_this call lmf_ai_fnc_killedEH;
}];

//SUPPRESSION EH
if (_type == _Autorifleman || {_type == _MMG_Gunner}) then {
	_var_unit addEventHandler ["Fired", {
		_this call lmf__ai_fnc_suppressEH;
	}];
};



// APPLY SKILL ////////////////////////////////////////////////////////////////////////////////////
private _skill_untrained = skill _var_unit * selectRandom [0.01,0.03,0.05,0.10,0.15];
private _skill_regular = skill _var_unit * selectRandom [0.35,0.45,0.50,0.55,0.60];
private _skill_elite = skill _var_unit * selectRandom [0.85,0.90,0.95,1.05,1.10];
if (_var_enemySkill == 0) then {_var_unit setSkill _skill_untrained;};
if (_var_enemySkill == 1) then {_var_unit setSkill _skill_regular;};
if (_var_enemySkill == 2) then {_var_unit setSkill _skill_elite;};



// CHANCE TO WAKEUP AI ////////////////////////////////////////////////////////////////////////////
// this will probably become an EH in the future (if I can ever bother)
if (ace_medical_enableUnconsciousnessAI != 0) then {
	[_var_unit] spawn {
		_var_unit = _this select 0;

		for "_i" from 0 to 1 step 0 do {
			waitUntil {sleep 5; _var_unit getVariable ["ACE_isUnconscious", false];};
			if (12.5 > random 100) then {
				[_var_unit, false] call ace_medical_fnc_setUnconscious;
			};
		sleep 15;
		};
	};
};



// APPLY LOADOUT //////////////////////////////////////////////////////////////////////////////////
//GIVE NVG
if (_var_enemyNVG) then {
	_var_unit linkItem "NVGoggles_OPFOR";
};

//EXIT IF NO CUSTOM GEAR 
if (!_var_enemyGear) exitwith {};

//REMOVE OLD STUFF
removeAllWeapons _var_unit;
removeAllItems _var_unit;
removeAllAssignedItems _var_unit;
removeUniform _var_unit;
removeVest _var_unit;
removeBackpack _var_unit;
removeHeadgear _var_unit;
removeGoggles _var_unit;

//REASSIGN NVG
if (_var_enemyNVG) then {
	_var_unit linkItem "NVGoggles_OPFOR";
};

//CHOOSE CLOTHING
private _s_Uniform = selectRandom _Uniform;
private _s_Vest = selectRandom _Vest;
private _s_Backpack = selectRandom _Backpack_Light;
private _s_Headgear = selectRandom _Headgear;
private _s_Goggles = selectRandom _Goggles;

if (_type == _MMG_Gunner || {_type == _MAT_Gunner || {_type == _AA_Gunner}}) then {
	_s_Backpack = selectRandom _Backpack_Heavy;
};

if (_type == _Pilot) then {
	_s_Uniform = selectRandom _Heli_Uniform;
	_s_Vest = selectRandom _Heli_Vest;
	_s_Headgear = selectRandom _Heli_Headgear;
	_s_Backpack = "B_parachute";
};

if (_type == _Crew) then {
	_s_Uniform = selectRandom _Crew_Uniform;
	_s_Vest = selectRandom _Crew_Vest;
	_s_Headgear = selectRandom _Crew_Headgear;
};

//ADD CLOTHING
_var_unit forceAddUniform _s_Uniform;
_var_unit addVest _s_Vest;
_var_unit addHeadgear _s_Headgear;
_var_unit addBackpack _s_Backpack; clearAllItemsFromBackpack _var_unit;
if (10 > random 100) then {_var_unit addGoggles _s_Goggles};



// WEAPONS ////////////////////////////////////////////////////////////////////////////////////////
//RIFL AND SQL
if (_type == _Rifleman || {_type == _Squad_Leader}) then {
	if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
	[_var_unit, selectRandom _Rifle, 12, _Rifle_Ammo] call BIS_fnc_addWeapon;
};

//AR
if (_type == _Autorifleman) then {
	if (_LMG_Ammo select 0 == "") then {_LMG_Ammo = 0;} else {_LMG_Ammo = selectRandom _LMG_Ammo};
	[_var_unit, selectRandom _LMG, 10, _LMG_Ammo] call BIS_fnc_addWeapon;
};

//LAT
if (_type == _Rifleman_AT) then {
	if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
	if (_LAT_Ammo select 0 == "") then {_LAT_Ammo = 0;} else {_LAT_Ammo = selectRandom _LAT_Ammo};
	[_var_unit, selectRandom _Rifle, 12, _Rifle_Ammo] call BIS_fnc_addWeapon;
	[_var_unit, selectRandom _LAT, 1, _LAT_Ammo] call BIS_fnc_addWeapon;
};

//GL
if (_type == _Grenadier) then {
	if (_Rifle_GL_Ammo select 0 == "") then {_Rifle_GL_Ammo = 0;} else {_Rifle_GL_Ammo = selectRandom _Rifle_GL_Ammo};
	private _random40 = selectRandom [selectRandom _Rifle_GL_Flare, selectRandom _Rifle_GL_Smoke];
	for "_i" from 1 to 4 do {_var_unit addItem _random40;};
	[_var_unit, selectRandom _Rifle_GL, 10, _Rifle_GL_Ammo] call BIS_fnc_addWeapon;
};

//MG
if (_type == _MMG_Gunner) then {
	if (_MMG_Ammo select 0 == "") then {_MMG_Ammo = 0;} else {_MMG_Ammo = selectRandom _MMG_Ammo};
	[_var_unit, selectRandom _MMG, 10, _MMG_Ammo] call BIS_fnc_addWeapon;

};

//MAT
if (_type == _MAT_Gunner) then {
	if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
	if (_MAT_Ammo select 0 == "") then {_MAT_Ammo = 0;} else {_MAT_Ammo = selectRandom _MAT_Ammo};
	[_var_unit, selectRandom _Rifle, 1, _Rifle_Ammo] call BIS_fnc_addWeapon;
	[_var_unit, selectRandom _MAT, 4, _MAT_Ammo] call BIS_fnc_addWeapon;
};

//MARK
if (_type == _Marksman) then {
	if (_DMR_Ammo select 0 == "") then {_DMR_Ammo = 0;} else {_DMR_Ammo = selectRandom _DMR_Ammo};
	[_var_unit, selectRandom _DMR, 10, _DMR_Ammo] call BIS_fnc_addWeapon;

};

//CREW AND PILOT
if (_type == _Crew || {_type == _Pilot}) then {
	if (_Carbine_Ammo select 0 == "") then {_Carbine_Ammo = 0;} else {_Carbine_Ammo = selectRandom _Carbine_Ammo};
	[_var_unit, selectRandom _Carbine, 10, _Carbine_Ammo] call BIS_fnc_addWeapon;
};

//AA
if (_type == _AA_Gunner) then {
	if (_Rifle_Ammo select 0 == "") then {_Rifle_Ammo = 0;} else {_Rifle_Ammo = selectRandom _Rifle_Ammo};
	if (_AA_Ammo select 0 == "") then {_AA_Ammo = 0;} else {_AA_Ammo = selectRandom _AA_Ammo};
	[_var_unit, selectRandom _Rifle, 12, _Rifle_Ammo] call BIS_fnc_addWeapon;
	[_var_unit, selectRandom _AA, 4, _AA_Ammo] call BIS_fnc_addWeapon;

};

//OFF
if (_type == _Officer) then {
	if (_Pistol_Ammo select 0 == "") then {_Pistol_Ammo = 0;} else {_Pistol_Ammo = selectRandom _Pistol_Ammo};
	[_var_unit, selectRandom _Pistol, 10, _Pistol_Ammo] call BIS_fnc_addWeapon;
};

// MISC LOOT //////////////////////////////////////////////////////////////////////////////////////
//ADD GRENADES
if (50 > random 100) then {_var_unit addItem selectRandom _Grenade;};
if (50 > random 100) then {_var_unit addItem selectRandom _Grenade_Smoke;};

//ADD FAK
if (50 > random 100) then {for "_i" from 1 to 2 do {_var_unit addItem "FirstAidKit";};};

//WEAPON ATTACH
removeAllPrimaryWeaponItems _var_unit;
if (_type != _Crew && {_type != _Pilot}) then {
	if (30 > random 100) then {_var_unit addPrimaryWeaponItem selectRandom _Attach;};
	if (50 > random 100) then {_var_unit addPrimaryWeaponItem selectRandom _Optic;};
};

//MISC
if (_var_unit == leader group _var_unit || {_type == _MAT_Gunner || {_type == _Crew}}) then {_var_unit addWeapon "Binocular"};