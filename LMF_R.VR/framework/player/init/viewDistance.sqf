// VIEW DISTANCE CBA SETTINGS /////////////////////////////////////////////////////////////////////
/*
	- This file is included in the XEH_preInit.sqf. It adds CBA settings that handle view distance behaviour.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
[
	"lmf_overwrite_viewDistanceCap"
	,"SLIDER"
	,["Air Viewdistance","This will set the desired Viewdistance while being in air vehicles."]
	,["LMF Viewdistance Cap","Basic"]
	,[200,var_airMax,round (var_airMax*0.90),0]
	,false
	,{
		params["_value"];
    	lmf_overwrite_viewDistanceCap = _value;
		[] call lmf_player_fnc_viewDistanceEH;
	}
] call CBA_Settings_fnc_init;

[
	"lmf_overwrite_objectViewDistanceCap"
	,"SLIDER"
	,["Air Object Viewdistance","This will set the desired object Viewdistance while being in air vehicles."]
	,["LMF Viewdistance Cap","Basic"]
	,[200,var_airMaxObj,round (var_airMaxObj*0.80),0]
	,false
	,{
		params["_value"];
    	lmf_overwrite_objectViewDistanceCap = _value;
		[] call lmf_player_fnc_viewDistanceEH;
	}
] call CBA_Settings_fnc_init;