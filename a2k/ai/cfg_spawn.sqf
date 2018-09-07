
waitUntil {CBA_missionTime > 1};
sleep 1;

#include "..\gear\cfg_ai.sqf";

// FUNCTIONS ///////////////////////////////////////////////////////////////////////////////////////
nk_typemaker = {
private ["_type","_i"];
_type = (_this select 0);
_select = [];
if (typeName _type == "SCALAR") then {
  // Number
  for "_i" from 1 to (floor (_type)) do {
  _select pushback (SelectRandom _soldier);
  };
  } else {
  // 'string' unit type 
  _select = switch (toUpper _type) do {
    case "SQUAD": {selectRandom _squad};
    case "TEAM": {selectRandom _team};
    case "SENTRY": {selectRandom _sentry};
    case "ATTEAM": {selectRandom _atteam};
    case "AATEAM": {selectRandom _aateam};
	  case "MGTEAM": {selectRandom _mgteam};
    default {selectRandom _team};
  };
 };
_select
};

// CLOSE FUNCTION
nk_close = {
  private ["_pos", "_range","_dist","_availabletargets"];
  _pos = (_this select 0) call CBA_fnc_getpos;
  _range = if (count _this > 1) then {_this select 1} else {500};
  _availabletargets = (switchableUnits + playableUnits - entities "HeadlessClient_F");
  _close = false;
    {
    _dist=vehicle _x distance _pos;
    if (isPlayer _x and _dist<_range) then 
      {
        _close=true;
      };
    } forEach _availabletargets;
  _close
};

// GEAR ////////////////////////////////////////////////////////////////////////////////////////////
_gear = a2k_fnc_aiGear;//a2k_fnc_aiGear; //What gear AI will use


// SOLDIERS ////////////////////////////////////////////////////////////////////////////////////////
_soldier = [
              _Rifleman,
              _Rifleman,
              _Rifleman,
			        _Rifleman,
			        _MMG_Gunner,
		      	  _Grenadier,
              _Grenadier,
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