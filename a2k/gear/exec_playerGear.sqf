
waitUntil {CBA_missionTime > 0};

private ["_p","_role"];
_p = _this select 0;
_role = roleDescription _p;
_class = "rifleman";

#include "cfg_player.sqf";

/// REMOVE ////////////////////////////////////////////////////////////////////////////////////////
removeAllItems _p;
removeAllAssignedItems _p;
removeAllWeapons _p;
removeBackpack _p;
removeHeadgear _p;
removeUniform _p;
removeVest _p;
//removeGoggles _p;

sleep 1;

// OPTIONS
onMapSingleClick "_shift";

// CLASS/CONTAINER INDEPENDENT STUFF
if (a2k_NVG == "ALL") then {_p addWeapon (_NVG select 0)};

/// SELECT CLASS //////////////////////////////////////////////////////////////////////////////////
if (_role find "Platoon Leader" >= 0) then {_class = "pltlead";};
if (_role find "Platoon Sergeant" >= 0) then {_class = "pltsgt";};
if (_role find "RTO" >= 0) then {_class = "rto";};
if (_role find "FAC" >= 0) then {_class = "fac";};
if (_role find "Squad Leader" >= 0) then {_class = "squadleader";};
if (_role find "Squad 2iC" >= 0) then {_class = "squad2ic";};
if (_role find "Rifleman" >= 0) then {_class = "rifleman";};
if (_role find "Grenadier" >= 0) then {_class = "grenadier";};
if (_role find "Autorifleman" >= 0) then {_class = "autorifleman";};
if (_role find "Medic" >= 0) then {_class = "medic";};
if (_role find "Machine Gunner" >= 0) then {_class = "mmg_g";};
if (_role find "Assistant Machine Gunner" >= 0) then {_class = "mmg_a";};
if (_role find "AT Gunner" >= 0) then {_class = "mat_g";};
if (_role find "AT Assistant" >= 0) then {_class = "mat_a";};
if (_role find "Vehicle Platoon Leader" >= 0) then {_class = "veh_pltlead";};
if (_role find "Vehicle Platoon Sergeant" >= 0) then {_class = "veh_pltsgt";};
if (_role find "Vehicle Commander" >= 0) then {_class = "veh_commander";};
if (_role find "Vehicle Gunner" >= 0) then {_class = "veh_gunner";};
if (_role find "Vehicle Driver" >= 0) then {_class = "veh_driver";};
if (_role find "Heli" >= 0) then {_class = "helipilot";};
if (_role find "Fighter" >= 0) then {_class = "fighterpilot";};

/// SWITCH CLASS //////////////////////////////////////////////////////////////////////////////////
if (count _this > 1) then {_class = _this select 1;};
switch (_class) do
{
	case "pltlead":
	{
		_p addHeadgear selectRandom _Headgear_O;
		_p forceAddUniform selectRandom _Uniform_O;
		_p addVest selectRandom _Vest_O;
		//_p addGoggles selectRandom _Goggles;
		_p addWeapon (_Binocular select 0);
		//_p addBackpack selectRandom _Backpack_Leader; clearAllItemsFromBackpack _p;
		_p addItemToUniform _ACRE_ITR;
		for "_i" from 1 to 2 do {_p addItemToVest (_Pistol_Ammo select 0)};
		for "_i" from 1 to 4 do {_p addItemToVest (_Carbine_Ammo select 0)};
		_p addItemToVest (_Carbine_Ammo_T select 0);
		_p addWeapon (_Carbine select 0);
		_p addWeapon (_Pistol select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Carbine_Optic;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach1;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_of2"] call bis_fnc_setUnitInsignia;
	};
	case "pltsgt":
	{
		_p addHeadgear selectRandom _Headgear_L;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 0);
		//_p addGoggles selectRandom _Goggles;
		_p addWeapon (_Binocular select 0);
		//_p addBackpack selectRandom _Backpack_Leader; clearAllItemsFromBackpack _p;
		_p addItemToUniform _ACRE_ITR;
		for "_i" from 1 to 4 do {_p addItemToVest (_Rifle_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Rifle_Ammo_T select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Grenade_Smoke select 1)};
		_p addWeapon (_Rifle select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Rifle_Optic;
		_p addPrimaryWeaponitem selectRandom _Rifle_Attach1;
		_p addPrimaryWeaponitem selectRandom _Rifle_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or5"] call bis_fnc_setUnitInsignia;
	};
	case "rto":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest selectRandom _Vest;
		//_p addGoggles selectRandom _Goggles;
		_p addBackpack selectRandom _Backpack_RTO; clearAllItemsFromBackpack _p;
		_p addItemToBackpack _ACRE_MMR;
		_p addItemToBackpack _ACRE_ITR;
		for "_i" from 1 to 4 do {_p addItemToVest (_Carbine_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Carbine_Ammo_T select 0)};
		_p addWeapon (_Carbine select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Carbine_Optic;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach1;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or4"] call bis_fnc_setUnitInsignia;
	};
	case "fac":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 1);
		//_p addGoggles selectRandom _Goggles;
		_p addWeapon (_Binocular select 0);
		_p linkItem "ItemGPS";
		_p addBackpack selectRandom _Backpack_RTO; clearAllItemsFromBackpack _p;
		_p addItemToBackpack _ACRE_MMR;
		_p addItemToUniform _ACRE_ITR;
		_p addItemToUniform "ACE_MapTools";
		for "_i" from 1 to 4 do {_p addItemToVest (_Rifle_GL_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Rifle_GL_Ammo_T select 0)};
		for "_i" from 1 to 3 do {_p addItemToVest (_Rifle_GL_Smoke select 0)};
		for "_i" from 1 to 3 do {_p addItemToVest (_Rifle_GL_Smoke_Grn select 0)};
		for "_i" from 1 to 3 do {_p addItemToVest (_Rifle_GL_Flare select 0)};
		_p addItemToVest (_Grenade_Smoke select 1);
		_p addWeapon (_Rifle_GL select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Rifle_GL_Optic;
		_p addPrimaryWeaponitem selectRandom _Rifle_GL_Attach1;
		_p addPrimaryWeaponitem selectRandom _Rifle_GL_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or5"] call bis_fnc_setUnitInsignia;
	};
	case "medic":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 0);
		//_p addGoggles selectRandom _Goggles;
		_p addBackpack selectRandom _Backpack_Medic; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 8 do {_p addItemToBackpack "ACE_Tourniquet";};
		for "_i" from 1 to 30 do {_p addItemToBackpack "ACE_fieldDressing";};
		for "_i" from 1 to 30 do {_p addItemToBackpack "ACE_packingBandage";};
		for "_i" from 1 to 5 do {_p addItemToBackpack "ACE_salineIV";};
		for "_i" from 1 to 5 do {_p addItemToBackpack "ACE_epinephrine";};
		for "_i" from 1 to 10 do {_p addItemToBackpack "ACE_morphine";};
		_p addItemToBackpack "ACE_personalAidKit";
		for "_i" from 1 to 4 do {_p addItemToVest (_Carbine_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Carbine_Ammo_T select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Pistol_Ammo select 0)};
		_p addItemToVest (_Grenade_Smoke select 0);
		_p addWeapon (_Carbine select 0);
		_p addWeapon (_Pistol select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Carbine_Optic;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach1;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach2;
		_p setVariable ["ACE_medical_medicClass", 1, true];
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_medic"] call bis_fnc_setUnitInsignia;
	};
	case "squadleader":
	{
		_p addHeadgear selectRandom _Headgear_L;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 0);
		//_p addGoggles selectRandom _Goggles;
		_p addWeapon (_Binocular select 0);
		//_p addBackpack selectRandom _Backpack_Leader; clearAllItemsFromBackpack _p;
		_p addItemToUniform _ACRE_ITR;
		for "_i" from 1 to 4 do {_p addItemToVest (_Rifle_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Rifle_Ammo_T select 0)};
		_p addItemToVest (_Grenade_Smoke select 1);
		_p addWeapon (_Rifle select 0);
		removeAllPrimaryWeaponItems _p;

		_p addPrimaryWeaponitem "optic_arco_blk_f";

		_p addPrimaryWeaponitem selectRandom _Rifle_Attach1;
		_p addPrimaryWeaponitem selectRandom _Rifle_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or5"] call bis_fnc_setUnitInsignia;
	};
	case "squad2ic":
	{
		_p addHeadgear selectRandom _Headgear_L;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 1);
		//_p addGoggles selectRandom _Goggles;
		_p addWeapon (_Binocular select 0);
		//_p addBackpack selectRandom _Backpack_Light; clearAllItemsFromBackpack _p;
		//_p addItemToBackpack _ACRE_MMR;
		_p addItemToUniform _ACRE_ITR;
		for "_i" from 1 to 4 do {_p addItemToVest (_Rifle_GL_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Rifle_GL_Ammo_T select 0)};
		for "_i" from 1 to 8 do {_p addItemToVest (_Rifle_GL_HE select 0)};
		_p addItemToVest (_Grenade_Smoke select 1);
		_p addWeapon (_Rifle_GL select 0);
		removeAllPrimaryWeaponItems _p;

		_p addPrimaryWeaponitem "optic_arco_blk_f";
		
		_p addPrimaryWeaponitem selectRandom _Rifle_GL_Attach1;
		_p addPrimaryWeaponitem selectRandom _Rifle_GL_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or4"] call bis_fnc_setUnitInsignia;
	};
	case "rifleman":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 3);
		//_p addGoggles selectRandom _Goggles;
		_p addBackpack selectRandom _Backpack_Light; clearAllItemsFromBackpack _p;
		_p addItemToBackpack (_LAT_Ammo select 0);
		for "_i" from 1 to 4 do {_p addItemToVest (_Rifle_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Rifle_Ammo_T select 0)};
		_p addWeapon (_Rifle select 0);
		_p addWeapon (_LAT select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem "optic_aco_grn";
		_p addPrimaryWeaponitem selectRandom _Rifle_Attach1;
		_p addPrimaryWeaponitem selectRandom _Rifle_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_empty"] call bis_fnc_setUnitInsignia;
		removeBackpack _p;
	};
	case "grenadier":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest selectRandom _Vest;
		//_p addGoggles selectRandom _Goggles;
		for "_i" from 1 to 4 do {_p addItemToVest (_Rifle_GL_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Rifle_GL_Ammo_T select 0)};
		for "_i" from 1 to 8 do {_p addItemToVest (_Rifle_GL_HE select 0)};
		_p addWeapon (_Rifle_GL select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Rifle_GL_Optic;
		_p addPrimaryWeaponitem selectRandom _Rifle_GL_Attach1;
		_p addPrimaryWeaponitem selectRandom _Rifle_GL_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_empty"] call bis_fnc_setUnitInsignia;
	};
	case "autorifleman":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest selectRandom _Vest;
		//_p addGoggles selectRandom _Goggles;
		_p addBackpack selectRandom _Backpack_AR_MMG; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 3 do {_p addItemToVest (_LMG_Ammo select 0)};
		for "_i" from 1 to 3 do {_p addItemToBackpack (_LMG_Ammo select 0)};
		_p addWeapon (_LMG select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _LMG_Optic;
		_p addPrimaryWeaponitem selectRandom _LMG_Attach1;
		_p addPrimaryWeaponitem selectRandom _LMG_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_empty"] call bis_fnc_setUnitInsignia;
	};
	case "mmg_g":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 3);
		//_p addGoggles selectRandom _Goggles;
		_p addBackpack (_Backpack_AR_MMG select 0); clearAllItemsFromBackpack _p;
		for "_i" from 1 to 2 do {_p addItemToBackpack (_MMG_Ammo select 0)};
		_p addItemToBackpack (_MMG_Ammo_T select 0);
		_p addItemToVest (_MMG_Ammo select 0);
		for "_i" from 1 to 3 do {_p addItemToVest (_Pistol_Ammo select 0)};
		_p addWeapon (_MMG select 0);
		_p addWeapon (_Pistol select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _MMG_Optic;
		_p addPrimaryWeaponitem selectRandom _MMG_Attach1;
		_p addPrimaryWeaponitem selectRandom _MMG_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_empty"] call bis_fnc_setUnitInsignia;
	};
	case "mmg_a":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 2);
		//_p addGoggles selectRandom _Goggles;
		_p addWeapon (_Binocular select 0);
		_p addBackpack (_Backpack_AR_MMG select 1); clearAllItemsFromBackpack _p;
		for "_i" from 1 to 3 do {_p addItemToBackpack (_MMG_Ammo select 0)};
		//for "_i" from 1 to 2 do {_p addItemToBackpack (_MMG_Ammo_T select 0)};
		_p addItemToBackpack "ACE_SpareBarrel";
		for "_i" from 1 to 4 do {_p addItemToVest (_Carbine_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Carbine_Ammo_T select 0)};
		_p addWeapon (_Carbine select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Carbine_Optic;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach1;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_empty"] call bis_fnc_setUnitInsignia;
	};
	case "mat_g":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 0);
		//_p addGoggles selectRandom _Goggles;
		_p addBackpack selectRandom _Backpack_MAT; clearAllItemsFromBackpack _p;
		_p addItemToBackpack (_MAT_Ammo select 0);
		for "_i" from 1 to 4 do {_p addItemToVest (_Carbine_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Carbine_Ammo_T select 0)};
		_p addWeapon (_MAT select 0);
		_p addWeapon (_Carbine select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Carbine_Optic;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach1;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach2;
		_p addSecondaryWeaponitem selectRandom _MAT_Optic;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_empty"] call bis_fnc_setUnitInsignia;
	};
	case "mat_a":
	{
		_p addHeadgear selectRandom _Headgear;
		_p forceAddUniform selectRandom _Uniform;
		_p addVest (_Vest select 2);
		//_p addGoggles selectRandom _Goggles;
		_p addWeapon (_Binocular select 0);
		_p addBackpack selectRandom _Backpack_MAT; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 2 do {_p addItemToBackpack (_MAT_Ammo select 0)};
		for "_i" from 1 to 4 do {_p addItemToVest (_Carbine_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToVest (_Carbine_Ammo_T select 0)};
		_p addWeapon (_Carbine select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _Carbine_Optic;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach1;
		_p addPrimaryWeaponitem selectRandom _Carbine_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_empty"] call bis_fnc_setUnitInsignia;
	};
	case "veh_pltlead":
	{
		_p addHeadgear selectRandom _Crew_Headgear;
		_p forceAddUniform selectRandom _Crew_Uniform;
		_p addVest selectRandom _Crew_Vest;
		//_p addGoggles selectRandom _Crew_Goggles;
		_p addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _p;
		_p addItemToBackpack _ACRE_ITR;
		for "_i" from 1 to 4 do {_p addItemToVest (_SMG_Ammo select 0)};
		_p addWeapon (_SMG select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _SMG_Optic;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach1;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach2;
		_p addWeapon (_Binocular select 0);
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_of1"] call bis_fnc_setUnitInsignia;
	};
	case "veh_pltsgt":
	{
		_p addHeadgear selectRandom _Crew_Headgear;
		_p forceAddUniform selectRandom _Crew_Uniform;
		_p addVest selectRandom _Crew_Vest;
		//_p addGoggles selectRandom _Crew_Goggles;
		_p addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _p;
		_p addItemToBackpack _ACRE_ITR;
		for "_i" from 1 to 4 do {_p addItemToVest (_SMG_Ammo select 0)};
		_p addWeapon (_SMG select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _SMG_Optic;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach1;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach2;
		_p addWeapon (_Binocular select 0);
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or6"] call bis_fnc_setUnitInsignia;
	};
	case "veh_commander":
	{
		_p addHeadgear selectRandom _Crew_Headgear;
		_p forceAddUniform selectRandom _Crew_Uniform;
		_p addVest selectRandom _Crew_Vest;
		//_p addGoggles selectRandom _Crew_Goggles;
		_p addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _p;
		_p addItemToBackpack _ACRE_ITR;
		for "_i" from 1 to 4 do {_p addItemToVest (_SMG_Ammo select 0)};
		_p addWeapon (_SMG select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _SMG_Optic;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach1;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach2;
		_p addWeapon (_Binocular select 0);
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or5"] call bis_fnc_setUnitInsignia;
	};
	case "veh_gunner":
	{
		_p addHeadgear selectRandom _Crew_Headgear;
		_p forceAddUniform selectRandom _Crew_Uniform;
		_p addVest selectRandom _Crew_Vest;
		//_p addGoggles selectRandom _Crew_Goggles;
		_p addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 4 do {_p addItemToVest (_SMG_Ammo select 0)};
		_p addWeapon (_SMG select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _SMG_Optic;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach1;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or2"] call bis_fnc_setUnitInsignia;
	};
	case "veh_driver":
	{
		_p addHeadgear selectRandom _Crew_Headgear;
		_p forceAddUniform selectRandom _Crew_Uniform;
		_p addVest selectRandom _Crew_Vest;
		//_p addGoggles selectRandom _Crew_Goggles;
		_p addBackpack selectRandom _Backpack_Crew; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 4 do {_p addItemToVest (_SMG_Ammo select 0)};
		_p addWeapon (_SMG select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _SMG_Optic;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach1;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach2;
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_empty"] call bis_fnc_setUnitInsignia;
	};
	case "helipilot":
	{
		if (a2k_NVG == "PILOTS") then {_p addWeapon (_NVG_Pilot select 0)};
		if (a2k_NVG == "ALL") then {_p addWeapon (_NVG_Pilot select 0)};
		_p addHeadgear selectRandom _Heli_Headgear;
		_p forceAddUniform selectRandom _Heli_Uniform;
		_p addVest selectRandom _Heli_Vest;
		//_p addGoggles selectRandom _Heli_Goggles;
		_p addBackpack selectRandom _Backpack_Pilot; clearAllItemsFromBackpack _p;
		for "_i" from 1 to 4 do {_p addItemToBackpack (_SMG_Ammo select 0)};
		for "_i" from 1 to 2 do {_p addItemToBackpack (_FlareGun_Ammo select 1)};
		_p addItemToBackpack (_Grenade_Smoke select 1);
		_p addItemToUniform _ACRE_ITR;
		_p addWeapon (_SMG select 0);
		_p addWeapon (_FlareGun select 0);
		removeAllPrimaryWeaponItems _p;
		_p addPrimaryWeaponitem selectRandom _SMG_Optic;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach1;
		_p addPrimaryWeaponitem selectRandom _SMG_Attach2;
		_p setVariable ["ACE_IsEngineer",1,true];
		if (rank _p == "SERGEANT") then { [_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_or5"] call bis_fnc_setUnitInsignia; } 
			else { [_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_of1"] call bis_fnc_setUnitInsignia; };
	};
	case "fighterpilot":
	{
		if (a2k_NVG == "PILOTS") then {_p addWeapon (_NVG_Pilot select 0)};
		if (a2k_NVG == "ALL") then {_p addWeapon (_NVG_Pilot select 0)};
		_p addHeadgear selectRandom _Plane_Headgear;
		_p forceAddUniform selectRandom _Plane_Uniform;
		_p addVest selectRandom _Plane_Vest;
		//_p addGoggles selectRandom _Plane_Goggles;
		_p addBackpack selectRandom _Backpack_Pilot; clearAllItemsFromBackpack _p;
		_p addItemToBackpack _ACRE_ITR;
		for "_i" from 1 to 2 do {_p addItem (_Pistol_Ammo select 0)};
		_p addWeapon (_Pistol select 0);
		_p addItemToBackpack (_FlareGun select 0);
		for "_i" from 1 to 2 do {_p addItemToBackpack (_FlareGun_Ammo select 0)};
		onMapSingleClick "";
		[_p,""] call bis_fnc_setUnitInsignia; sleep 1; [_p,"lambs_of1"] call bis_fnc_setUnitInsignia;
	}; 
};


// BACKPACKS
if (a2k_backpacksAll) then {
	if (isNull (unitBackpack _p)) then {
		_p addBackpack selectRandom _Backpack_Light; clearAllItemsFromBackpack _p;
	};
};

// MISC
if (a2k_personalRadio == "ALL") then {_p addItemToUniform _ACRE_PRR;};
for "_i" from 1 to 4 do {_p addItemToUniform "ACE_fieldDressing";};
_p addItemToUniform "ACE_morphine";
_p addItemToUniform "ACE_tourniquet";
for "_i" from 1 to 2 do {_p addItemToVest (_Grenade select 0);};
_p addItemToVest (_Grenade_Smoke select 0);
_p linkItem "ItemWatch";
_p linkItem "ItemCompass";

// MAPS
if (a2k_maps == "ALL") then {
	_p linkItem "ItemMap"; _p addItem "ACE_Flashlight_XL50";
} else
{
	if (_class == "helipilot" OR _class == "fighterpilot") then {
		_p linkItem "ItemMap";
	};
};
if (a2k_maps == "LEADERS") then {
	if (_class == "pltlead" OR _class == "pltsgt" OR _class == "squadleader" OR _class == "squad2ic" OR _class == "fac" OR _class == "veh_pltlead" OR _class == "veh_pltsgt" OR _class == "veh_commander") then {
		_p linkItem "ItemMap"; _p addItem "ACE_Flashlight_XL50";
	};
};

// PISTOLS
if (a2k_pistolsAll) then {
	if (handgunWeapon _p == "") then {
		for "_i" from 1 to 2 do {_p addItem (_Pistol_Ammo select 0)};
		_p addWeapon (_Pistol select 0);
	};
};