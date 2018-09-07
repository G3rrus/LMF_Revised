///////////////////////////////////////////////////////////////////////////////////////////////////
// PLAYER EQUIPMENT SETTINGS //////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
a2k_personalRadio = "ALL"; // "ALL" or "NONE" (AN/PRC 343)
a2k_backpacksAll = false; // Give ALL players backpacks? (Certain roles will have backpacks regardless)
a2k_NVG = "NONE"; // "ALL", "PILOTS" or "NONE" (Night Vision Goggles)
a2k_pistolsAll = false; // GIVE ALL PLAYERS PISTOLS? (Certain roles will have a pistol regardless)
a2k_maps = "ALL"; // "ALL", "LEADERS" or "NONE" (ItemMap)


//RADIOS
_ACRE_MMR = "ACRE_PRC117F";
_ACRE_ITR = "ACRE_PRC148";
_ACRE_PRR = "ACRE_PRC343";

//INFANTRY UNIFORM
_Headgear = ["H_HelmetO_ocamo"];
_Headgear_L = ["H_HelmetLeaderO_ocamo"];
_Headgear_O = ["H_Beret_ocamo"];
_Uniform = ["U_O_CombatUniform_ocamo"];
_Uniform_O = ["U_O_OfficerUniform_ocamo"];
_Vest = ["V_TacVest_khk", "V_HarnessOGL_brn", "V_Chestrig_khk", "V_HarnessO_brn"];
_Vest_O = ["V_BandollierB_khk"];
_Goggles = [""];

//PILOT UNIFORM
_Heli_Headgear = ["H_PilotHelmetHeli_O"];
_Heli_Uniform = ["U_O_PilotCoveralls"];
_Heli_Vest = [""];
_Heli_Goggles = [""];

_Plane_Headgear = [""];
_Plane_Uniform = [""];
_Plane_Vest = [""];
_Plane_Goggles = [""];

//VEHICLE CREW UNIFORM
_Crew_Headgear = [""];
_Crew_Uniform = [""];
_Crew_Vest = [""];
_Crew_Goggles = [""];

//BACKPACKS
_Backpack_Leader = ["B_AssaultPack_ocamo"]; //PltLead, PltSgt, Squad Leader
_Backpack_RTO = ["B_FieldPack_ocamo"]; //RTO, FAC
_Backpack_Medic = ["B_FieldPack_ocamo"]; //Medic
_Backpack_MAT = ["B_FieldPack_ocamo"]; //MAT, MAT Assistant
_Backpack_AR_MMG = ["B_FieldPack_cbr" , "B_Carryall_ocamo"]; // AR/MMG, AR/MMG assistant
_Backpack_Crew = ["B_TacticalPack_ocamo"]; //Vehicle crew
_Backpack_Pilot = ["B_TacticalPack_ocamo"]; //Pilots
_Backpack_Light = ["B_AssaultPack_ocamo"]; // Everyone else if given backpack

//FLARE GUN
_FlareGun = ["hgun_Pistol_Signal_F"];
_FlareGun_Ammo = ["6Rnd_RedSignal_F","6Rnd_GreenSignal_F"];

//PISTOL
_Pistol = ["hgun_Rook40_F"];
_Pistol_Ammo = ["16Rnd_9x21_Mag"];

//SMG (Used by: Vehicle Crew, Helicopter Pilot)
_SMG = ["SMG_02_F"];
_SMG_Ammo = ["30Rnd_9x21_Mag_SMG_02_Tracer_Green"];
_SMG_Ammo_T = [""];
_SMG_Optic = [""];
_SMG_Attach1 = [""];
_SMG_Attach2 = [""];

//CARBINE (Used by: RTO, Medic, MMG Assistant, MAT Gunner & Assistant)
_Carbine = ["arifle_Katiba_C_F"];
_Carbine_Ammo = ["30Rnd_65x39_caseless_green"];
_Carbine_Ammo_T = ["30Rnd_65x39_caseless_green_mag_Tracer"];
_Carbine_Optic = ["optic_aco_grn"];
_Carbine_Attach1 = ["acc_pointer_ir"];
_Carbine_Attach2 = [""];

//RIFLE (Used by: Plt.Lead, Plt.Sgt, Rifleman)
_Rifle = ["arifle_Katiba_F"];
_Rifle_Ammo = ["30Rnd_65x39_caseless_green"];
_Rifle_Ammo_T = ["30Rnd_65x39_caseless_green_mag_Tracer"];
_Rifle_Optic = ["optic_aco_grn"];
_Rifle_Attach1 = ["acc_pointer_ir"];
_Rifle_Attach2 = [""];

//RIFLE GL (Used by: Squad Leader, Squad 2iC, FAC, Grenadier)
_Rifle_GL = ["arifle_Katiba_GL_F"];
_Rifle_GL_Ammo = ["30Rnd_65x39_caseless_green"];
_Rifle_GL_Ammo_T = ["30Rnd_65x39_caseless_green_mag_Tracer"];
_Rifle_GL_HE = ["1Rnd_HE_Grenade_shell"];
_Rifle_GL_Smoke = ["1Rnd_Smoke_Grenade_shell"];
_Rifle_GL_Smoke_Grn = ["1Rnd_SmokeGreen_Grenade_shell"];
_Rifle_GL_Flare = ["1Rnd_SmokeRed_Grenade_shell"];
_Rifle_GL_Optic = ["optic_arco_blk_f"];
_Rifle_GL_Attach1 = ["acc_pointer_ir"];
_Rifle_GL_Attach2 = [""];

//LIGHT MACHINE GUN
_LMG = [""];
_LMG_Ammo = [""];
_LMG_Ammo_T = [""];
_LMG_Optic = [""];
_LMG_Attach1 = [""];
_LMG_Attach2 = [""];

//MEDIUM MACHINE GUN
_MMG = ["MMG_01_hex_F"];
_MMG_Ammo = ["150Rnd_93x64_Mag"];
_MMG_Ammo_T = ["150Rnd_93x64_Mag"];
_MMG_Optic = ["optic_arco_blk_f"];
_MMG_Attach1 = ["acc_pointer_ir"];
_MMG_Attach2 = ["bipod_02_f_hex"];

//LIGHT ANTI-TANK
_LAT = ["launch_RPG32_F"];
_LAT_Ammo = ["RPG32_HE_F"];
_LAT_Ammo_HE = [""];

//MEDIUM ANTI-TANK
_MAT = ["launch_O_Vorona_brown_F"];
_MAT_Ammo = ["Vorona_HEAT"];
_MAT_Ammo_HE = [""];
_MAT_Optic = [""];

//GRENADES
_Grenade = ["MiniGrenade"];
_Grenade_Smoke = ["SmokeShell", "SmokeShellGreen"];

//MISC
_Binocular = ["ACE_Vector"];
_NVG = ["NVGoggles_OPFOR"];
_NVG_Pilot = ["NVGoggles_OPFOR"];


// VEHICLES
//GROUND
_veh1 = "";
_veh2 = "";
_veh3 = "";
_veh4 = "";

//AIR
_heli1 = "O_Heli_Light_02_dynamicLoadout_F";
_heli2 = "";
_heli3 = "";
_heli4 = "";