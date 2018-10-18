// XEH PRE INIT ///////////////////////////////////////////////////////////////////////////////////
/*
	- File that handles what happens pre init.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
#include "..\settings\cfg_Mission.sqf"

var_versionLMF = "re_0.50";
var_randomColor = selectRandom ["#F09595","#F095E4","#BC95F0","#95C7F0","#95EEF0","#95F0CA","#A9F095","#D6F095","#F0F095","#F0C495"];
var_name = briefingName; // Name of the mission. (3DEN > Attributes > General > Title)