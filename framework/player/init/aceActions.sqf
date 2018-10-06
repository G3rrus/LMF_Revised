// ACE ACTIONS FOR SPAWNERS AND LOADOUT CRATES ////////////////////////////////////////////////////

// AMMOSPAWNER ////////////////////////////////////////////////////////////////////////////////////
if !(isNil "ammoSpawner") then {
	a2k_g_ammolarge = ["ammolarge","Ammunition Large","\A3\ui_f\data\map\vehicleicons\iconCrateAmmo_ca.paa",{0 = [_this select 1, "ammolarge"] execVM "a2k\gear\inv\ammocrates.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_ammosmall = ["ammosmall","Ammunition Small","\A3\ui_f\data\map\vehicleicons\iconCrate_ca.paa",{0 = [_this select 1, "ammosmall"] execVM "a2k\gear\inv\ammocrates.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_explosives = ["explosives","Explosives","\A3\ui_f\data\map\vehicleicons\pictureExplosive_ca.paa",{0 = [_this select 1, "explosives"] execVM "a2k\gear\inv\ammocrates.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_sparewheel = ["sparewheel","Spare Wheel","\A3\ui_f\data\map\vehicleicons\iconObject_circle_ca.paa",{0 = [_this select 1, "sparewheel"] execVM "a2k\gear\inv\ammocrates.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_sparetrack = ["sparewheel","Spare Track","\A3\ui_f\data\map\vehicleicons\iconObject_circle_ca.paa",{["ACE_Wheel"] call lmf_player_fnc_aceSupplies},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[ammoSpawner, 0, ["ACE_MainActions"], a2k_g_ammolarge] call ace_interact_menu_fnc_addActionToObject;
	[ammoSpawner, 0, ["ACE_MainActions"], a2k_g_ammosmall] call ace_interact_menu_fnc_addActionToObject;
	[ammoSpawner, 0, ["ACE_MainActions"], a2k_g_explosives] call ace_interact_menu_fnc_addActionToObject;
	[ammoSpawner, 0, ["ACE_MainActions"], a2k_g_sparewheel] call ace_interact_menu_fnc_addActionToObject;
	[ammoSpawner, 0, ["ACE_MainActions"], a2k_g_sparetrack] call ace_interact_menu_fnc_addActionToObject;
};

// VEHICLESPAWNER /////////////////////////////////////////////////////////////////////////////////
if (!isNil "vehSpawner") then {
	_vehType1 = getText (configFile >> "CfgVehicles" >> _veh1 >> "displayName");
	_vehType2 = getText (configFile >> "CfgVehicles" >> _veh2 >> "displayName");
	_vehType3 = getText (configFile >> "CfgVehicles" >> _veh3 >> "displayName");
	_vehType4 = getText (configFile >> "CfgVehicles" >> _veh4 >> "displayName");
	_heliType1 = getText (configFile >> "CfgVehicles" >> _heli1 >> "displayName");
	_heliType2 = getText (configFile >> "CfgVehicles" >> _heli2 >> "displayName");
	_heliType3 = getText (configFile >> "CfgVehicles" >> _heli3 >> "displayName");
	_heliType4 = getText (configFile >> "CfgVehicles" >> _heli4 >> "displayName");

	a2k_v_veh1 = ["veh1",_vehType1,"",{0 = [_this select 1, "VEH1"] execVM "a2k\gear\inv\vehicleSpawner.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_v_veh2 = ["veh2",_vehType2,"",{0 = [_this select 1, "VEH2"] execVM "a2k\gear\inv\vehicleSpawner.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_v_veh3 = ["veh3",_vehType3,"",{0 = [_this select 1, "VEH3"] execVM "a2k\gear\inv\vehicleSpawner.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_v_veh4 = ["veh4",_vehType4,"",{0 = [_this select 1, "VEH4"] execVM "a2k\gear\inv\vehicleSpawner.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_v_heli1 = ["heli1",_heliType1,"",{0 = [_this select 1, "HELI1"] execVM "a2k\gear\inv\vehicleSpawner.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_v_heli2 = ["heli2",_heliType2,"",{0 = [_this select 1, "HELI2"] execVM "a2k\gear\inv\vehicleSpawner.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_v_heli3 = ["heli3",_heliType3,"",{0 = [_this select 1, "HELI3"] execVM "a2k\gear\inv\vehicleSpawner.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_v_heli4 = ["heli4",_heliType4,"",{0 = [_this select 1, "HELI4"] execVM "a2k\gear\inv\vehicleSpawner.sqf"},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	if (_veh1 != "") then {[vehSpawner, 0, ["ACE_MainActions"], a2k_v_veh1] call ace_interact_menu_fnc_addActionToObject;};
	if (_veh2 != "") then {[vehSpawner, 0, ["ACE_MainActions"], a2k_v_veh2] call ace_interact_menu_fnc_addActionToObject;};
	if (_veh3 != "") then {[vehSpawner, 0, ["ACE_MainActions"], a2k_v_veh3] call ace_interact_menu_fnc_addActionToObject;};
	if (_veh4 != "") then {[vehSpawner, 0, ["ACE_MainActions"], a2k_v_veh4] call ace_interact_menu_fnc_addActionToObject;};
	if (_heli1 != "") then {[vehSpawner, 0, ["ACE_MainActions"], a2k_v_heli1] call ace_interact_menu_fnc_addActionToObject;};
	if (_heli2 != "") then {[vehSpawner, 0, ["ACE_MainActions"], a2k_v_heli2] call ace_interact_menu_fnc_addActionToObject;};
	if (_heli3 != "") then {[vehSpawner, 0, ["ACE_MainActions"], a2k_v_heli3] call ace_interact_menu_fnc_addActionToObject;};
	if (_heli4 != "") then {[vehSpawner, 0, ["ACE_MainActions"], a2k_v_heli4] call ace_interact_menu_fnc_addActionToObject;};
};

// GEAR SELECTION SYSTEM //////////////////////////////////////////////////////////////////////////
if (!isNil "crate_gearSquad") then {
	a2k_g_squadleader = ["squadleader","Squad Leader","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{0 = [_this select 1, "squadleader"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_squad2ic = ["squad2ic","Squad 2iC","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{0 = [_this select 1, "squad2ic"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_autorifleman = ["autorifleman","Autorifleman","\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa",{0 = [_this select 1, "autorifleman"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_rifleman = ["rifleman","Rifleman","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{0 = [_this select 1, "rifleman"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_mmg_g = ["mmggunner","MMG Gunner","\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa",{0 = [_this select 1, "mmg_g"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_mmg_a = ["mmgassistant","MMG Assistant","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{0 = [_this select 1, "mmg_a"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_mat_g = ["matgunner","MAT Gunner","\A3\ui_f\data\map\vehicleicons\iconManAT_ca.paa",{0 = [_this select 1, "mat_g"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_mat_a = ["matassistant","MAT Assistant","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{0 = [_this select 1, "mat_a"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[crate_gearSquad, 0, ["ACE_MainActions"], a2k_g_squadleader] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearSquad, 0, ["ACE_MainActions"], a2k_g_squad2ic] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearSquad, 0, ["ACE_MainActions"], a2k_g_autorifleman] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearSquad, 0, ["ACE_MainActions"], a2k_g_rifleman] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearSquad, 0, ["ACE_MainActions"], a2k_g_mmg_g] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearSquad, 0, ["ACE_MainActions"], a2k_g_mmg_a] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearSquad, 0, ["ACE_MainActions"], a2k_g_mat_g] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearSquad, 0, ["ACE_MainActions"], a2k_g_mat_a] call ace_interact_menu_fnc_addActionToObject;
};

if (!isNil "crate_gearPlthq") then {
	a2k_g_pltlead = ["platoonleader","Platoon Leader","\A3\ui_f\data\map\vehicleicons\iconManOfficer_ca.paa",{0 = [_this select 1, "pltlead"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_pltsgt = ["platoonsergeant","Platoon Sergeant","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{0 = [_this select 1, "pltsgt"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_medic = ["medic","Medic","\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa",{0 = [_this select 1, "medic"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_rto = ["rto","RTO","\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa",{0 = [_this select 1, "rto"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_fac = ["fac","FAC","\A3\ui_f\data\map\vehicleicons\iconManVirtual_ca.paa",{0 = [_this select 1, "fac"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_heli = ["heli","Heli Pilot","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{0 = [_this select 1, "helipilot"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_fighter = ["fighter","Fighter Pilot","\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa",{0 = [_this select 1, "fighterpilot"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[crate_gearPlthq, 0, ["ACE_MainActions"], a2k_g_pltlead] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearPlthq, 0, ["ACE_MainActions"], a2k_g_pltsgt] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearPlthq, 0, ["ACE_MainActions"], a2k_g_medic] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearPlthq, 0, ["ACE_MainActions"], a2k_g_rto] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearPlthq, 0, ["ACE_MainActions"], a2k_g_fac] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearPlthq, 0, ["ACE_MainActions"], a2k_g_heli] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearPlthq, 0, ["ACE_MainActions"], a2k_g_fighter] call ace_interact_menu_fnc_addActionToObject;
};

if (!isNil "crate_gearCrew") then {
	a2k_g_veh_pltlead = ["veh_platoonleader","Vehicle Platoon Leader","\A3\ui_f\data\map\vehicleicons\iconManOfficer_ca.paa",{0 = [_this select 1, "veh_pltlead"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_veh_pltsgt = ["veh_platoonsergeant","Vehicle Platoon Sergeant","\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa",{0 = [_this select 1, "veh_pltsgt"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_veh_commander = ["veh_commander","Vehicle Commander","A3\ui_f\data\igui\cfg\commandbar\imageCommander_ca.paa",{0 = [_this select 1, "veh_commander"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_veh_gunner = ["veh_gunner","Vehicle Gunner","A3\ui_f\data\igui\cfg\commandbar\imageGunner_ca.paa",{0 = [_this select 1, "veh_gunner"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;
	a2k_g_veh_driver = ["veh_driver","Vehicle Driver","A3\ui_f\data\igui\cfg\commandbar\imageDriver_ca.paa",{0 = [_this select 1, "veh_driver"] spawn a2k_fnc_playerGear;},{true},{},[], [0,0,0], 100] call ace_interact_menu_fnc_createAction;

	[crate_gearCrew, 0, ["ACE_MainActions"], a2k_g_veh_pltlead] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearCrew, 0, ["ACE_MainActions"], a2k_g_veh_pltsgt] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearCrew, 0, ["ACE_MainActions"], a2k_g_veh_commander] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearCrew, 0, ["ACE_MainActions"], a2k_g_veh_gunner] call ace_interact_menu_fnc_addActionToObject;
	[crate_gearCrew, 0, ["ACE_MainActions"], a2k_g_veh_driver] call ace_interact_menu_fnc_addActionToObject;
};