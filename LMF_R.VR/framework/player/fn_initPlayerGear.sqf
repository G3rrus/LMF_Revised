// PLAYER GEAR SCRIPT /////////////////////////////////////////////////////////////////////////////
/*
	- This file handles the players custom loadout component.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(hasinterface) exitWith {};
params [["_unit", objNull]];
if !(local _unit) exitWith {};

private _role = roleDescription _unit;
if (count _this > 1) then {_role = _this select 1;};
if (_role == "") then {_role = "Rifleman";};


#include "..\..\settings\cfg_Player.sqf"


// REMOVE /////////////////////////////////////////////////////////////////////////////////////////
removeAllItems _unit;
removeAllAssignedItems _unit;
removeAllWeapons _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeUniform _unit;
removeVest _unit;
removeGoggles _unit;


// APPLY NEW ROLE SPECIFIC STUFF //////////////////////////////////////////////////////////////////
//PLT LEADER
if (_role find "Platoon Leader" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Rifle,_Rifle_Attach1,_Rifle_Attach2,_Rifle_Optic,[],[],_Rifle_Bipod],
			[],
			[_Pistol,_Pistol_Attach1,_Pistol_Attach2,"",[],[],""],
			[(selectRandom _Uniform_L),[]],
			[(selectRandom _Vest),[[_Rifle_Ammo,5,999],[_Rifle_Ammo_T,3,999],[_Pistol_Ammo,3,99],[_Grenade,2,1],[_Grenade_Smoke,1,1],[_Grenade_Smoke_Grn,2,1]]],
			[(selectRandom _Backpack_Leader),[[_ACRE_ITR,1]]],(selectRandom _Headgear_L),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps != 2) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "LIEUTENANT";
};

//PLT SGT
if (_role find "Platoon Sergeant" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Rifle,_Rifle_Attach1,_Rifle_Attach2,_Rifle_Optic,[],[],_Rifle_Bipod],
			[],
			[_Pistol,_Pistol_Attach1,_Pistol_Attach2,"",[],[],""],
			[(selectRandom _Uniform_L),[]],
			[(selectRandom _Vest),[[_Rifle_Ammo,5,999],[_Rifle_Ammo_T,3,999],[_Pistol_Ammo,3,99],[_Grenade,2,1],[_Grenade_Smoke,1,1],[_Grenade_Smoke_Grn,2,1]]],
			[(selectRandom _Backpack_Leader),[[_ACRE_ITR,1]]],(selectRandom _Headgear_L),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps != 2) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "SERGEANT";
};

//RTO
if (_role find "RTO" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Carbine,_Carbine_Attach1,_Carbine_Attach2,_Carbine_Optic,[],[],_Carbine_Bipod],
			[],
			[],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_Carbine_Ammo,5,999],[_Carbine_Ammo_T,3,999],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[(selectRandom _Backpack_RTO),[[_ACRE_ITR,1],[_ACRE_MMR,1]]],(selectRandom _Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//FAC
if (_role find "FAC" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Rifle_GL,_Rifle_GL_Attach1,_Rifle_GL_Attach2,_Rifle_GL_Optic,[],[],_Rifle_GL_Bipod],
			[],
			[],
			[(selectRandom _Uniform),[]],
			[selectRandom _Vest,[[_Rifle_GL_Ammo,5,999],[_Rifle_GL_Ammo_T,3,999],[_Rifle_GL_Smoke_Grn,2,99],[_Rifle_GL_Smoke_Red,4,99],[_Rifle_GL_Flare,2,99],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[(selectRandom _Backpack_RTO),[[_ACRE_ITR,1],[_ACRE_MMR,1]]],(selectRandom _Headgear),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps != 2) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "CORPORAL";
};

//SQL
if (_role find "Squad Leader" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Rifle_GL,_Rifle_GL_Attach1,_Rifle_GL_Attach2,_Rifle_GL_Optic,[],[],_Rifle_GL_Bipod],
			[],
			[],
			[(selectRandom _Uniform_L),[]],
			[selectRandom _Vest,[[_Rifle_GL_Ammo,5,999],[_Rifle_GL_Ammo_T,3,999],[_Rifle_GL_HE,5,99],[_Rifle_GL_Flare,5,99],[_Grenade,2,1],[_Grenade_Smoke,1,1],[_Grenade_Smoke_Grn,2,1]]],
			[(selectRandom _Backpack_Leader),[[_ACRE_ITR,1]]],(selectRandom _Headgear_L),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps != 2) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "SERGEANT";
};

//SQD 2IC
if (_role find "Squad 2iC" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Rifle_GL,_Rifle_GL_Attach1,_Rifle_GL_Attach2,_Rifle_GL_Optic,[],[],_Rifle_GL_Bipod],
			[],
			[],
			[(selectRandom _Uniform),[]],
			[selectRandom _Vest,[[_Rifle_GL_Ammo,5,999],[_Rifle_GL_Ammo_T,3,999],[_Rifle_GL_HE,5,99],[_Rifle_GL_Flare,5,99],[_Grenade,2,1],[_Grenade_Smoke,1,1],[_Grenade_Smoke_Grn,2,1]]],
			[(selectRandom _Backpack_Light),[]],(selectRandom _Headgear),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps != 2) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "CORPORAL";
};

//RIFLEMAN
if (_role find "Rifleman" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Rifle,_Rifle_Attach1,_Rifle_Attach2,_Rifle_Optic,[],[],_Rifle_Bipod],
			[_LAT,"","","",[_LAT_Ammo,99],[],""],
			[],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_Rifle_Ammo,5,999],[_Rifle_Ammo_T,3,999],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[],(selectRandom _Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//GL
if (_role find "Grenadier" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Rifle_GL,_Rifle_GL_Attach1,_Rifle_GL_Attach2,_Rifle_GL_Optic,[],[],_Rifle_GL_Bipod],
			[],
			[],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_Rifle_GL_Ammo,5,999],[_Rifle_GL_Ammo_T,3,999],[_Rifle_GL_HE,8,99],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[],(selectRandom _Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//AR
if (_role find "Autorifleman" >= 0) then {
	_unit setUnitLoadout [
		[
			[_LMG,_LMG_Attach1,_LMG_Attach2,_LMG_Optic,[],[],_LMG_Bipod],
			[],
			[],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_LMG_Ammo,2,999],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[(selectRandom _Backpack_AR_MMG),[[_LMG_Ammo,2,999],[_LMG_Ammo_T,2,999]]],(selectRandom _Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//MEDIC
if (_role find "Medic" >= 0) then {
	private _bContentMedic = [(selectRandom _Backpack_Medic),[["ACE_elasticBandage",30],["ACE_packingBandage",30],["ACE_salineIV",10],["ACE_epinephrine",10],["ACE_morphine",10],["ACE_personalAidKit",1]]];
	if (ace_medical_level == 1) then {
		_bContentMedic = [(selectRandom _Backpack_Medic),[["ACE_fieldDressing",60],["ACE_bloodIV",15],["ACE_epinephrine",10],["ACE_morphine",20]]];
	};
	_unit setUnitLoadout [
		[
			[_Carbine,_Carbine_Attach1,_Carbine_Attach2,_Carbine_Optic,[],[],_Carbine_Bipod],
			[],
			[],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_Carbine_Ammo,5,999],[_Carbine_Ammo_T,3,999],[_Grenade,2,1],[_Grenade_Smoke,6,1]]],
			_bContentMedic,(selectRandom _Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "CORPORAL";
};

//MG
if (_role find "Machine Gunner" >= 0 && {_role find "Assistant" == -1}) then {
	_unit setUnitLoadout [
		[
			[_MMG,_MMG_Attach1,_MMG_Attach2,_MMG_Optic,[],[],_MMG_Bipod],
			[],
			[_Pistol,_Pistol_Attach1,_Pistol_Attach2,"",[],[],""],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_MMG_Ammo,2,999],[_Pistol_Ammo,3,99],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[(selectRandom _Backpack_AR_MMG),[[_MMG_Ammo,4,999]]],(selectRandom _Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//MGA
if (_role find "Assistant Machine Gunner" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Carbine,_Carbine_Attach1,_Carbine_Attach2,_Carbine_Optic,[],[],_Carbine_Bipod],
			[],
			[],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_Carbine_Ammo,5,999],[_Carbine_Ammo_T,3,999],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[(selectRandom _Backpack_AR_MMG),[[_MMG_Ammo,3,999],["ACE_SpareBarrel",1,1]]],(selectRandom _Headgear),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//MAT
if (_role find "AT Gunner" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Carbine,_Carbine_Attach1,_Carbine_Attach2,_Carbine_Optic,[],[],_Carbine_Bipod],
			[_MAT,"","",_MAT_Optic,[_MAT_Ammo,99],[],""],
			[],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_Carbine_Ammo,5,999],[_Carbine_Ammo_T,3,999],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[(selectRandom _Backpack_MAT),[[_MAT_Ammo,2,99]]],(selectRandom _Headgear),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//MATA
if (_role find "AT Assistant" >= 0) then {
	_unit setUnitLoadout [
		[
			[_Carbine,_Carbine_Attach1,_Carbine_Attach2,_Carbine_Optic,[],[],_Carbine_Bipod],
			[],
			[],
			[(selectRandom _Uniform),[]],
			[(selectRandom _Vest),[[_Carbine_Ammo,5,999],[_Carbine_Ammo_T,3,999],[_Grenade,2,1],[_Grenade_Smoke,1,1]]],
			[(selectRandom _Backpack_MAT),[[_MAT_Ammo,2,99]]],(selectRandom _Headgear),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//VIC PLAT LEAD
if (_role find "Vehicle Platoon Commander" >= 0) then {
	_unit setUnitLoadout [
		[
			[_SMG,_SMG_Attach1,_SMG_Attach2,_SMG_Optic,[],[],_SMG_Bipod],
			[],
			[],
			[(selectRandom _Crew_Uniform),[]],
			[(selectRandom _Crew_Vest),[[_SMG_Ammo,5,999]]],
			[(selectRandom _Backpack_Crew),[[_ACRE_ITR,1]]],(selectRandom _Crew_Headgear),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps != 2) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "LIEUTENANT";
};

//VIC PLAT SGT
if (_role find "Vehicle Platoon 2iC" >= 0) then {
	_unit setUnitLoadout [
		[
			[_SMG,_SMG_Attach1,_SMG_Attach2,_SMG_Optic,[],[],_SMG_Bipod],
			[],
			[],
			[(selectRandom _Crew_Uniform),[]],
			[(selectRandom _Crew_Vest),[[_SMG_Ammo,5,999]]],
			[(selectRandom _Backpack_Crew),[[_ACRE_ITR,1]]],(selectRandom _Crew_Headgear),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps != 2) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "SERGEANT";
};

//VIC CMD
if (_role find "Vehicle Commander" >= 0 && {_role find "Platoon" == -1}) then {
	_unit setUnitLoadout [
		[
			[_SMG,_SMG_Attach1,_SMG_Attach2,_SMG_Optic,[],[],_SMG_Bipod],
			[],
			[],
			[(selectRandom _Crew_Uniform),[]],
			[(selectRandom _Crew_Vest),[[_SMG_Ammo,5,999]]],
			[(selectRandom _Backpack_Crew),[[_ACRE_ITR,1]]],(selectRandom _Crew_Headgear),(selectRandom _Goggles),
			[_Binocular,"","","",[],[],""],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps != 2) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "SERGEANT";
};

//VIC GUNNER
if (_role find "Vehicle Gunner" >= 0) then {
	_unit setUnitLoadout [
		[
			[_SMG,_SMG_Attach1,_SMG_Attach2,_SMG_Optic,[],[],_SMG_Bipod],
			[],
			[],
			[(selectRandom _Crew_Uniform),[]],
			[(selectRandom _Crew_Vest),[[_SMG_Ammo,5,999]]],
			[(selectRandom _Backpack_Crew),[[_ACRE_ITR,1]]],(selectRandom _Crew_Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//VIC DRIVER
if (_role find "Vehicle Driver" >= 0) then {
	_unit setUnitLoadout [
		[
			[_SMG,_SMG_Attach1,_SMG_Attach2,_SMG_Optic,[],[],_SMG_Bipod],
			[],
			[],
			[(selectRandom _Crew_Uniform),[]],
			[(selectRandom _Crew_Vest),[[_SMG_Ammo,5,999]]],
			[(selectRandom _Backpack_Crew),[[_ACRE_ITR,1]]],(selectRandom _Crew_Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "PRIVATE";
};

//HELI
if (_role find "Helicopter Pilot" >= 0 || {_role find "Helicopter Co-Pilot" >= 0}) then {
	_unit setUnitLoadout [
		[
			[_SMG,_SMG_Attach1,_SMG_Attach2,_SMG_Optic,[],[],_SMG_Bipod],
			[],
			[],
			[(selectRandom _Heli_Uniform),[["ACE_Flashlight_XL50",1]]],
			[(selectRandom _Heli_Vest),[[_SMG_Ammo,5,999],[_FlareGun_Ammo,4,99]]],
			[(selectRandom _Backpack_Pilot),[[_ACRE_ITR,1],[[_FlareGun,"","","",[],[],""],1]]],(selectRandom _Heli_Headgear),(selectRandom _Goggles),
			[],
			["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]
		],true
	];
	if (var_playerNVG != 2) then {_unit linkItem _NVG_Pilot};
	_unit setRank "LIEUTENANT";
};

//HELI CREW
if (_role find "Helicopter Crew" >= 0) then {
	_unit setUnitLoadout [
		[
			[_SMG,_SMG_Attach1,_SMG_Attach2,_SMG_Optic,[],[],_SMG_Bipod],
			[],
			[],
			[(selectRandom _Heli_Uniform),[]],
			[(selectRandom _Heli_Vest),[[_SMG_Ammo,5,999],[_FlareGun_Ammo,4,99]]],
			[(selectRandom _Backpack_Pilot),[[_ACRE_ITR,1],[[_FlareGun,"","","",[],[],""],1]]],(selectRandom _Heli_Headgear),(selectRandom _Goggles),
			[],
			["","","ItemRadioAcreFlagged","","ItemWatch",""]
		],true
	];
	if (var_playerMaps == 0) then {
		_unit linkItem "ItemMap";
		_unit linkItem "ItemCompass";
		_unit addItem "ACE_Flashlight_XL50";
	};
	_unit setRank "SERGEANT";
};

//PLANE
if (_role find "Fighter Pilot" >= 0) then {
	_unit setUnitLoadout [
		[
			[],
			[],
			[_Pistol,_Pistol_Attach1,_Pistol_Attach2,"",[],[],""],
			[(selectRandom _Plane_Uniform),[["ACE_Flashlight_XL50",1]]],
			[(selectRandom _Plane_Vest),[[_Pistol_Ammo,3,999],[_FlareGun_Ammo,4,99]]],
			[(selectRandom _Backpack_Pilot),[[_ACRE_ITR,1],[[_FlareGun,"","","",[],[],""],1]]],(selectRandom _Plane_Headgear),(selectRandom _Goggles),
			[],
			["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]
		],true
	];
	if (var_playerNVG != 2) then {_unit linkItem _NVG_Pilot};
	_unit setRank "CAPTAIN";
};


/// ADD MISC //////////////////////////////////////////////////////////////////////////////////////
//BACKPACKS
if (var_backpacksAll) then {
	if (isNull (unitBackpack _unit)) then {
		_unit addBackpack selectRandom _Backpack_Light; clearAllItemsFromBackpack _unit;
	};
};

//NVG
if (var_playerNVG == 0) then {_unit linkItem _NVG};

//RADIOS
if (var_personalRadio) then {_unit addItem _ACRE_PRR;};

// PISTOLS
if (var_pistolAll) then {
	if (handgunWeapon _unit == "") then {
		for "_i" from 1 to 3 do {_unit addItem _Pistol_Ammo};
		_unit addWeapon _Pistol;
	};
};

//REST
for "_i" from 1 to 2 do {_unit addItem "FirstAidKit"};
_unit linkItem "ItemWatch";