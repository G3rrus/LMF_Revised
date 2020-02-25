// PLAYER EQUIPMENT DEFINITIONS ///////////////////////////////////////////////////////////////////
/*
	- In this file you define player related gear components that are used in the players
	  custom gear.
	- The gear from this file also comes to use in player vehicles and supply crates defined
	  in cfg_Mission.sqf
	- If you don't use the custom gear component you can ingore this file.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
//RADIOS
private _Radio_B = "ACRE_PRC117F"; // Long Range Radio (Used by RTO and FAC if ACRE is used)
private _Radio_L = "ACRE_PRC148"; // Medium Range Radio (Used by Platoon, SQLs, TLs, etc)
private _Radio_R = "ACRE_PRC343"; // Short Range Radio (Used by Rifleman, Grenadier, etc)

//INFANTRY UNIFORM
private _Uniform = ["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_vest"]; // Uniform(s)
private _Vest = ["V_PlateCarrier1_rgr"]; // Vest(s)
private _Vest_G = ["V_PlateCarrierGL_rgr"]; // Vest(s) GL (FAC, SQL, TL, Grenadier)
private _Vest_M = ["V_PlateCarrierSpec_rgr"]; // Vest(s) CLS (Medic)
private _Vest_MG = ["V_PlateCarrier2_rgr"]; // Vest(s) MG (AR, MMG)
private _Headgear = ["H_HelmetSpecB","H_HelmetSpecB_blk","H_HelmetSpecB_paint2","H_HelmetSpecB_paint1","H_HelmetSpecB_sand","H_HelmetSpecB_snakeskin"]; // Headgear(s) (Rest)
private _Headgear_L = ["H_Beret_02"]; // Headgear(s) (PLT CMD, PLT SGT)
private _Headgear_A = ["H_HelmetSpecB","H_HelmetSpecB_blk","H_HelmetSpecB_paint2","H_HelmetSpecB_paint1","H_HelmetSpecB_sand","H_HelmetSpecB_snakeskin","H_Beret_02"]; // Headgear(s) (Available in Personal Arsenal)
private _Goggles = ["","G_Shades_Black",""]; // Goggle(s)
private _Goggles_A = ["G_Aviator","G_Combat","G_Tactical_Black","G_Shades_Black"]; // Goggle(s) (Available in Perosnal Arsenal)

//PILOT UNIFORM
private _Heli_Uniform = ["U_B_HeliPilotCoveralls"]; // Pilot Uniform(s)
private _Heli_Vest = ["V_TacVest_blk"]; // Pilot Vest(s)
private _Heli_Headgear = ["H_PilotHelmetHeli_B"]; // Pilot Headgear(s)
private _Heli_Headgear_C = ["H_CrewHelmetHeli_B"]; // Crew Headgear(s)

private _Plane_Uniform = ["U_B_PilotCoveralls"]; // Plane Uniform(s)
private _Plane_Vest = ["V_Rangemaster_belt"]; // Plane Vest(s)
private _Plane_Headgear = ["H_PilotHelmetFighter_B"]; // Plane Headgear(s)

//VEHICLE CREW UNIFORM
private _Crew_Uniform = ["U_B_CombatUniform_mcam_tshirt"]; // Crew Uniform(s)
private _Crew_Vest = ["V_BandollierB_rgr"]; // Crew Vest(s)
private _Crew_Headgear = ["H_HelmetCrew_B"]; // Crew Headgear(s)

//BACKPACKS
private _Backpack_Leader = ["B_TacticalPack_mcamo"]; // PltLead, PltSgt, Squad Leader Backpack(s)
private _Backpack_RTO = ["B_Carryall_mcamo"]; // RTO and FAC Backpack(s) (Radio Backpack if TFAR is used, otherwise Backpack for _Radio_B)
private _Backpack_Medic = ["B_Kitbag_mcamo"]; // Medic Backpack(s)
private _Backpack_Engineer = [""]; // Engineers Backpack(s)
private _Backpack_MAT = ["B_Carryall_mcamo"]; // MAT, MAT Assistant Backpack(s)
private _Backpack_AR_MMG = ["B_Carryall_mcamo"]; // AR/MMG, AR/MMG assistant Backpack(s)
private _Backpack_Bearer = ["B_Carryall_mcamo"]; // Ammo Bearer Backpack(s)
private _Backpack_Crew = ["B_AssaultPack_mcamo"]; // Vehicle crew Backpack(s)
private _Backpack_Pilot = ["B_AssaultPack_mcamo"]; // Pilots Backpack(s)
private _Backpack_Light = ["B_AssaultPack_mcamo"]; // Everyone else if given Backpack(s)

//FLARE GUN
private _FlareGun = "hgun_Pistol_Signal_F"; // Flaregun
private _FlareGun_Ammo = "6Rnd_RedSignal_F"; // Flaregun Ammo

//PISTOL
private _Pistol = "hgun_Pistol_heavy_01_F"; // Pistol
private _Pistol_Ammo = "11Rnd_45ACP_Mag"; // Pistol Ammo
private _Pistol_Attach1 = "acc_flashlight_pistol"; // Pistol Attachement #1
private _Pistol_Attach2 = "muzzle_snds_acp"; // Pistol Attachement #2

//SMG (Used by: Vehicle Crew, Helicopter Pilot)
private _SMG = "hgun_PDW2000_F"; // SMG
private _SMG_Ammo = "30Rnd_9x21_Mag"; // SMG Ammo
private _SMG_Optic = "optic_yorris"; // SMG Scope
private _SMG_Attach1 = ""; // SMG Attachement #1
private _SMG_Attach2 = "muzzle_snds_l"; // SMG Attachement #2
private _SMG_Bipod = ""; // SMG Bipod

//CARBINE (Used by: RTO, Medic, Engineer, MMG Assistant, MAT Gunner & Assistant)
private _Carbine = "arifle_MXC_F"; // Carbine
private _Carbine_Ammo = "30Rnd_65x39_caseless_mag"; // Carbine Ammo
private _Carbine_Ammo_T = "30Rnd_65x39_caseless_mag_Tracer"; // Carbine Tracer Ammo
private _Carbine_Optic = "optic_aco"; // Carbine Optic
private _Carbine_Attach1 = "acc_pointer_ir"; // Carbine Attachement #1
private _Carbine_Attach2 = "muzzle_snds_h"; // Carbine Attachement #2
private _Carbine_Bipod = ""; // Carbine Bipod

//RIFLE (Used by: Plt.Lead, Plt.Sgt, Rifleman, Ammo Bearer)
private _Rifle = "arifle_MX_F"; // Rifle
private _Rifle_Ammo = "30Rnd_65x39_caseless_mag"; // Rifle Ammo
private _Rifle_Ammo_T = "30Rnd_65x39_caseless_mag_Tracer"; // Rifle Tracer Ammo
private _Rifle_Optic = "optic_aco"; // Rifle Optic
private _Rifle_Attach1 = "acc_pointer_ir"; // Rifle Attachement #1
private _Rifle_Attach2 = "muzzle_snds_h"; // Rifle Attachement #2
private _Rifle_Bipod = ""; // Rifle Bipod

//RIFLE GL (Used by: Squad Leader, Squad 2iC, FAC, Grenadier)
private _Rifle_GL = "arifle_MX_GL_F"; // GL Rifle
private _Rifle_GL_Ammo = "30Rnd_65x39_caseless_mag"; // GL Rifle Ammo
private _Rifle_GL_Ammo_T = "30Rnd_65x39_caseless_mag_Tracer"; // GL Rifle Tracer Ammo
private _Rifle_GL_HE = "1Rnd_HE_Grenade_shell"; // GL 40mm HE
private _Rifle_GL_Flare = "UGL_FlareRed_F"; // GL 40mm Flare
private _Rifle_GL_Smoke_Grn = "1Rnd_SmokeGreen_Grenade_shell"; // GL 40mm Smoke Green
private _Rifle_GL_Smoke_Red = "1Rnd_SmokeRed_Grenade_shell"; // GL 40mm Smoke Red
private _Rifle_GL_Optic = "optic_aco"; // GL Rifle Optic
private _Rifle_GL_Attach1 = "acc_pointer_ir"; // GL Rifle Attachement #1
private _Rifle_GL_Attach2 = "muzzle_snds_h"; // GL Rifle Attachement #2
private _Rifle_GL_Bipod = ""; // GL Rifle Bipod

//DMR (Used by: Marksman)
private _DMR = "srifle_DMR_06_olive_F"; // DMR
private _DMR_Ammo = "20Rnd_762x51_Mag"; // DMR Ammo
private _DMR_Optic = "optic_dms"; // DMR Optic
private _DMR_Attach1 = ""; // DMR Attachement #1
private _DMR_Attach2 = "muzzle_snds_b"; // DMR Attachement #2
private _DMR_Bipod = ""; // DMR Bipod

//LIGHT MACHINE GUN
private _LMG = "arifle_MX_SW_F"; // LMG
private _LMG_Ammo = "100Rnd_65x39_caseless_mag"; // LMG Ammo
private _LMG_Ammo_T = "100Rnd_65x39_caseless_mag_Tracer"; // LMG Tracer Ammo
private _LMG_Optic = "optic_aco"; // LMG Optic
private _LMG_Attach1 = "acc_pointer_ir"; // LMG Attachement #1
private _LMG_Attach2 = "muzzle_snds_h"; // LMG Attachement #2
private _LMG_Bipod = "bipod_01_f_mtp"; // LMG Bipod

//MEDIUM MACHINE GUN
private _MMG = "MMG_02_sand_F"; // MMG
private _MMG_Ammo = "130Rnd_338_Mag"; // MMG Ammo
private _MMG_Optic = "optic_aco"; // MMG Optic
private _MMG_Attach1 = "acc_pointer_ir"; // MMG Attachement #1
private _MMG_Attach2 = "muzzle_snds_338_black"; // MMG Attachement #2
private _MMG_Bipod = ""; // MMG Bipod

//LIGHT ANTI-TANK
private _LAT = "launch_NLAW_F"; // LAT
private _LAT_Ammo = "NLAW_F"; // LAT Ammo

//MEDIUM ANTI-TANK
private _MAT = "launch_MRAWS_green_F"; // MAT
private _MAT_Ammo = "MRAWS_HEAT_F"; // MAT Ammo
private _MAT_Optic = ""; // MAT Optic

//GRENADES & EXPLOSIVES
private _Grenade = "MiniGrenade"; // HE Grenade
private _Grenade_Smoke = "SmokeShell"; // Smoke Grenade
private _Grenade_Smoke_Grn = "SmokeShellGreen"; // Smoke Grenade Green
private _Explosive_Large = "DemoCharge_Remote_Mag"; // Heavy Explosive
private _Explosive_Small = "SLAMDirectionalMine_Wire_Mag"; // Light Explosive

//MISC
private _Binocular = "Binocular"; // Binocular Item
private _NVG = "NVGoggles"; // NVG Item
private _NVG_Pilot = "NVGoggles"; // NVG Item for Pilots


//ROLE DEFINITIONS (DO NOT USE THE SAME CLASSNAME TWICE)
//PLATOON
private _PlatoonLeader = "B_officer_F"; // Platoon Leader
private _PlatoonSgt = "B_Soldier_F"; // Platoon Sergeant
private _RTO = "B_Competitor_F"; // RTO
private _FAC = "B_Soldier_unarmed_F"; // FAC

//SQUAD
private _SquadLeader = "B_Soldier_SL_F"; // Squad Leader
private _TeamLeader = "B_Soldier_TL_F"; // Team Leader
private _Rifleman = "B_soldier_LAT2_F"; // Rifleman
private _Grenadier = "B_Soldier_GL_F"; // Grenadier
private _Autorifleman = "B_soldier_AR_F"; // Autorifleman
private _Marksman = "B_soldier_M_F"; // Marksman
private _Medic = "B_medic_F"; // Medic
private _Engineer = "B_engineer_F"; // Engineer
private _MachineGunner = "B_HeavyGunner_F"; // Machine Gunner
private _MgAssistant = "B_soldier_AAR_F"; // Machine Gunner Assistant
private _AntiTankGunner = "B_soldier_AT_F"; // Anti Tank Gunner
private _AtAssistant = "B_soldier_AAT_F"; // Anti Tank Gunner Assistant
private _AmmoBearer = "B_Soldier_A_F"; // Ammo Bearer

//VEHICLE
private _Crew = "B_crew_F"; // Vehicle Crew

//AIR
private _HeloPilot = "B_Helipilot_F"; // Helicopter Pilot
private _HeloCrew = "B_helicrew_F"; // Helicopter Crew
private _Pilot = "B_Pilot_F"; // Pilot