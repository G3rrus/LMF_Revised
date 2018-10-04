// Function to handle the sorting of CAManBase related units


// select the Unit
private _var_Unit = _this select 0;

// exit if not local
if !(local _var_Unit) exitWith {};

//check what _Unit is and execute function accordingly
if  !(isPlayer _var_Unit) then {
	if (side group _var_Unit != var_enemySide) exitWith {};
    [_var_Unit] call drg_fnc_aiGear;
		if(!(isGroupDeletedWhenEmpty group _var_Unit)) then {
    		(group _var_Unit) deleteGroupWhenEmpty true;
		};
}
else {
    if( _var_Unit == player) then {
    	[_var_Unit] call drg_fnc_PlayerGear;
    };
};