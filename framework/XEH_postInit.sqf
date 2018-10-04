// THIS FILE HANDLES WHAT NEEDS TO HAPPEN POST INIT ///////////////////////////////////////////////

//CHANCE FOR AI TO WAKE UP
["ace_unconscious", {
    params [["_unit", objNull],["_state", false]];
    if (ace_medical_enableUnconsciousnessAI == 0 || {!_state || {!(local _unit) || {isPlayer _unit}}}) exitWith {};
    
    [_unit] spawn {
        params [["_unit", objNull]];
        while {alive _unit && {_unit getVariable ["ACE_isUnconscious", false]}} do {
            sleep 5;
            if (12.5 > random 100) then {
                [_unit, false] call ace_medical_fnc_setUnconscious;    
            };
            sleep 15;
        };
    };    
}] call CBA_fnc_addEventHandler;