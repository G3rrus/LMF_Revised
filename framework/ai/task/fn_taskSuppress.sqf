// Suppressive fire script
// v1.0
// by nkenny -- Heavily inspired by Big_Wilk

/*
  1. Sort units
  2. Sort positions
  3. Execute
  4. end

  Parameters
  _u = Aray : Units doing the shooting
  _p = Array : Targets being hit
  _t = number : time being fired
  _a = Boolean : Endless ammo true/false

*/

// function
_do_fire_vic =
  {
  _v = _this param [0];
  _g = _this param [1];
  for "_i" from 0 to 10 do
    {
    _v fire [_g,"Close"];
    };
  };

// init

_u = param [0, []];
_p = param [1,[]];
_t = param [2, 10];
_a = param [3,false];
_fm = param [4];
_t2 = _t + time;
_Zzz = 0.1;

// Checkit
if (count _u < 1 || count _p < 1) exitWith {Systemchat format ["DEBUG Suppression: No Units(%1) OR No targets(%2)",count _u,count _p]};
if (!local (_u select 0)) exitWith {};

// Targets
_p2 = [];
{
  if (str (getpos _x) != "[0,0,0]") then
    {
      _p2 pushback (getPosATL _x);
      _p2 pushback (_x getpos [random 6,random 360]);
      _p2 pushback (_x getpos [(random 6) * -1,random 360]);
    };
} foreach _p;
{_x set [2,(_x select 2) + random 0.5]} foreach _p2;

// Vehicles, groups and men
_man = [];
_vic = [];
{
  private "_unit";
  _unit = _x;
  switch (typeName _unit) do {
    case "GROUP": {_man append (units _unit);};
    default {if (_unit isKindOf "Man") then {_man pushback _unit;_unit doWatch (selectRandom _p2);} else {_vic pushback [_unit,selectRandom ((_unit weaponsTurret [1]) + (_unit weaponsturret [0]))]};};
  };
} foreach _u;

// Debug
if (var_debug) then
  {
  //systemchat str _man;
  //systemchat str _vic;
  {_veh = "Sign_Arrow_Large_Blue_F" createVehicle _x;_veh enableSimulation false;} foreach _p2;
  };

// Get infantry on point
{
  (group _x) SetFormDir (_x getDir (_p2 select 0));
  _x doTarget (selectRandom _p);
  _x setVariable ["var_isSuppressing",true];
  //_x setBehaviour "COMBAT";
  doStop _x;
  _x disableAI "PATH";
} foreach _man;
sleep 0.1;

// EXECUTE -----------------------------------------------
while {time < _t2} do
  {
    // all the king's men
    {
      if (alive _x) then
      {
        if (_a) then {_x setAmmo [primaryWeapon _x, 100]};
        _x doWatch (selectRandom _p2);
        _x forceWeaponFire [(primaryWeapon _x), _fm];
      } else {_man = _man - [_x];};
    } foreach _man;

    // all the king's horses
    {
      if (alive (_x select 0) && canfire (_x select 0)) then
      {
       if (_a) then {(_x select 0) setVehicleAmmo 1;};
       gunner (_x select 0) doWatch (selectRandom _p2);
       (_x select 0) action ["useWeapon", (_x select 0), gunner (_x select 0),1];
       [_x select 0,_x select 1] spawn _do_fire_vic;

	   gunner (_x select 0) disableAI "TARGET";
	   (_x select 0) limitSpeed 10;
      };
    } foreach _vic;

   // Zzz
   sleep _Zzz;
  };

// ------------------------------------------------------

// Reset infantry
{
  _x setVariable ["var_isSuppressing",false];
  //_x setBehaviour "AWARE";
  _x doFollow leader group _x;
  _x enableAI "PATH";
  if (var_debug) then {systemchat format ["%1 is ready (%2s)",name _x,_t];};
} foreach _man;

// Reset vehicle
{
	gunner (_x select 0) enableAI "TARGET";
	(_x select 0) limitSpeed -1;
} foreach _vic;


// end
true