// Tracker script
// version 3.5
// by nkenny (mangled by Alex2k) (sprinkled by diwako)


// 1. FIND TRACKER
params [["_grp",grpNull,[grpNull]],["_range",500,[0]]];
private _cycle = 30;

// 2. SET DEFAULT BEHAVIOR
_grp setBehaviour "SAFE";

// 3. DO THE HUNT SCRIPT!
while {count units _grp > 0} do
{
  private _tracker = leader _grp;
  private _nearestdist = _range;
  private _availabletargets = (switchableUnits + playableUnits - entities "HeadlessClient_F");
  private _nearest = objNull;

  // 3a. CHOOSE CLOSEST PLAYER
  {
    private _dist = vehicle _x distance2D _tracker;
    if ((_dist < _nearestdist) && {(side _x != civilian) && {((getposATL _x)#2 < 25) && isPlayer _x}}) then
    {
      _nearest = _x;
      _nearestdist = _dist;
    };
  } forEach _availabletargets;

  // 3.b GIVE ORDERS
  if (!isNull _nearest) then
  {
    private _units = units _grp;
    {
      private _p = getposATL _nearest;
      private _no = _nearestdist/4;
      private _rp = [(_p#0) - (_no/2) + random _no, (_p#1) - (_no/2) + random _no, _p#2];
      _x doMove _rp;
      _x disableAI "AUTOCOMBAT";
      false
    } count _units;

    _grp setBehaviour "AWARE";
    _grp setSpeedMode "FULL";

    _cycle = _nearestdist/8;
    // DEBUG
    if (var_debug) then {systemChat format ["DEBUG: taskHunt: %1 targets %2 (%3) at %4 Meters",_grp,name _nearest,_grp knowsAbout _nearest,floor (leader _grp distance _nearest)]};
  }
  else
  {
    _cycle = 120
  };

  // WAIT FOR IT!
  _cycle = _cycle min 300;
  _cycle = _cycle max 30;
  sleep _cycle;
};