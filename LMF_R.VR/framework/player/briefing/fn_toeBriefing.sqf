// TO/E BRIEFING SCRIPT ///////////////////////////////////////////////////////////////////////////
/*
	* Author: nkenny, G4rrus
	* Figure out player team composition and return it in formated text.
	* Note: Needs to be local to player.
	*
	* Arguments:
	* 0: <NONE>
	*
	* Example:
	* [] call lmf_player_fnc_toeBriefing;
	*
	* Return Value:
	* <STRING> formated text team composition
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
private _grp2 = grpNull;
private _brf_platoon = "";

{
	//GET INFO
	private _grp = group _x;
	private _id = groupID group _x;
	private _rank = toLower rank _x;
	private _role = roleDescription _x;
	private _name = name _x;
	if (_role find "@" >= 0) then {
		private _indexToAt = ([_role, "@"] call CBA_fnc_find) - 1;
		_role = [_role, 0, _indexToAt] call CBA_fnc_substring;
	};

	//IF NEW GROUP
	if (_grp != _grp2) then {
		_brf_platoon = _brf_platoon + "<br/><font face='PuristaBold' color='#A3E0FF'>" + _id + "<br/></font>";
	};

	//ENTRY FOR SOLDIER
	_brf_platoon = _brf_platoon + format ["<img image='\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa' width='16' height='16'/><font color='#D7DBD5'> %2: %3</font><br/>",_rank,_role,_name];

	//UPDATE OLD
	_grp2 = _grp;
} foreach (playableUnits + switchableUnits);

//REMOVE LAST LINEBREAK
_brf_platoon = _brf_platoon select [0,count _brf_platoon - 5];

// FORMAT TEXT ////////////////////////////////////////////////////////////////////////////////////
private _text = format ["
<br/><font face='PuristaBold' color='#FFBA26' size='16'>OVERVIEW</font><br/>
<font color='#D7DBD5'>
- Unit strength is <font color='#FFBA26'>%1<font color='#D7DBD5'> pax.<br/>
</font color>
%2
",count (switchableUnits + playableUnits - entities 'HeadlessClient_F'),_brf_platoon];


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
_text