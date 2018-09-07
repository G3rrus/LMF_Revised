// Mortar Attack script
// v1.2
// by nkenny


/*
v1.1 Added support for other artillery
v1.2 Small updated to flow

  Precreates a trigger and runs code: 0 = [thisList,thisTrigger] execVM "base\f\ai\fn_MortarAttack.sqf";
  
  Script:
    1. Enemylist + Identify trigger
    2. Find nearest Mortar
    3. Initiate attack 4-8 rounds
        - Randomized 
    4. End
      - Delete trigger if no mortar! 
*/

// 1. INIT 
_targets = Param [0]; // enemy array
_trigger = Param [1]; 

// 2. NEAREST MORTAR
_mortar = nearestobjects [(getpos _trigger),["StaticMortar","StaticCannon","O_MBT_02_base_F","O_T_MBT_02_arty_ghex_F"],75]; 

if (count _targets < 1) exitWith {if (var_debug) then {Systemchat "DEBUG: Mortar has no targets";};};
if (count _mortar < 1) exitWith {if (var_debug) then {Systemchat "DEBUG: Mortar not found"; deletevehicle _trigger};};
if (!alive gunner (_mortar select 0)) exitWith {if (var_debug) then {Systemchat "DEBUG: Mortar Dead!"};};


// 3. INITIATE ATTACK
_rounds = 2 + floor(random 2);
_target = SelectRandom _targets;

// Debug
if (var_debug) then {
  systemchat format ["DEBUG: Mortar - %1 rounds %2 target %3",gunner (_mortar select 0),_rounds,name _target];
};

for "_i" from 1 to _rounds do {
  // Give Round
  (_mortar select 0) setVehicleAmmoDef 1;

  // Target + accuracy
  _center = getpos _target;
  _accuracy = 80; 
  
  // Randomize target location
  _pos = [
    (_center select 0) - _accuracy + (2 * random _accuracy), 
    (_center select 1) - _accuracy + (2 * random _accuracy),
    0
  ];
    
  // Fire round
  (_mortar select 0) commandArtilleryFire [_pos,	getArtilleryAmmo [(_mortar select 0)] select 0,1];
  
  // Debug
  //if (var_debug) then {0 = [_pos,format["Mortar target %1",_i],"colorIndependent"] call nk_fnc_DotMarker}; 
  
  // Waituntil
  waitUntil {unitReady (_mortar select 0)};

}; 

// 4. END
true