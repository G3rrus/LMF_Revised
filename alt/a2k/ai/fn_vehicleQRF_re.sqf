// VEHICLE QRF (RESPAWNING) ///////////////////////////////////////////////////////////////////////
// BEHAVIOUR: Will act as a QRF, waiting at the spawnposition until called by friendly AI.
// RESPAWNS at original spawn position when all group members are dead
// DOES NOT spawn if there are players nearby their spawnposition (within 1000m)

//Parameters:
//1. Spawn position
//2. Group type ("car","carArmed","truck","apc","tank","heliTransport","heliAttack")
//3. Time before vehicle respawns (after all units in group is dead)
//4. Number of times vehicle respawns (default 99) 
//EXAMPLE: 0 = [this,"car",300] spawn a2k_fnc_vehicleQRF_re;

/*
Rewritten 02.04.17 by nkenny
- Fewer paramaters required
- Many fewer lines of code

Version update 04.04.17
- Added possibility for lowercase vehicle names
- Fixed vehicle respawn and added _tickets

*/

waitUntil {!isNil "var_isSpawner"};
if (!var_isSpawner) exitWith {};

// INIT --------------------------------------------------------------------

#include "cfg_spawn.sqf";
_pos = (_this select 0) call CBA_fnc_getpos;
_dir = getDir (_this select 0);
_grpType = if (count _this > 1) then {_this select 1} else {"RANDOM"};
_respawnTime = if (count _this > 2) then {_this select 2} else {300};
_tickets = if (count _this > 3) then {_this select 3} else {99};

// FUNCTIONS ---------------------------------------------------------------

// Functions : spawn an empty vehicle
_nk_create = {
  // spawn it
  _veh = _veh_type createVehicle _pos;
  _veh setDir _dir;
  
  // vehicle basics
  clearWeaponCargoGlobal _veh;
  clearMagazineCargoGlobal _veh;
  clearItemCargoGlobal _veh;
  clearBackpackCargoGlobal _veh;
  _veh; 
}; 
// Functions : Typeselect
_nk_type = {
    _veh_type = switch (toUpper _grpType) do 
      {
      case "CAR" : {_car};
      case "CARARMED" : {_cararmed};
      case "TRUCK" : {_truck};
      case "APC" : {_apc};
      case "TANK" : {_tank};
      case "HELITRANSPORT" : {_heli_transport};
      case "HELIATTACK" : {_heli_attack};
      default {selectRandom [_car,_truck]};
      }; 
    _veh_type
}; 

// STAY A WHILE AND LISTEN!
waitUntil {sleep 1; CBA_missionTime > (30 + (random 90));};
sleep (random 10);

// PREPARE FOR THE MAGIC ---------------------------------------------------
for "_i" from 0 to _tickets do 
{
    // BASIC SPAWN -----------------------
    // Vehicle Type 
    _veh_type = call _nk_type;
    
    // Behavior
    _beh = selectRandom ["COMBAT","AWARE"]; 

		// check if player nearby-- if close, wait. 
		_pclose = [_pos,1000] call nk_close;
		if (_pclose) then 
		{
		sleep 30; 
		} else {

    // Select and spawn vehicle
    _grp = createGroup _spawnSide;
    _veh = call _nk_create; 
  
    // OPTIONS, CREW AND ORDERS -------------
    switch (toUpper _grpType) do
    {
      case "CAR": {
		// Vehicle options
		_veh setVehicleLock "UNLOCKED";

        // Select and spawn infantry
        _type = SelectRandom _team;
        _grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh} forEach units _grp;
		
		// CUSTOM CAMO STUFF
		if (_car_camo != "") then {
			[
			_veh,
			[_car_camo,1]
			] call BIS_fnc_initVehicle;
		};
		
		// Gear
		{0 = [_x] spawn _gear;} foreach units _grp;

		// REMOVE AMMO
		{
			_veh removeMagazines _x;
		} forEach _ammoBlacklist;

        // Orders
        _wp = _grp addWaypoint [_pos,0];
        _wp setWaypointType "GUARD";
		0 = [_grp] spawn a2k_fnc_taskUpdateWP;

		waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1 OR !alive _veh};
		0 = [_grp] spawn a2k_fnc_taskAssault;
      };
      case "CARARMED": {
        // Vehicle options
		//if (50 > random 100) then {_veh allowCrewInImmobile true;};
		_veh setVehicleLock "UNLOCKED";

        // Select and spawn infantry
        _type = SelectRandom _sentry;
        _grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh} forEach units _grp;

		// CUSTOM CAMO STUFF
		if (_carArmed_Camo != "") then {
			[
			_veh,
			[_carArmed_Camo,1]
			] call BIS_fnc_initVehicle;
		};

		// Gear
		{0 = [_x] spawn _gear;} foreach units _grp;

		// REMOVE AMMO
		{
			_veh removeMagazines _x;
		} forEach _ammoBlacklist;

        // Orders
        _wp = _grp addWaypoint [_pos,0];
        _wp setWaypointType "GUARD";
        _grp setBehaviour _beh;
        0 = [_grp] spawn a2k_fnc_taskUpdateWP;
      };
      case "TRUCK": {
        // Vehicle options
		_veh setVehicleLock "UNLOCKED";
        
        // Select and spawn infantry
        _type = SelectRandom _squad;
        _grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;
        {_x moveInAny _veh} forEach units _grp;

		// CUSTOM CAMO STUFF
		if (_truck_Camo != "") then {
			[
			_veh,
			[_truck_Camo,1]
			] call BIS_fnc_initVehicle;
		};

		// Gear
		{0 = [_x] spawn _gear;} foreach units _grp;

		// REMOVE AMMO
		{
			_veh removeMagazines _x;
		} forEach _ammoBlacklist;

        // Orders
        _wp = _grp addWaypoint [_pos,0];
        _wp setWaypointType "GUARD";
		0 = [_grp] spawn a2k_fnc_taskUpdateWP;

		waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1 OR !alive _veh};
		0 = [_grp] spawn a2k_fnc_taskAssault;
      };
      case "APC": {
        // Vehicle options
        if (50 > random 100) then {_veh allowCrewInImmobile true;};
		_veh setVehicleLock "LOCKEDPLAYER";

        // Select and spawn infantry
        _type = _vehicleCrew;
        _grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh} forEach units _grp;

        // Select and spawn infantry
        _type2 = selectRandom [selectRandom _squad,selectRandom _team];
        _grp2 = [_pos,_spawnSide,_type2] call BIS_fnc_spawnGroup;
        {_x moveInCargo _veh} forEach units _grp2;

		// CUSTOM CAMO STUFF
		if (_apc_camo != "") then {
			[
			_veh,
			[_apc_camo,1]
			] call BIS_fnc_initVehicle;
		};

		// Gear
		{0 = [_x] spawn _gear;} foreach units _grp;
		{0 = [_x] spawn _gear;} foreach units _grp2;

		// REMOVE AMMO
		{
			_veh removeMagazines _x;
		} forEach _ammoBlacklist;

        // Orders
        _wp = _grp addWaypoint [_pos,0];
        _wp setWaypointType "GUARD";
        //_grp setBehaviour _beh;
        0 = [_grp] spawn a2k_fnc_taskUpdateWP;

		waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1 OR !alive _veh OR {alive _x} count units _grp2 < 1};
		waitUntil {sleep 1; !(position (vehicle leader _grp) isFlatEmpty [-1, -1, -1, -1, 0, false] isEqualTo []);};
		doStop driver _veh;
		doGetOut units _grp2;
		_grp2 leaveVehicle _veh;
		waitUntil {sleep 1; speed _veh == 0  OR {alive _x} count units _grp < 1 OR !alive _veh OR {alive _x} count units _grp2 < 1};
		_wp2 = _grp2 addWaypoint [getPos _veh,0];
        _wp2 setWaypointType "GUARD";
		0 = [_grp2] spawn a2k_fnc_taskAssault;
		{_x disableAI "AUTOCOMBAT"} forEach units _grp2;
		_grp2 setBehaviour "AWARE";
		sleep 15;
		driver _veh doFollow leader _grp;
		//_veh limitSpeed 20;
      };
      case "TANK": {
        // Vehicle options
        if (50 > random 100) then {_veh allowCrewInImmobile true;};
		_veh setVehicleLock "LOCKEDPLAYER";

        // Select and spawn infantry
        _type = _vehicleCrew;
        _grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh} forEach units _grp;

        //Select and spawn crew
        //_crewFiller = [_veh, _grp, false, "",_Vehicle_Crew] call BIS_fnc_spawnCrew;

		// CUSTOM CAMO STUFF
		if (_tank_camo != "") then {
			[
			_veh,
			[_tank_camo,1]
			] call BIS_fnc_initVehicle;
		};

		// Gear
		{0 = [_x] spawn _gear;} foreach units _grp;

		// REMOVE AMMO
		{
			_veh removeMagazines _x;
		} forEach _ammoBlacklist;

        // Orders
        _wp = _grp addWaypoint [_pos,0];
        _wp setWaypointType "GUARD";
        _grp setBehaviour _beh;
        0 = [_grp] spawn a2k_fnc_taskUpdateWP;
      };
      case "HELITRANSPORT":
      {
        // Vehicle options
        _veh setVehicleLock "LOCKEDPLAYER";

        // Select and spawn infantry
        _type = _heliCrew;
        _grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh} forEach units _grp;

        // Select and spawn infantry
        _type2 = selectRandom _squad;
        _grp2 = [_pos,_spawnSide,_type2] call BIS_fnc_spawnGroup;
        {_x moveInCargo _veh} forEach units _grp2;

		// CUSTOM CAMO STUFF
		if (_heli_transport_camo != "") then {
			[
			_veh,
			[_heli_transport_camo,1]
			] call BIS_fnc_initVehicle;
		};

		// Gear
		{0 = [_x] spawn _gear;} foreach units _grp;
		{0 = [_x] spawn _gear;} foreach units _grp2;

		// REMOVE AMMO
		{
			_veh removeMagazines _x;
		} forEach _ammoBlacklist;

        // Orders
        _wp = _grp addWaypoint [_pos,0];
        _wp setWaypointType "GUARD";
        //_grp setBehaviour _beh;
        0 = [_grp] spawn a2k_fnc_taskUpdateWP;

		waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1 OR !alive _veh OR {alive _x} count units _grp2 < 1};
		doGetOut units _grp2;
		_grp2 leaveVehicle _veh;
		waitUntil {sleep 1; isTouchingGround _veh OR {alive _x} count units _grp < 1 OR !alive _veh OR {alive _x} count units _grp2 < 1};
		_wp2 = _grp2 addWaypoint [getPos leader _grp2,0];
        _wp2 setWaypointType "GUARD";
		{_x disableAI "AUTOCOMBAT"} forEach units _grp2;
		0 = [_grp2] spawn a2k_fnc_taskAssault;
      };
      case "HELIATTACK":
      {
        // Vehicle options
		_veh setVehicleLock "LOCKEDPLAYER";

        //Select and spawn crew
        _crewFiller = [_veh, _grp, false, "",_Heli_Pilot] call BIS_fnc_spawnCrew;

		// CUSTOM CAMO STUFF
		if (_heli_attack_camo != "") then {
			[
			_veh,
			[_heli_attack_camo,1]
			] call BIS_fnc_initVehicle;
		};

		// Gear
		{0 = [_x] spawn _gear;} foreach units _grp;

		// REMOVE AMMO
		{
			_veh removeMagazines _x;
		} forEach _ammoBlacklist;

        // Orders
        _wp = _grp addWaypoint [_pos,0];
        _wp setWaypointType "GUARD";
        _grp setBehaviour _beh;
        0 = [_grp] spawn a2k_fnc_taskUpdateWP;
      };
      default {
        // Crew it
        _type = SelectRandom _team;
        _grp = [_pos,_spawnSide,_type] call BIS_fnc_spawnGroup;
        _grp addVehicle _veh;
        {_x moveInAny _veh} forEach units _grp;

		// Gear
		{0 = [_x] spawn _gear;} foreach units _grp;

		// REMOVE AMMO
		{
			_veh removeMagazines _x;
		} forEach _ammoBlacklist;
        
        // Orders
        _wp = _grp addWaypoint [_pos,0];
        _wp setWaypointType "GUARD";
		0 = [_grp] spawn a2k_fnc_taskUpdateWP;

		waitUntil {sleep 1; behaviour leader _grp == "COMBAT" OR {alive _x} count units _grp < 1 OR !alive _veh};
        0 = [_grp] spawn a2k_fnc_taskAssault;
     }; 
    };

    // Wait until dead
	waitUntil {sleep 1; {alive _x} count units _grp < 1 OR !alive _veh};
    
    // Wait to respawn
    sleep _respawnTime;
  };
};

// END ----------------------------------------------------------------------