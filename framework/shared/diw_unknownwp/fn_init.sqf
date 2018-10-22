// DIWAKOS UNKNOWN WEAPON INIT ////////////////////////////////////////////////////////////////////
/*
    - By Diwako 2018-06-24, slightly altered by Drgn V4karian.
    - File that applies all sorts of things to "uknown" weapons such as higher chance of jamming.
	  Enabling and tuning of the settings is done via CBA settings.
	- Function: diw_unknownwp_fnc_init
	- Parameters: none
	- Returns: nothing
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
if !(diw_unknownwp_enable) exitWith {};

if !(isClass (configFile >> "CfgPatches" >> "ace_overheating")) exitWith {hintC "ACE Overheating not found! Punishing unknown weapons cannot be used!"};
if !(ace_overheating_enabled) exitWith {hintC "ACE Overheating not enabled! Punishing unknown weapons cannot be used!"};

if (missionNamespace getVariable ["diw_unknownwp_init",false]) exitWith {};
missionNamespace setVariable ["diw_unknownwp_init",true];

if !(ace_overheating_overheatingDispersion) then {systemChat "===Unknown Weapon Punishing: Warning, ACE dispersion not enabled!==="};

if (isNil "diw_unknownwp_local_weapons") then {
	diw_unknownwp_local_weapons = [];
};

if (diw_unknownwp_propagation) then {
	[] spawn {
		if (isServer) then {
			waitUntil {sleep 0.1; cba_missiontime > diw_unknownwp_cooldown};
			diw_unknownwp_weapon_whitelist = [];
			"DIW_ADD_WEAPON" addPublicVariableEventHandler {
				params ["_varname","_weapon"];
				diw_unknownwp_weapon_whitelist pushBackUnique toUpper (_weapon);
				[_weapon,{ace_overheating_cacheWeaponData setVariable [_this,nil]}] remoteExec ["call"];
				publicVariable "diw_unknownwp_weapon_whitelist";
			};
			{
				diw_unknownwp_weapon_whitelist pushBackUnique toUpper (primaryWeapon _x);
			} forEach ([] call CBA_fnc_players);
			if (typeName diw_unknownwp_add_weapons == typeName "") then {
				diw_unknownwp_add_weapons = diw_unknownwp_add_weapons splitString ",";
				{
					diw_unknownwp_weapon_whitelist pushBackUnique toUpper (_x);
				} forEach diw_unknownwp_add_weapons;
			};
			publicVariable "diw_unknownwp_weapon_whitelist";
		} else {
			waitUntil {sleep 1; time > 30};
			waitUntil {sleep 1; !isNil "diw_unknownwp_weapon_whitelist"};
			private _weaponUpper = toUpper (primaryWeapon player);
			if (!(_weaponUpper in diw_unknownwp_weapon_whitelist || {_weaponUpper in diw_unknownwp_local_weapons}) && (primaryWeapon player) != "") then {
				//ADD WEAPON TO WHITELIST
				DIW_ADD_WEAPON = primaryWeapon player;
				publicVariableServer "DIW_ADD_WEAPON";
			};
		};
	};
} else {
	diw_unknownwp_weapon_whitelist = [];
};

if (hasInterface) then {
	if (diw_unknownwp_briefing) then {
		player createDiaryRecord ["Diary", ["Picking up enemy weapons",
			"<font size='25'>Warning: Punish unknown weapons is active!</font><br/><font size='15'>Picking up unknown weapons, such as enemy weapons, will result in degraded weapon efficiency!<br/>Symptoms could be less accuracy, higher jamming chance and reload failures due to poor weapon maintenance or handling. If enabled a symptom could also be ammunition misfiring which will cause weapon destruction and possible injury to the current user!"
		]];
	};

	player addEventHandler ["Fired",{
		_weapon = _this select 1;
		if (!(primaryWeapon ace_player == _weapon)) exitWith {};
		if (isNil "diw_unknownwp_weapon_whitelist") exitWith {};

		private _weaponData = ace_overheating_cacheWeaponData getVariable _weapon;
		if (isNil "_weaponData") then {
			private _weaponUpper = toUpper (_weapon);
			//WEAPON CLASS HAS NOT BEEN INITALIZED
			if (!(_weaponUpper in diw_unknownwp_weapon_whitelist || {_weaponUpper in diw_unknownwp_local_weapons})) then {
				//WEAPON NOT IN WHITELIST
				_weaponData = [_weapon] call ace_overheating_fnc_getWeaponData;
				//0: DISPERSON <NUMER>, 1: SLOWDOWNFACTOR <NUMBER>, 2: JAMCHANCE <NUMBER>
				_weaponData set [0,(_weaponData select 0 + diw_unknownwp_dispersion_add)];
				_weaponData set [2,(_weaponData select 2 + (diw_unknownwp_jamchance_add / 100))];
				ace_overheating_cacheWeaponData setVariable [_weapon, _weaponData];
			};
		};
	}];

	player addEventHandler ["Reloaded", {
		params ["_unit", "_weapon", "_muzzle", "_newMagazine", "_oldMagazine"];

		if (!(primaryWeapon ace_player == _weapon)) exitWith {};
		if (isNil "diw_unknownwp_weapon_whitelist") exitWith {};

		private _weaponUpper = toUpper (_weapon);
		if (!(_weaponUpper in diw_unknownwp_weapon_whitelist || {_weaponUpper in diw_unknownwp_local_weapons})) then {
			//WEAPON NOT IN WHITELIST
			if ( (random 100) <= diw_unknownwp_reload_failure ) then {
				//RELOAD FAILED
				ace_player addMagazine [_newMagazine#0, _newMagazine#1];
				ace_player setAmmo [_weapon, 0];

				[{["Reload failed"] call ace_common_fnc_displayTextStructured;}, []] call CBA_fnc_execNextFrame;
			};
		};
	}];

	["ace_weaponJammed", {
		params["_unit","_weapon"];
		if (_unit == ace_player) then {
			if (!(primaryWeapon ace_player == _weapon)) exitWith {};
			if (isNil "diw_unknownwp_weapon_whitelist") exitWith {};
			private _weaponUpper = toUpper (_weapon);
			if (!(_weaponUpper in diw_unknownwp_weapon_whitelist || {_weaponUpper in diw_unknownwp_local_weapons})) then {
				if ((random 100) < diw_unknownwp_jam_explosion) then {
					private _model = getText (configfile >> "cfgweapons" >> _weapon >> "model");
					if ((_model find ".") == -1) then {
						_model = _model + ".p3d";
					};
					if (_model find "\" == 0) then {
						_model = [_model, 1] call CBA_fnc_substr;
					};
					private _groundHolder = createVehicle ["WeaponHolderSimulated", position ace_player, [], 0.5, "CAN_COLLIDE"];
					private _ammo = 1;
					{
						_groundHolder addMagazineAmmoCargo [_x, 1, _ammo];
					} count (primaryWeaponMagazine ace_player);
					{
						if (_x != "") then {
							_groundHolder addItemCargoGlobal [_x,1];
						};
					} forEach (primaryWeaponItems ace_player);

					private _dummy = createSimpleObject [_model,getPosATL ace_player];
					_dummy hideSelection ["zasleh",true];
					_dummy hideSelection ["magazine",true];
					_dummy hideSelection ["bolt",true];
					_dummy hideSelection ["magrelease",true];
					_dummy attachTo [_groundHolder,[0,0,-0.5]];

					private _dir = getdir ace_player;
					_groundHolder disableCollisionWith ace_player;
					_groundHolder setPos (ace_player modelToWorld [0.25,0.4,1.2]);
					_groundHolder setDir (_dir + 90);

					private _speed = 2.5;
					_groundHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir),1];
					ace_player removeWeapon _weapon;
					[{
						{
							deleteVehicle _x;
						} count _this;
					}, [_dummy], 300] call CBA_fnc_waitAndExecute;
					playSound3D ["A3\Sounds_F\arsenal\explosives\mines\Mine_closeExp_0" + str( (floor random 3) + 1 ) + ".wss",objNull,false,getPosATL ace_player,10,1,150];
					addCamShake [20,2,2];
					["Weapon has been destroyed"] call ace_common_fnc_displayTextStructured;
					private _dam = 1;
					if (!isNil "ace_medical_fnc_addDamageToUnit") then {
						//ACE MEDICAL IS ENABLED
						if (isPlayer ace_player) then {
							_dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 10;
						} else {
							private _res = ace_player getVariable ["ace_medical_unitDamageThreshold", [1, 1, 1]];
							_dam = ((_res select 0 + _res select 1 + _res select 2) / 3) / 5;
						};
						[ace_player, _dam, selectRandom ["head", "body", "hand_l", "hand_r"], "stab"] call ace_medical_fnc_addDamageToUnit;
					} else {
						//ACE MEDICAL NOT ENABLED
						_dam = damage ace_player;
						ace_player setDamage (_dam + 0.1);
					};
				};
			};
		};
	}] call CBA_fnc_addEventHandler;
};