// FN Vehicle Service
// version 2.1
// by nkenny (Heavily borrowed from Xeno)


/*
Usage: 
  Create a trigger with TRUE PRESENCE and 
  
  condition: ("Air" countType thislist > 0) && ((getpos (thislist select 0)) select 2 < 1);
  On Activation:  rearm = [(thislist select 0)] execVM "fn_vehicle_service.sqf";
  
*/

private ["_config","_count","_i","_magazines","_object","_type","_type_name"];
waitUntil {time > 30};

// SETTINGS 
_Zzz = 4; // Universal Sleep

// INIT 
_object = _this select 0;
_type = typeof _object;
_type_name = getText (configFile >> "CfgVehicles" >> typeOf _object >> "displayName");
if (_object isKindOf "ParachuteBase") exitWith {};
if (!local _object) exitWith {};
//if (!alive _object) exitWith {};

//  -----------------------------------------------------------------------------------------------

// MAKE STATIONARY
_object setFuel 0;

//  -----------------------------------------------------------------------------------------------

// RELOAD WEAPONS
_object setVehicleAmmo 1;
_object vehicleChat format ["Servicing %1... Please stand by...", _type_name];
_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

if (count _magazines > 0) then {
	_removed = [];
	{
		if (!(_x in _removed)) then {
			_object removeMagazines _x;
			_removed = _removed + [_x];
		};
	} forEach _magazines;
	{
		_object vehicleChat format ["Reloading %1", _x];
		sleep 4;
		if (!alive _object) exitWith {};
		_object addMagazine _x;
	} forEach _magazines;
};

// GLOBAL SOUND
//_worksound = ["work1","work2"] call bis_fnc_selectRandom;
//[_object,[_worksound,100]] remoteexec ["Say3d"];
//[[_object,_worksound],"say3d",true] call BIS_fnc_MP;

//  -----------------------------------------------------------------------------------------------

// RELOAD TURRETS
_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");
if (_count > 0) then {
	for "_i" from 0 to (_count - 1) do {
		scopeName "xx_reload2_xx";
		_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
		_magazines = getArray(_config >> "magazines");
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_object removeMagazines _x;
				_removed = _removed + [_x];
			};
		} forEach _magazines;
		{
			_object vehicleChat format ["Reloading %1", _x];
			sleep _Zzz;
			if (!alive _object) then {breakOut "xx_reload2_xx"};
			_object addMagazine _x;
			sleep _Zzz;
			if (!alive _object) then {breakOut "xx_reload2_xx"};
		} forEach _magazines;
		
		// check if the main turret has other turrets
		_count_other = count (_config >> "Turrets");
		if (_count_other > 0) then {
			for "_i" from 0 to (_count_other - 1) do {
				_config2 = (_config >> "Turrets") select _i;
				_magazines = getArray(_config2 >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
						_object removeMagazines _x;
						_removed = _removed + [_x];
					};
				} forEach _magazines;
				{
					_object vehicleChat format ["Reloading %1", _x]; 
					sleep _Zzz;
					if (!alive _object) then {breakOut "xx_reload2_xx"};
					_object addMagazine _x;
					sleep _Zzz;
					if (!alive _object) then {breakOut "xx_reload2_xx"};
				} forEach _magazines;
			};
		};
	};
};
_object setVehicleAmmo 1;	// Reload turrets / drivers magazine

//  -----------------------------------------------------------------------------------------------

// REPAIR
sleep _Zzz;
if (!alive _object) exitWith {};
_object vehicleChat "Repairing...";
_object setDamage 0;

// REFUEL 
sleep _Zzz;
if (!alive _object) exitWith {};
_object vehicleChat "Refueling...";
while {fuel _object < 0.99} do {
	//_object setFuel ((fuel _vehicle + 0.1) min 1);
	_object setFuel 1;
	sleep 0.01;
};

// REPORT 
sleep _Zzz;
if (!alive _object) exitWith {};
_object vehicleChat format ["%1 is ready...", _type_name];

// END 
if (true) exitWith {};