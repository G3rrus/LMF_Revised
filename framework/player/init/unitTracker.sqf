// Ultra simple vehicle tracker script
// version 1.55
// by nkenny

/*
version 1.0
- Inception

version 1.1
- Added support for single soldiers
- Update list periodically

version 1.2
- Tweaked range
- Removed X for dead units

version 1.3
- Check if marker is made already?

version 1.4
- 'nil' markers removed!
- Gave markers "nk_m_" prefix

version 1.5
- Added variables for cohesion and distance
- Added variable for update frequency

version 1.55
- Tweaked Removed group distance modifier

version 1.6
- Is now tuned to groups.
- Alpha change based on distance removed
- Extended range of vehicles which are automatically detected
- New marker deletion system

version 1.7
- updated script to be simpler and faster


*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if (!hasinterface) exitWith {};
waitUntil {time > 0};

nk_tracklist = [];



// ADD PLAYERS CYCLE //////////////////////////////////////////////////////////////////////////////
[] spawn {
	private _nk_addUnitMarker =  {
		private _unit = _this select 0;
		private _marker = createMarkerLocal ["nk_m_"+str(_unit),getposASL _unit];
 		_marker setMarkerShapeLocal "Icon";
		_marker setMarkerColorLocal var_markerSide;
  		_marker setMarkerTypeLocal "mil_dot_noshadow";
		_marker setmarkerSizeLocal [0.4,0.4];

  		// Add to list
  		nk_tracklist pushbackunique _unit;
 	};
    while {true} do {
        {
            if (_x in nk_tracklist) then {} else {0 =[_x,""] call _nk_addUnitMarker;};
            false
        } count (playableunits + switchableunits - entities "Headless_F");
        sleep 20;
    };
};



// TRACKING MAGIC /////////////////////////////////////////////////////////////////////////////////

while {true} do {
    waitUntil {count nk_tracklist > 0};

//UPDATE VEHICLE LOCATIONS
	{
		private _marker = ("nk_m_"+ str(_x));
		_marker setmarkerposlocal getposASL _x;
		// delete if dead or missing
        if (isNull _x) then {
			nk_tracklist = nk_tracklist - [_x];
			deleteMarkerLocal _marker;
		};
    false
    } count nk_tracklist;
    uisleep 1;
};