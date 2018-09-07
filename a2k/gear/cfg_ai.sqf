///////////////////////////////////////////////////////////////////////////////////////////////////
// AI GEAR SETTINGS ///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
_spawnSide = WEST; //What side is the enemy? (WEST,EAST,INDEPENDENT)
a2k_customUniformsAI = true; //Use custom uniforms for enemy defined?
a2k_aiNVG = false; //Give the enemy Night Vision Goggles?
a2k_aiSkill = 1; // 0=UNTRAINED, 1=REGULAR, 2=ELITE


// DEFINE AI GEAR /////////////////////////////////////////////////////////////////////////////////
//INFANTRY
_Headgear = selectRandom [

"rhsgref_bcap_specter",
"rhsgref_Booniehat_alpen",
"rhsgref_fieldcap_ttsko_forest",
"rhsgref_fieldcap_ttsko_mountain",
"rhsgref_6b27m_ttsko_forest",
"rhsgref_6b27m_ttsko_mountain",
"rhsgref_helmet_pasgt_erdl",
"rhsgref_ssh68_ttsko_mountain",
"rhsgref_ssh68_ttsko_dark",
"rhssaf_bandana_digital",
"rhssaf_bandana_digital_desert",
"rhssaf_bandana_md2camo",
"rhssaf_bandana_smb",
"rhssaf_booniehat_digital",
"rhssaf_booniehat_md2camo",
"rhssaf_booniehat_woodland",
"rhssaf_helmet_m97_woodland",
"rhs_beanie_green",
"rhs_beanie",
"H_Watchcap_camo",
"H_Watchcap_khk",
"H_Booniehat_khk",
"H_Booniehat_oli",
"H_Booniehat_tan",
"H_Cap_tan",
"rhsgref_helmet_pasgt_olive",
"rhsgref_ssh68_ttsko_digi"

];

_Uniform = selectRandom [

"rhssaf_uniform_m10_digital",
"rhssaf_uniform_m10_digital_desert",
"rhssaf_uniform_m10_digital_summer",
"rhssaf_uniform_m10_digital_tan_boots",
"rhssaf_uniform_m93_oakleaf",
"rhssaf_uniform_m93_oakleaf_summer",
"rhsgref_uniform_altis_lizard_olive",
"rhsgref_uniform_dpm_olive",
"rhsgref_uniform_flecktarn",
"rhsgref_uniform_woodland_olive",
"rhsgref_uniform_reed"

];

_Vest = selectRandom [

"rhs_6b5_officer_ttsko",
"rhs_6b5_khaki",
"rhs_6sh92_digi_radio",
"rhs_6sh92_digi",
"V_TacVest_oli",
"V_TacVest_blk",
"V_Chestrig_oli",
"rhssaf_vest_md12_digital",
"rhssaf_vest_md98_rifleman",
"rhssaf_vest_md99_woodland_radio",
"rhssaf_vest_md98_woodland",
"rhsgref_otv_digi",
"rhsgref_otv_khaki",
"rhssaf_vest_otv_md2camo",
"rhssaf_vest_md99_md2camo",
"rhssaf_vest_md99_woodland_rifleman",
"V_TacVest_camo",
"rhsgref_6b23_ttsko_mountain_sniper",
"rhsgref_TacVest_ERDL",
"rhssaf_vest_md99_md2camo_rifleman",
"rhssaf_vest_md12_digital_desert",
"rhssaf_vest_md12_m70_rifleman",
"rhssaf_vest_md98_md2camo"

];

_Goggles = selectRandom [
	
"G_Balaclava_blk",
"G_Balaclava_lowprofile",
"G_Balaclava_oli",
"G_Bandanna_aviator",
"G_Bandanna_blk",
"G_Bandanna_oli",
"G_Bandanna_shades",
"G_Shades_Black",
"G_Shades_Red",
"G_Shades_Green",
"G_Squares_Tinted",
"G_Squares",
"G_Respirator_white_F",
"G_Respirator_blue_F"

];

//HELICOPTER CREW
_Heli_Headgear = "rhs_gssh18";
_Heli_Uniform = "rhsgref_uniform_olive";
_Heli_Vest = "rhsgref_otv_khaki";

//VEHICLE CREW
_Crew_Headgear = "rhssaf_helmet_m97_oakleaf";
_Crew_Uniform = "rhsgref_uniform_olive";
_Crew_Vest = "rhsgref_otv_khaki";

//WEAPONS
_Pistol = "hgun_Pistol_heavy_02_F";
_Pistol_Ammo = "6Rnd_45ACP_Cylinder";

_Carbine = "arifle_AKS_F";
_Carbine_Ammo = "30Rnd_545x39_Mag_Tracer_F";

_Rifle = selectRandom [ "arifle_AKM_F", "arifle_AK12_F"];
_Rifle_Ammo = "30Rnd_762x39_Mag_Tracer_F";

_Rifle_GL = "arifle_AK12_GL_F";
_Rifle_GL_Ammo = "30Rnd_762x39_Mag_Tracer_F";
_Rifle_GL_Smoke = "1Rnd_Smoke_Grenade_shell";
_Rifle_GL_Flare = "UGL_FlareYellow_F";

_LMG = "LMG_03_F";
_LMG_Ammo = "200Rnd_556x45_Box_Tracer_F";

_MMG = "LMG_Mk200_F";
_MMG_Ammo = "200Rnd_65x39_cased_Box_Tracer";

_Sniper = selectRandom [ "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F"];
_Sniper_Ammo = "20Rnd_762x51_Mag";

_LAT = "rhs_weap_rshg2";
_LAT_Ammo = "";

_MAT = "launch_RPG7_F"; //launch_RPG7_F, rhs_weap_rpg7
_MAT_Ammo = "RPG7_F"; //RPG7_F, rhs_rpg7_PG7V_mag

_AA = "rhs_weap_igla";
_AA_Ammo = "rhs_mag_9k38_rocket";

_Grenade = "HandGrenade";
_Grenade_Smoke = "SmokeShell";

//WEAPON ATTACHMENTS
_Attach = "acc_flashlight";
_Optic = "optic_mrco";

//BACKPACKS
_Backpack_Light = selectRandom ["B_TacticalPack_blk","B_Messenger_Black_F","B_Kitbag_cbr"];
_Backpack_Heavy = "B_Carryall_oli";
_Backpack_MAT = "B_Carryall_oli";




// VEHICLES ///////////////////////////////////////////////////////////////////////////////////////
//HELICOPTERS
_heli_transport = "rhsgref_cdf_b_reg_Mi8amt";
_heli_transport_camo = "";

_heli_attack = "rhsgref_cdf_b_reg_Mi17Sh";
_heli_attack_camo = "";

//VEHICLES
_tank =  "rhsgref_cdf_b_t80b_tv";
_tank_camo = "";

_apc = "rhsgref_cdf_b_btr70";
_apc_camo = "";

_car = "rhsgref_cdf_b_reg_uaz";
_car_camo = "";

_carArmed = selectRandom [ "rhsgref_cdf_b_reg_uaz_dshkm", "rhsgref_cdf_b_reg_uaz_dshkm"];
_carArmed_Camo = "";

_truck = selectRandom [ "rhsgref_cdf_b_gaz66", "rhsgref_cdf_b_ural"];
_truck_Camo = "";

// AMMO BLACKLIST: Removes magazines of these types for all vehicles spawned or placed in editor
_ammoBlacklist = [""];




// DEFINE AI UNITS ////////////////////////////////////////////////////////////////////////////////
// BLUFOR
_Officer = "B_officer_F";
_Squad_Leader = "B_Soldier_SL_F";
_Rifleman = "B_Soldier_F";
_Rifleman_AT = "B_Soldier_LAT_F";
_Grenadier = "B_Soldier_GL_F";
_Autorifleman = "B_Soldier_AR_F";
_MMG_Gunner = "B_support_MG_F";
_MAT_Gunner = "B_Soldier_AT_F";
_AA_Gunner = "B_soldier_AA_F";
_Vehicle_Crew = "B_crew_F";
_Heli_Pilot = "B_Helipilot_F";
_Marksman = "B_soldier_M_F";

//OPFOR
if (_spawnside == EAST) then {
	_Officer = "O_officer_F";
	_Squad_Leader = "O_Soldier_SL_F";
	_Rifleman = "O_Soldier_F";
	_Rifleman_AT = "O_Soldier_LAT_F";
	_Grenadier = "O_Soldier_GL_F";
	_Autorifleman = "O_Soldier_AR_F";
	_MMG_Gunner = "O_HeavyGunner_F";
	_MAT_Gunner = "O_Soldier_AT_F";
	_AA_Gunner = "O_Soldier_AA_F";
	_Vehicle_Crew = "O_crew_F";
	_Heli_Pilot = "O_helipilot_F";
	_Marksman = "O_soldier_M_F";
};

//INDEPENDENT
if (_spawnside == INDEPENDENT) then {
	_Officer = "I_C_Soldier_Camo_F";
	_Squad_Leader = "I_C_Soldier_Para_2_F";
	_Rifleman = "I_C_Soldier_Para_7_F";
	_Rifleman_AT = "I_C_Soldier_Para_5_F";
	_Grenadier = "I_C_Soldier_Para_6_F";
	_Autorifleman = "I_C_Soldier_Para_1_F";
	_MMG_Gunner = "I_C_Soldier_Para_4_F";
	_MAT_Gunner = "I_C_Soldier_Para_8_F";
	_AA_Gunner = "I_C_Soldier_Bandit_4_F";
	_Vehicle_Crew = "I_C_Soldier_Bandit_1_F";
	_Heli_Pilot = "I_C_Helipilot_F";
};