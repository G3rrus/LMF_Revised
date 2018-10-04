// AMMO CRATE SPAWNER /////////////////////////////////////////////////////////////////////////////


#include "..\cfg_player.sqf";

// INIT
_c = _this select 0;
_type = _this select 1;

// Check if qualified
_q= ((rank player != "PRIVATE") AND (rank player != "CORPORAL"));
if (!_q) exitWith {hint "Only NCO's and Officers may spawn supplies"; systemChat "Only NCO's and Officers may spawn supplies";};

// Check if occupied
_list = (getpos crateSpawner) nearEntities [["Man", "Air", "Land"], 7];
if (count _list > 0) exitWith {hint "Spawn pad occupied"; systemChat "Spawn pad occupied";};

// SELECT GROUP TYPE
switch (_type) do
{
	case "ammolarge":
	{
		_crate = "B_supplyCrate_F" createVehicle getPos crateSpawner;
		_dir = getDir crateSpawner;
		_crate setDir _dir;

		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearItemCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;

		_crate addMagazineCargoGlobal [(_Rifle_Ammo select 0), 20];
		_crate addMagazineCargoGlobal [(_Rifle_Ammo_T select 0), 10];
		_crate addMagazineCargoGlobal [(_MMG_Ammo select 0), 4];
		_crate addMagazineCargoGlobal [(_MMG_Ammo_T select 0), 2];
		_crate addMagazineCargoGlobal [(_Rifle_GL_HE select 0), 6];
		_crate addMagazineCargoGlobal [(_Rifle_GL_Smoke select 0), 2];
		_crate addMagazineCargoGlobal [(_Rifle_GL_Smoke_Grn select 0), 2];
		_crate addMagazineCargoGlobal [(_Rifle_GL_Flare select 0), 2];
		_crate addMagazineCargoGlobal [(_LAT_Ammo select 0), 2];
		_crate addMagazineCargoGlobal [(_MAT_Ammo select 0), 2];

		_crate addMagazineCargoGlobal [(_Grenade_Smoke select 0), 6];
		_crate addMagazineCargoGlobal [(_Grenade_Smoke select 1), 2];
		_crate addMagazineCargoGlobal [(_Grenade select 0), 8];

		//Wait then delete crate if still at the crateSpawner
		sleep 600;
		if (_crate distance crateSpawner < 7) then {deleteVehicle _crate};

		waitUntil {_crate distance crateSpawner > 7};
		waitUntil {_crate distance crateSpawner < 7};
		deleteVehicle _crate;
	};
	case "ammosmall": //Box_NATO_Equip_F
	{
		_crate = "Box_NATO_Ammo_F" createVehicle getPos crateSpawner;
		_dir = getDir crateSpawner;
		_crate setDir _dir;

		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearItemCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;

		_crate addMagazineCargoGlobal [(_Rifle_Ammo select 0), 10];
		_crate addMagazineCargoGlobal [(_Rifle_Ammo_T select 0), 10];
		_crate addMagazineCargoGlobal [(_MMG_Ammo select 0), 2];
		_crate addMagazineCargoGlobal [(_Rifle_GL_HE select 0), 4];

		_crate addMagazineCargoGlobal [(_Grenade_Smoke select 0), 4];
		_crate addMagazineCargoGlobal [(_Grenade_Smoke select 1), 2];
		_crate addMagazineCargoGlobal [(_Grenade select 0), 6];

		//Wait then delete crate if still at the crateSpawner
		sleep 600;
		if (_crate distance crateSpawner < 7) then {deleteVehicle _crate};

		waitUntil {_crate distance crateSpawner > 7};
		waitUntil {_crate distance crateSpawner < 7};
		deleteVehicle _crate;
	};
	case "explosives":
	{
		_crate = "Box_NATO_AmmoOrd_F" createVehicle getPos crateSpawner;
		_dir = getDir crateSpawner;
		_crate setDir _dir;

		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearItemCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;

		_crate addItemCargoGlobal ["DemoCharge_Remote_Mag", 8];
		_crate addItemCargoGlobal ["SatchelCharge_Remote_Mag", 2];
		_crate addItemCargoGlobal ["ACE_M26_Clacker",2];
		_crate addBackpackCargoGlobal ["B_AssaultPack_ocamo", 2];
		//Wait then delete crate if still at the crateSpawner
		sleep 600;
		if (_crate distance crateSpawner < 7) then {deleteVehicle _crate};

		waitUntil {_crate distance crateSpawner > 7};
		waitUntil {_crate distance crateSpawner < 7};
		deleteVehicle _crate;
	};
	case "medical":
	{
		_crate = "ACE_medicalSupplyCrate_advanced" createVehicle getPos crateSpawner;
		_dir = getDir crateSpawner;
		_crate setDir _dir;

		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearItemCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;

		_crate addItemCargoGlobal ["ACE_fieldDressing", 50];
		_crate addItemCargoGlobal ["ACE_packingBandage",50];
		_crate addItemCargoGlobal ["ACE_morphine",20];
		_crate addItemCargoGlobal ["ACE_epinephrine",10];
		_crate addItemCargoGlobal ["ACE_salineIV",12];
		_crate addItemCargoGlobal ["ACE_Tourniquet",15];
		_crate addItemCargoGlobal ["ACE_personalAidKit",2];

		//Wait then delete crate if still at the crateSpawner
		sleep 600;
		if (_crate distance crateSpawner < 7) then {deleteVehicle _crate};

		waitUntil {_crate distance crateSpawner > 7};
		waitUntil {_crate distance crateSpawner < 7};
		deleteVehicle _crate;
	};
	case "radios":
	{
		_crate = "Box_NATO_Ammo_F" createVehicle getPos crateSpawner;
		_dir = getDir crateSpawner;
		_crate setDir _dir;

		clearMagazineCargoGlobal _crate;
		clearWeaponCargoGlobal _crate;
		clearItemCargoGlobal _crate;
		clearBackpackCargoGlobal _crate;

		_crate addItemCargoGlobal ["ACRE_PRC343", 40];
		_crate addItemCargoGlobal ["ACRE_PRC152", 20];
		_crate addItemCargoGlobal ["ACRE_PRC117F",15];
		_crate addBackpackCargoGlobal ["rhsusf_assault_eagleaiii_ocp",15];

		//Wait then delete crate if still at the crateSpawner
		sleep 600;
		if (_crate distance crateSpawner < 7) then {deleteVehicle _crate};

		waitUntil {_crate distance crateSpawner > 7};
		waitUntil {_crate distance crateSpawner < 7};
		deleteVehicle _crate;
	};
	case "sparewheel":
	{
		_crate = "ACE_Wheel" createVehicle getPos crateSpawner;
		_dir = getDir crateSpawner;
		_crate setDir _dir;

		//Wait then delete crate if still at the crateSpawner
		sleep 600;
		if (_crate distance crateSpawner < 7) then {deleteVehicle _crate};

		waitUntil {_crate distance crateSpawner > 7};
		waitUntil {_crate distance crateSpawner < 7};
		deleteVehicle _crate;
	};
	case "sparetrack":
	{
		_crate = "ACE_Track" createVehicle getPos crateSpawner;
		_dir = getDir crateSpawner;
		_crate setDir _dir;

		//Wait then delete crate if still at the crateSpawner
		sleep 600;
		if (_crate distance crateSpawner < 7) then {deleteVehicle _crate};

		waitUntil {_crate distance crateSpawner > 7};
		waitUntil {_crate distance crateSpawner < 7};
		deleteVehicle _crate;
	};
};

// END