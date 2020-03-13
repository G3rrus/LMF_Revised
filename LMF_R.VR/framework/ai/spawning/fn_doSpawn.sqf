// CALL AI SPAWNING FUNCTION FUNCTION  ////////////////////////////////////////////////////////////
/*
	- This function handles which AI spawning function shall be called.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_args"];

private _typeOfSpawn = toLower (_args select 0);
private _parArray = _args;
_parArray deleteAt 0;

switch (_typeOfSpawn) do {
	case "garrison": {_parArray spawn lmf_ai_fnc_garrison;};
	case "hunter": {_parArray spawn lmf_ai_fnc_infantryHunter;};
	case "qrf": {_parArray spawn lmf_ai_fnc_infantryQRF;};
	case "patrol": {_parArray spawn lmf_ai_fnc_patrol;};
	case "para": {_parArray spawn lmf_ai_fnc_paraQRF;};
	case "vicqrf": {_parArray spawn lmf_ai_fnc_vehicleQRF;};
};