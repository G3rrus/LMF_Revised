// DEFINITIONS FOR SPAWN FUNCTIONS  ///////////////////////////////////////////////////////////////
/*
	- File ment for defining groups, also includes some functions related to the spawning process
	  such as picking the group and checking if players are far enough away.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
#include "..\..\..\settings\cfg_AI.sqf"


// MEN FOR SCALAR SPAWNING ////////////////////////////////////////////////////////////////////////
private _soldier = [
	_Rifleman,
	_Rifleman,
	_Rifleman,
	_Rifleman,
	_Rifleman,
	_MMG_Gunner,
	_Marksman,
	_Rifleman_AT,
	_Autorifleman,
	_Squad_Leader
];


// GROUPS //////////////////////////////////////////////////////////////////////////////////////////
private _squad = [
	[_Squad_Leader,_Autorifleman,_MMG_Gunner,_Rifleman,_Grenadier,_Marksman,_Rifleman,_Rifleman_AT],
	[_Squad_Leader,_Marksman,_Rifleman,_Rifleman,_Rifleman_AT,_Grenadier,_Autorifleman,_Rifleman_AT],
	[_Squad_Leader,_Rifleman,_Rifleman_AT,_Marksman,_Grenadier,_Autorifleman,_Rifleman,_Rifleman],
	[_Squad_Leader,_Autorifleman,_Grenadier,_Marksman,_Rifleman_AT,_Rifleman_AT,_Rifleman,_Autorifleman]
	];

private _team =	[
	[_Squad_Leader,_Rifleman,_Rifleman,_Rifleman_AT],
	[_Squad_Leader,_Rifleman,_Rifleman,_Marksman],
	[_Squad_Leader,_Rifleman,_Rifleman,_Autorifleman],
	[_Squad_Leader,_Rifleman,_Rifleman,_Grenadier],
	[_Squad_Leader,_Autorifleman,_Marksman,_Rifleman_AT]
];

private _sentry =	[
	[_Rifleman,_Rifleman_AT],
	[_Rifleman,_Autorifleman],
	[_Rifleman,_Grenadier],
	[_Rifleman,_Marksman]
];

private _atTeam =	[
	[_Squad_Leader,_Grenadier,_MAT_Gunner,_MAT_Gunner],
	[_Squad_Leader,_Rifleman_AT,_MAT_Gunner,_MAT_Gunner],
	[_Squad_Leader,_Grenadier,_MAT_Gunner,_Rifleman_AT],
	[_Squad_Leader,_MAT_Gunner,_MAT_Gunner,_MAT_Gunner]
];

private _aaTeam =	[
	[_Squad_Leader,_Autorifleman,_AA_Gunner,_AA_Gunner],
	[_Squad_Leader,_Rifleman_AT,_AA_Gunner,_AA_Gunner],
	[_Squad_Leader,_AA_Gunner,_AA_Gunner,_AA_Gunner],
	[_Squad_Leader,_Grenadier,_AA_Gunner,_AA_Gunner]
];

private _mgTeam =	[
	[_Squad_Leader,_Grenadier,_MMG_Gunner,_MMG_Gunner],
	[_Squad_Leader,_Autorifleman,_Autorifleman,_Autorifleman],
	[_Squad_Leader,_MMG_Gunner,_MMG_Gunner,_MMG_Gunner]
];

private _vehicleCrew = [_Crew,_Crew,_Crew];
private _heliCrew = [_Pilot,_Pilot];
private _staticCrew = [_Static_Gunner,_Static_Assistant];