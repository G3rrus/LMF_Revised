///////////////////////////////////////////////////////////////////////////////////////////////////
// AI DEFINITIONS /////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/*


DESCRIPTION

In this file you can define most AI related definitions such as:

 - Their Equipment
 - Their Vehicles (These vehicles will be used for spawning, futhermore they will be affected by other script components.)
 - Their Infantry (Defined Classnames will become special roles such as Grenadiers and AR Gunners)

Important Notes:
 
 1) All placed AI soldiers that do not fall under the defined classnames below (as long as they are from var_enemySide) will
	get a random Loadout (excluding AA)
 2) If you define several different weapons in the same category that use incompatible magazines, e.g.: _Rifle = ["Ak47", "M16"];
	leave the array for magazines empty!
 3) The Ammo Blacklist affects all vehicles defined in this file.
 4) The Camos can obviously only be applied if they exist for said vehicle, which means if you define multiple trucks and only
	one of them has a black camouflage, then it will not work for the trucks that don't have it


*/
// CLOTHING ///////////////////////////////////////////////////////////////////////////////////////
private _Uniform = [""]; // Uniform(s)
private _Vest = [""]; // Vest(s)
private _Backpack_Light = [""]; // Backpack(s)
private _Backpack_Heavy = [""]; // Backpack(s) used for AR and MMG
private _Backpack_MAT = [""]; // Backpack(s) used for MAT and AA
private _Headgear = [""]; // Headgear(s)
private _Goggles = [""]; // Facewear(s)

//HELICOPTER CREW AND PILOTS
private _Heli_Uniform = [""]; // Same as Uniform(s) but for Pilots
private _Heli_Vest = [""]; // Same as Vest(s) but for Pilots
private _Heli_Headgear = [""]; // Same as Headgear(s) but for Pilots

//VEHICLE CREW
private _Crew_Uniform = [""]; // Same as Uniform(s) but for Pilots
private _Crew_Vest = [""]; // Same as Vest(s) but for Pilots
private _Crew_Headgear = [""]; // Same as Headgear(s) but for Pilots



// WEAPONS ////////////////////////////////////////////////////////////////////////////////////////
private _Pistol = [""]; // Pistol(s)
private _Pistol_Ammo = [""]; // Pistol Magazine(s)

private _Carbine = [""]; // Carbine(s)
private _Carbine_Ammo = [""]; // Carbine Magazine(s)

private _Rifle = [""]; // Rifle(s)
private _Rifle_Ammo = [""]; // Rifle Magazine(s)

private _Rifle_GL = [""]; // Rifle(s) with Underslungs
private _Rifle_GL_Ammo = [""]; // Rifle Magazine(s)
private _Rifle_GL_Smoke = [""]; // Underslung Smoke(s)
private _Rifle_GL_Flare = [""]; // Underslung Flare(s)

private _DMR = [""]; // Designated Marksman Rifle(s)
private _DMR_Ammo = [""]; // DNR Magazine(s)

private _LMG = [""]; // Light Machine Gun(s)
private _LMG_Ammo = [""]; // LMG Magazine(s)

private _MMG = [""]; // Medium Machine Gun(s)
private _MMG_Ammo = [""]; // MMG Magazine(s)

private _LAT = [""]; // Light Anti-Tank(s)
private _LAT_Ammo = [""]; // LAT Magazine(s)

private _MAT = [""]; // Medium Anti-Tank(s)
private _MAT_Ammo = [""]; // MAT Magazine(s)

private _AA = [""]; // Anti-Air(s)
private _AA_Ammo = [""]; // AA Magazine(s)

private _Grenade = [""]; // HE Grenade(s)
private _Grenade_Smoke = [""]; // Smoke Grenade(s)

private _Attach = [""]; // Weapon Attachement(s)
private _Optic = [""]; // Weapon Optic(s)



// VEHICLES ///////////////////////////////////////////////////////////////////////////////////////
private _car = [""]; // Car(s)
private _carArmed = [""]; // Armed Car(s)
private _truck = [""]; // Truck(s)
private _apc = [""]; // APC(s)
private _tank = [""]; // Tank(s)
private _heli_transport = [""]; // Transport Helo(s)
private _heli_attack = [""]; // Attack Helo(s)
private _plane = [""]; // Plane(s)


//CAMOS: Applied to all defined vehicles that are spawned.
private _car_camo = [""]; // camo(s) for car(s)
private _carArmed_Camo = [""]; // camo(s) for armed car(s)
private _truck_Camo = [""]; // camo(s) for truck(s)
private _apc_camo = [""]; // camos(s) for apc(s)
private _tank_camo = [""]; // camo(s) for tank(s)
private _heli_transport_camo = [""]; // camo(s) for helo(s)
private _heli_attack_camo = [""]; // camo(s) for attack helo(s)
private _plane_camo = [""]; // camo(s) for plane(s)

//AMMO BLACKLIST
private _ammoBlacklist = [""];



// DEFINE AI UNITS ////////////////////////////////////////////////////////////////////////////////
// BLUFOR
private _Autorifleman = "B_Soldier_AR_F";
private _Crew = "B_crew_F";
private _Grenadier = "B_Soldier_GL_F";
private _MMG_Gunner = "B_HeavyGunner_F";
private _Marksman = "B_soldier_M_F";
private _AA_Gunner = "B_soldier_AA_F";
private _MAT_Gunner = "B_Soldier_AT_F";
private _Officer = "B_officer_F";
private _Pilot = "B_Helipilot_F";
private _Rifleman = "B_Soldier_F";
private _Rifleman_AT = "B_Soldier_LAT_F";
private _Squad_Leader = "B_Soldier_SL_F";

//OPFOR
if (var_enemySide == EAST) then {
	private _Autorifleman = "O_Soldier_AR_F";
	private _Crew = "O_crew_F";
	private _Grenadier = "O_Soldier_GL_F";
	private _MMG_Gunner = "O_HeavyGunner_F";
	private _Marksman = "O_soldier_M_F";
	private _AA_Gunner = "O_Soldier_AA_F";
	private _MAT_Gunner = "O_Soldier_AT_F";
	private _Officer = "O_officer_F";
	private _Pilot = "O_helipilot_F";
	private _Rifleman = "O_Soldier_F";
	private _Rifleman_AT = "O_Soldier_LAT_F";
	private _Squad_Leader = "O_Soldier_SL_F";
};

//INDEPENDENT
if (var_enemySide == INDEPENDENT) then {
	private _Autorifleman = "I_Soldier_AR_F";
	private _Crew = "I_crew_F";
	private _Grenadier = "I_Soldier_GL_F";
	private _MMG_Gunner = "I_support_MG_F";
	private _Marksman = "I_Soldier_M_F";
	private _AA_Gunner = "I_Soldier_AA_F";
	private _MAT_Gunner = "I_Soldier_AT_F";
	private _Officer = "I_officer_F";
	private _Pilot = "I_helipilot_F";
	private _Rifleman = "I_soldier_F";
	private _Rifleman_AT = "I_Soldier_LAT_F";
	private _Squad_Leader = "I_Soldier_SL_F";
};