

waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};


for "_i" from 0 to 1 step 0 do {

	waitUntil {sleep 5; count allDeadMen > 30};
	_randomDeadGuy = selectRandom allDeadMen;

	if (!isPlayer _randomDeadGuy AND {_randomDeadGuy distance _x > 25} count allPlayers > 0) then {
		deleteVehicle _randomDeadGuy;
		//systemChat format ["Deleted %1", _randomDeadGuy];
	};

};