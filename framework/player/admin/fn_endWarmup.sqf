// END WARMUP /////////////////////////////////////////////////////////////////////////////////////
/*
	- Function to end warmup phase. This only works at least 10 seconds after mission start.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_unit"];

#include "cfg_admin.sqf"

//END WARMUP IF IT HAS NOT BEEN ENDED ALREADY
if (CBA_missionTime > 10) then {
	var_warmup = false;
	publicvariable "var_warmup";
};