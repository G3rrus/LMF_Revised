///////////////////////////////////////////////////////////////////////////////////////////////////
// PLAYER EQUIPMENT DEFINITIONS ///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/*


DESCRIPTION

In this file you can define most Player related definitions such as:

 - Their Equipment

Important Notes:

 1) When it comes to Weapons, Magazines, Grenades, NVGs or Binoculars only 1 (always the first option defined) will be chosen.
 2) If you know what you're doing and you want to change things in 1) to be randomly chosen instead
 	you can do so in "framework\player\fn_initPlayerGear.sqf".
 3) These components are also important for the in "settings\cfg_Mission.sqf" defined player vehicles/supplies.


*/
// RADIOS /////////////////////////////////////////////////////////////////////////////////////////
private _ACRE_MMR = "ACRE_PRC117F";
private _ACRE_ITR = "ACRE_PRC148";
private _ACRE_PRR = "ACRE_PRC343";

//INFANTRY UNIFORM
private _Uniform = ["U_B_CombatUniform_mcam", "U_B_CombatUniform_mcam_vest"];
private _Vest = ["V_PlateCarrier2_rgr"];
private _Headgear = ["H_HelmetSpecB", "H_HelmetSpecB_blk", "H_HelmetSpecB_paint2", "H_HelmetSpecB_paint1", "H_HelmetSpecB_sand", "H_HelmetSpecB_snakeskin"];
private _Goggles = ["G_Combat", "", "G_Tactical_Clear", "", "G_Tactical_Black", ""];

//PILOT UNIFORM
private _Heli_Uniform = ["U_B_HeliPilotCoveralls"];
private _Heli_Vest = ["V_TacVest_blk"];
private _Heli_Headgear = ["H_PilotHelmetHeli_B"];
private _Heli_Goggles = ["G_Aviator"];

private _Plane_Uniform = ["U_B_PilotCoveralls"];
private _Plane_Vest = ["V_Rangemaster_belt"];
private _Plane_Headgear = ["H_PilotHelmetFighter_B"];
private _Plane_Goggles = [""];

//VEHICLE CREW UNIFORM
private _Crew_Uniform = ["U_B_CombatUniform_mcam_tshirt"];
private _Crew_Vest = ["V_BandollierB_rgr"];
private	_Crew_Headgear = ["H_HelmetCrew_B"];
private _Crew_Goggles = ["G_Lowprofile"];

//BACKPACKS
private _Backpack_Leader = ["B_TacticalPack_mcamo"]; // PltLead, PltSgt, Squad Leader
private _Backpack_RTO = ["B_Carryall_mcamo"]; // RTO, FAC
private _Backpack_Medic = ["B_Kitbag_mcamo"]; // Medic
private _Backpack_MAT = ["B_Carryall_mcamo"]; // MAT, MAT Assistant
private _Backpack_AR_MMG = ["B_Carryall_mcamo"]; // AR/MMG, AR/MMG assistant
private _Backpack_Crew = ["B_AssaultPack_mcamo"]; // Vehicle crew
private _Backpack_Pilot = ["B_AssaultPack_mcamo"]; // Pilots
private _Backpack_Light = ["B_AssaultPack_mcamo"]; // Everyone else if given backpack

//FLARE GUN
private _FlareGun = ["hgun_Pistol_Signal_F"];
private _FlareGun_Ammo = ["6Rnd_RedSignal_F"];

//PISTOL
private _Pistol = ["hgun_P07_F"];
private _Pistol_Ammo = ["16Rnd_9x21_Mag"];

//SMG (Used by: Vehicle Crew, Helicopter Pilot)
private _SMG = ["hgun_PDW2000_F"];
private _SMG_Ammo = ["30Rnd_9x21_Mag"];
private _SMG_Optic = [""];
private _SMG_Attach1 = [""];
private _SMG_Attach2 = [""];

//CARBINE (Used by: RTO, Medic, MMG Assistant, MAT Gunner & Assistant)
private _Carbine = ["arifle_MXC_F"];
private _Carbine_Ammo = ["30Rnd_65x39_caseless_mag"];
private _Carbine_Ammo_T = ["30Rnd_65x39_caseless_mag_Tracer"];
private _Carbine_Optic = ["optic_aco"];
private _Carbine_Attach1 = ["acc_pointer_ir"];
private _Carbine_Attach2 = ["muzzle_snds_h"];

//RIFLE (Used by: Plt.Lead, Plt.Sgt, Rifleman)
private _Rifle = ["arifle_MX_F"];
private _Rifle_Ammo = ["30Rnd_65x39_caseless_mag"];
private _Rifle_Ammo_T = ["30Rnd_65x39_caseless_mag_Tracer"];
private _Rifle_Optic = ["optic_aco"];
private _Rifle_Attach1 = ["acc_pointer_ir"];
private _Rifle_Attach2 = ["muzzle_snds_h"];

//RIFLE GL (Used by: Squad Leader, Squad 2iC, FAC, Grenadier)
private _Rifle_GL = ["arifle_MX_GL_F"];
private _Rifle_GL_Ammo = ["30Rnd_65x39_caseless_mag"];
private _Rifle_GL_Ammo_T = ["30Rnd_65x39_caseless_mag_Tracer"];
private _Rifle_GL_HE = ["1Rnd_HE_Grenade_shell"];
private _Rifle_GL_Flare = ["UGL_FlareRed_F"];
private _Rifle_GL_Smoke_Grn = ["1Rnd_SmokeGreen_Grenade_shell"];
private _Rifle_GL_Smoke_Red = ["1Rnd_SmokeRed_Grenade_shell"];
private _Rifle_GL_Optic = ["optic_aco"];
private _Rifle_GL_Attach1 = ["acc_pointer_ir"];
private _Rifle_GL_Attach2 = ["muzzle_snds_h"];

//LIGHT MACHINE GUN
private _LMG = ["arifle_MX_SW_F"];
private _LMG_Ammo = ["100Rnd_65x39_caseless_mag"];
private _LMG_Ammo_T = ["100Rnd_65x39_caseless_mag_Tracer"];
private _LMG_Optic = ["optic_aco"];
private _LMG_Attach1 = ["acc_pointer_ir"];
private _LMG_Attach2 = ["muzzle_snds_h"];

//MEDIUM MACHINE GUN
private _MMG = ["MMG_02_sand_F"];
private _MMG_Ammo = ["130Rnd_338_Mag"];
private _MMG_Optic = ["optic_aco"];
private _MMG_Attach1 = ["acc_pointer_ir"];
private _MMG_Attach2 = ["muzzle_snds_338_black"];

//LIGHT ANTI-TANK
private _LAT = ["launch_NLAW_F"];
private _LAT_Ammo = [""];

//MEDIUM ANTI-TANK
private _MAT = ["launch_MRAWS_green_F"];
private _MAT_Ammo = ["MRAWS_HEAT_F"];
private _MAT_Optic = [""];

//GRENADES
private _Grenade = ["MiniGrenade"];
private _Grenade_Smoke = ["SmokeShell"];

//MISC
private _Binocular = ["Binocular"];
private _NVG = ["NVGoggles"];
private _NVG_Pilot = ["NVGoggles"];