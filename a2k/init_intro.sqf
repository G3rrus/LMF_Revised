

if (var_debug) exitWith {};


nk_fnc_timemagic = {
  private ["_n"];
  _n = _this select 0; 
  if (_n < 10) then {_n = format ["0%1",_n]};
  _n
};


// INTRO START ////////////////////////////////////////////////////////////////////////////////////
if (hasInterface) then 
{
    [] Spawn
    {
		player enableSimulation false;

		cutText  ["", "BLACK FADED", 10, true];
		sleep 12;
		cutText ["", "BLACK IN", 10, true];

		player enableSimulation true;


		/*
		// MISSION INTRO
		[
			[
				[format ["%1", var_name],"align = 'center' shadow = '1' size = '1.3' font='PuristaBold'"],
				["","<br/>"],
				//[format ["• "],"align = 'center' shadow = '1' size = '0.65' font='PuristaMedium'","#D6D6D6"],
				[format ["by: "],"align = 'center' shadow = '1' size = '0.55' font='PuristaBold'","#D6D6D6"], 
				[format ["%1", var_author],"align = 'center' shadow = '1' size = '0.55' font='PuristaBold'",var_randomColor],
				//[format [" •"],"align = 'center' shadow = '1' size = '0.65' font='PuristaMedium'","#D6D6D6"],
				["","<br/>"]
			],safeZoneX+0.0,safeZoneY+0.8 
		] spawn BIS_fnc_typeText2;
		*/


/*		
		_time = format ["%1:%2",[date select 3] call nk_fnc_timemagic,[date select 4] call nk_fnc_timemagic];
		[
			[
				[(var_name),"<t align = 'Right' shadow = '1' size = '0.7' font='PuristaBold'>%1</t><br/>"],
				[("Location: " + getText (configfile >> "CfgWorlds" >> worldname >> "description")),"<t align = 'Right' shadow = '1' size = '0.7'>%1</t><br/>"],
				[("Time: " + _time),"<t align = 'Right' shadow = '1' size = '0.7'>%1</t>",40]
			], 0.5, 0.8
		] spawn BIS_fnc_typeText;
*/

	};
};