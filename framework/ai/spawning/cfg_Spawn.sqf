// DEFINITIONS FOR SPAWN FUNCTIONS  ////////////////////////////////////////////////////////////////
/*
	- File ment for defining groups, also includes some functions related to the spawning proces
	  such as picking the group and checking if players are far enough away.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
#include "..\..\..\settings\cfg_AI.sqf"


// MEN FOR SCALAR SPAWNING ////////////////////////////////////////////////////////////////////////
_soldier = [
	_Rifleman,
    _Rifleman,
    _Rifleman,
	_Rifleman,
	_Grenadier,
	_Grenadier,
	_MMG_Gunner,
	_Marksman,
    _Rifleman_AT,
	_Autorifleman,
    _Squad_Leader
];


// GROUPS //////////////////////////////////////////////////////////////////////////////////////////
_squad = [
    [_Squad_Leader,_MAT_Gunner,_Grenadier,_Rifleman,_Rifleman,_Rifleman,_Marksman],
	[_Squad_Leader,_MMG_Gunner,_Rifleman_AT,_Grenadier,_Rifleman,_Rifleman,_Rifleman,_Marksman],
	[_Squad_Leader,_Autorifleman,_Rifleman_AT,_Grenadier,_Rifleman,_Rifleman,_Rifleman,_Marksman],
	[_Squad_Leader,_Autorifleman,_Grenadier,_Rifleman_AT,_Rifleman,_Rifleman,_Rifleman,_Marksman]
	];

_team =	[
	[_Squad_Leader,_Rifleman,_Rifleman_AT,_Rifleman],
	[_Squad_Leader,_Rifleman,_Marksman,_Marksman],
	[_Squad_Leader,_Autorifleman,_Grenadier,_Rifleman],
	[_Squad_Leader,_Rifleman,_Rifleman_AT,_Rifleman_AT],
	[_Squad_Leader,_Autorifleman,_Grenadier,_Rifleman]
];

_sentry =	[
	[_Rifleman,_Rifleman_AT],
	[_Rifleman,_Grenadier],
	[_Rifleman,_Rifleman]
];

_atTeam =	[
	[_Squad_Leader,_Rifleman,_MAT_Gunner,_MAT_Gunner],
	[_Squad_Leader,_Rifleman,_Grenadier,_MAT_Gunner],
	[_Squad_Leader,_Rifleman,_Rifleman_AT,_MAT_Gunner]
];

_aaTeam =	[
	[_Squad_Leader,_Autorifleman,_Grenadier,_AA_Gunner],
	[_Squad_Leader,_Autorifleman,_Rifleman_AT,_AA_Gunner],
	[_Squad_Leader,_Autorifleman,_Rifleman,_AA_Gunner]
];

_mgTeam =	[
	[_Squad_Leader,_Rifleman,_MMG_Gunner,_MMG_Gunner],
	[_Squad_Leader,_MMG_Gunner,_Rifleman,_Rifleman],
	[_Squad_Leader,_MMG_Gunner,_Grenadier,_Rifleman]
];

_vehicleCrew = [_Vehicle_Crew,_Vehicle_Crew,_Vehicle_Crew];
_heliCrew = [_Heli_Pilot,_Heli_Pilot];


// FUNCTIONS ///////////////////////////////////////////////////////////////////////////////////////
//PASS SELECTION OF TYPE OF GROUP
_typeMaker = {
	params ["_type"];
	_selection = [];
	if (typeName _type == "SCALAR") then {
		for "_i" from 1 to (floor (_type)) do {
			_selection pushback (selectRandom _soldier);
		};
	}
	else {
		_selection = switch (toUpper _type) do {
			case "SQUAD": {selectRandom _squad};
			case "TEAM": {selectRandom _team};
			case "SENTRY": {selectRandom _sentry};
			case "ATTEAM": {selectRandom _atteam};
			case "AATEAM": {selectRandom _aateam};
			case "MGTEAM": {selectRandom _mgteam};
			default {selectRandom _team};
		};
	};
	_selection
};

//CHECK IF PLAYERS FAR ENOUGH AWAY
_proximityChecker = {
	params [["_pos"],["_range",500]];
	private _targetsToCheck = (switchableUnits + playableUnits - entities "HeadlessClient_F");
	_close = false;
	{
		private _dist = vehicle _x distance _pos;
		if (isPlayer _x && {_dist < _range}) then {_close = true};
		false
	} count _targetsToCheck;
	_close
};