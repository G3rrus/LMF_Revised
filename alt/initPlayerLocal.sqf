

// KILLED BY //////////////////////////////////////////////////////////////////////////////////////
a2k_fnc_killedMsg = {
	params ["_unit","_killer"];
	_killerName = name _killer;
	_dist = floor (player distance _killer);
	_weaponName = getText (configFile >> "cfgWeapons" >> currentWeapon _killer >> "displayname");

	sleep 5;

	if (!isNull _killer AND _killer != player) then {
		systemChat format ["You were killed by %1 from %2m",_killerName,_dist,_weaponName];
	};
};
player addEventHandler ["Killed", { _this spawn a2k_fnc_killedMsg; }];

// ANGRY ENEMIES //////////////////////////////////////////////////////////////////////////////////
[player] spawn {
waitUntil {CBA_missionTime > 0};
sleep 15;
_camoCoef = player getUnitTrait "camouflageCoef";
	for "_i" from 0 to 1 step 0 do {
		waitUntil {sleep 10; player getUnitTrait "camouflageCoef" != _camoCoef};
		player setUnitTrait ["camouflageCoef",_camoCoef];
	};
};