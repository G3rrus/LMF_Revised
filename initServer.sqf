#include "a2k\gear\cfg_ai.sqf";

// CLEANUP ////////////////////////////////////////////////////////////////////////////////////////
[] execVM "a2k\scripts\cleanup.sqf";

// MISC ///////////////////////////////////////////////////////////////////////////////////////////
{_x disableAI "MOVE"} forEach switchableUnits + playableUnits;

// GEAR ///////////////////////////////////////////////////////////////////////////////////////////
{
	if (!isPlayer _x) then {
		waitUntil {sleep 1; !isNil "a2k_fnc_playerGear"};
		0 = [_x] spawn a2k_fnc_playerGear;
	};
} forEach playableUnits;

{
	if (side _x == _spawnSide) then {
			waitUntil {sleep 1; !isNil "a2k_fnc_aiGear"};
			0 = [_x] spawn a2k_fnc_aiGear;
	};
} forEach allUnits;

// REMOVE CARGO FROM VEHICLES /////////////////////////////////////////////////////////////////////
{
	if (side _x == _spawnSide) then {
		clearWeaponCargoGlobal _x;
		clearMagazineCargoGlobal _x;
		clearItemCargoGlobal _x;
		clearBackpackCargoGlobal _x;
	};
} forEach vehicles;

//CREW IN IMMOBILE VEHICLE ////////////////////////////////////////////////////////////////////////
{
	if (side _x == _spawnSide) then {
		if (typeOf _x == _apc OR typeOf _x == _tank) then {
			if (25 > random 100) then {
				_x allowCrewInImmobile true;
			};
		};
	};
} forEach vehicles;

// REMOVE AMMO ////////////////////////////////////////////////////////////////////////////////////
waitUntil {sleep 1; !isNil "_ammoBlacklist"};
{
	_y = _x;

	if (side _y == _spawnSide) then {
		{
			_y removeMagazines _x;
		} forEach _ammoBlacklist;
	};
} forEach vehicles;