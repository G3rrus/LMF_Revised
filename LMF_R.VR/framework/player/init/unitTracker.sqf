// UNIT TRACKER SCRIPT ////////////////////////////////////////////////////////////////////////////
/*
	- by nkenny (edited by Drgn V4karian with help of Diwako).
	- Function that handles markers to track individual player units.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
if !(hasinterface) exitWith {};
waitUntil {time > 1};

lmf_player_tracklist = [];


// ADD PLAYERS CYCLE //////////////////////////////////////////////////////////////////////////////
[] spawn {
    private _fnc_addUnitMarker =  {
        private _unit = _this select 0;
        private _marker = createMarkerLocal ["nk_m_"+str(_unit),getposASL _unit];
        _marker setMarkerShapeLocal "Icon";
        _marker setMarkerColorLocal "ColorBlack";
        _marker setMarkerTypeLocal "hd_start";
        _marker setmarkerSizeLocal [0.6,0.6];
        lmf_player_tracklist pushbackunique _unit;
    };
    while {true} do {
        {
            if (_x in lmf_player_tracklist) then {} else {0 =[_x,""] call _fnc_addUnitMarker;};
            false
        } count (units group player);
        sleep 60;
    };
};


// TRACKING MAGIC /////////////////////////////////////////////////////////////////////////////////
while {true} do {
    waitUntil {count lmf_player_tracklist > 0};
    {
        private _marker = ("nk_m_"+ str(_x));
        _marker setmarkerposlocal getposASL _x;
        _marker setMarkerDirLocal getDir _x;
        if (assignedTeam _x == "MAIN") then {_marker setMarkerColorLocal "ColorWhite"};
        if (assignedTeam _x == "RED") then {_marker setMarkerColorLocal "ColorRed"};
        if (assignedTeam _x == "GREEN") then {_marker setMarkerColorLocal "ColorGreen"};
        if (assignedTeam _x == "BLUE") then {_marker setMarkerColorLocal "ColorBlue"};
        if (assignedTeam _x == "YELLOW") then {_marker setMarkerColorLocal "ColorYellow"};
        if (isNull _x || {group _x != group player}) then {
            lmf_player_tracklist = lmf_player_tracklist - [_x];
            deleteMarkerLocal _marker;
        };
    } count lmf_player_tracklist;
    sleep 2;
};