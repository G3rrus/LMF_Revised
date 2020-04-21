// AI FIND COVER //////////////////////////////////////////////////////////////////////////////////
/*
	* Author: diwako
	* Returns position and stance of closest possible cover location.
    *
	* Arguments:
	* 0: Unit <OBJECT>
    * 1: Enemy Position <MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION>
    * 2: Range to find Cover <NUMBER>
    * 3: Cover sort mode <STRING> Supported modes are: "ASCEND", "DESCEND" or "RANDOM"
	*
	* Example:
	* [cursorObject, player, 50, "ASCEND"] call lmf_ai_fnc_findCover;
	*
	* Return Value:
	* <ARRAY> in format [_posAGL,_stance], when no cover is found empty array is returned instead
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params [
    ["_unit",objNull,[objNull]],
    ["_enemy",objNull,[objNull,grpNull,"",locationNull,taskNull,[],123]],
    ["_range",15,[123]],
    ["_sortMode","ASCEND",[""]]
];

private _ret = [];
private _dangerPos = (_enemy call CBA_fnc_getPos) vectorAdd [0, 0, 1.8];


// FIND COVER POS /////////////////////////////////////////////////////////////////////////////////
if !(_dangerPos isEqualTo [0, 0, 1.8]) then {
    _dangerPos = AGLToASL _dangerPos;
    private _terrainObjects = nearestTerrainObjects [_unit, ["BUSH", "TREE", "SMALL TREE", "HIDE", "BUILDING"], _range, false, true];
    private _vehicles = nearestObjects  [_unit, ["building", "Car"], _range];
    private _allObjs = [];

    //GETPOS BY SORTMODE
    if(_sortMode isEqualTo "ASCEND" || {_sortMode isEqualTo "DESCEND"}) then {
        _allObjs = [_terrainObjects + _vehicles, [], {_unit distance2D _x}, _sortMode] call BIS_fnc_sortBy;
    } else {
       _allObjs = (_terrainObjects + _vehicles) call BIS_fnc_arrayShuffle;
    };

    private _found = false;
    private _obj = objNull;
    private _pos = [];
    private _posASL = [];
    private _buildingPos = [];

    while {!_found && {!(_allObjs isEqualTo [])}} do {
        _obj = _allObjs deleteAt 0;
        _buildingPos = [_obj, 5] call CBA_fnc_buildingPositions;
        if (_buildingPos isEqualTo []) then {
            (boundingBox _obj) params ["_boundA", "_boundB"];
            _pos = (getPos _obj) vectorAdd (selectRandom [_boundA, _boundB]);
            //NO BUILDING POS?, SO IT'S EITHER VEGETATION OR BUILDING WITHOUT POS
            //SET BUILDING POS TO 0 TO AVOID IT BEING RIGHT ABOVE THE OBJECT
            _pos set [2, 0.1];
            _buildingPos = [_pos];
        };

        {
            if !(_ret isEqualTo []) exitWith {};
            if ((_dangerPos distance2d _x) > 20) then {
                _pos = _x;
                _posASL = AGLToASL _x;

                //CHECK DOWN POS
                if (lineIntersects [_dangerPos, _posASL vectorAdd [0, 0, 0.1], _unit]) exitWith {
                    private _stances = ["DOWN"];
                    //CHECK MIDDLE POS
                    if (lineIntersects [_dangerPos, _posASL vectorAdd [0, 0, 1], _unit]) then {
                        _stances pushBack "MIDDLE";
                        //CHECK UP POS
                        if (lineIntersects [_dangerPos, _posASL vectorAdd [0, 0, 1], _unit]) then {
                            _stances pushBack "UP";
                        };
                    };
                    _ret = [_pos, selectRandom _stances];
                    _found = true;
                };
            };
        } forEach _buildingPos;
    };
};

//DEBUG
if (var_debug && {!(_ret isEqualTo [])}) then {
    private _stance = _ret select 1;
    systemChat format ["DEBUG Find Cover: Found cover %1m away for stance %2", _unit distance (_ret select 0), _stance];
    createVehicle ["Sign_Arrow_Large_F", (_enemy call CBA_fnc_getPos) vectorAdd [0, 0, 1.8], [], 0, "CAN_COLLIDE"];
    private _add = if ((_stance) isEqualTo "UP") then {
        2
    } else {
        if ((_stance) isEqualTo "MIDDLE") then {
            1
        } else {
            0.2
        };
    };
    createVehicle ["Sign_Arrow_Large_Blue_F", (_ret select 0) vectorAdd [0, 0, _add], [], 0, "CAN_COLLIDE"];
};


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_ret