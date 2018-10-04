// VEHICLE SPAWNER ////////////////////////////////////////////////////////////////////////////////


#include "..\cfg_player.sqf";


// INIT
_c = _this select 0;
_type = _this select 1;

// Check if qualified
_q= ((rank player != "PRIVATE") AND (rank player != "CORPORAL"));
if (!_q) exitWith {hint "Only NCO's and Officers may spawn vehicles"; systemChat "Only NCO's and Officers may spawn vehicles";};

// Check if occupied
_list = (getpos vehicleSpawner) nearEntities [["Man", "Air", "Land", "Ship"], 10];
if (count _list > 0) exitWith {hint "Spawn pad occupied"; systemChat "Spawn pad occupied";};

// Define type
_veh_type = switch (toUpper _type) do 
{
    case "VEH1":{_veh1};
    case "VEH2":{_veh2};
    case "VEH3":{_veh3};
    case "VEH4":{_veh4};
    case "HELI1":{_heli1};
    case "HELI2":{_heli2};
    case "HELI3":{_heli3};
    case "HELI4":{_heli4};
}; 

// Spawn vehicle
_veh = _veh_type createVehicle getPosATL vehicleSpawner;
_dir = getDir vehicleSpawner;
_veh setDir _dir;

// Set options
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

_veh addMagazineCargoGlobal [(_SMG_Ammo select 0), 10];
_veh addMagazineCargoGlobal [(_FlareGun_Ammo select 1), 4];
_veh addMagazineCargoGlobal [(_Rifle_Ammo select 0), 8];
_veh addMagazineCargoGlobal [(_Rifle_Ammo_T select 0), 8];
_veh addMagazineCargoGlobal [(_MMG_Ammo select 0), 2];


_veh addMagazineCargoGlobal [(_Grenade_Smoke select 0), 4];
_veh addMagazineCargoGlobal [(_Grenade_Smoke select 1), 2];
_veh addItemCargoGlobal ["ACE_HandFlare_Green", 4];

_veh addItemCargoGlobal ["FirstAidKit", 5];
_veh addItemCargoGlobal ["Toolkit", 1];
_veh addItemCargoGlobal [_ACRE_MMR, 1];
_veh addBackpackCargoGlobal ["B_Parachute",2];

a2k_vehDelete = ["vehDelete","Delete Vehicle","",{deleteVehicle _target},{_target distance vehicleSpawner < 10},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
[_veh, 0, ["ACE_MainActions"], a2k_vehDelete] call ace_interact_menu_fnc_addActionToObject;

// END