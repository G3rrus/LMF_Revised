
if (getMarkerColor "respawn" != "") then {
	_rspMkr = createMarker ["mrk_respawn_inf", getMarkerPos "respawn"];
	_rspMkr setMarkerType "respawn_inf";
	_rspMkr setMarkerSize [0.75,0.75];
	_rspMkr setMarkerColor "ColorBlack";
	_rspMkr setMarkerText "";
	_rspMkr setMarkerAlpha 1;
	
	"respawn" setMarkerAlpha 0;
	};

if !(isNil "crate_gearPlthq") then {
	_gearSelectMkr = createMarker ["mrk_gearSelect", getPos crate_gearPlthq];
	_gearSelectMkr setMarkerType "o_installation";
	_gearSelectMkr setMarkerSize [0.75,0.75];
	_gearSelectMkr setMarkerColor "ColorWEST";
	_gearSelectMkr setMarkerText "";
	_gearSelectMkr setMarkerAlpha 1;
	};

if !(isNil "ammoSpawner") then {
	_crateSpawnMkr = createMarker ["mrk_crateSpawn", getPos ammoSpawner];
	_crateSpawnMkr setMarkerType "o_service";
	_crateSpawnMkr setMarkerSize [0.75,0.75];
	_crateSpawnMkr setMarkerColor "ColorEAST";
	_crateSpawnMkr setMarkerText "";
	_crateSpawnMkr setMarkerAlpha 1;
	};

if !(isNil "vehSpawner") then {
	_vehSpawnMkr = createMarker ["mrk_vehSpawn", getPos vehSpawner];
	_vehSpawnMkr setMarkerType "o_service";
	_vehSpawnMkr setMarkerSize [0.75,0.75];
	_vehSpawnMkr setMarkerColor "ColorEAST";
	_vehSpawnMkr setMarkerText "";
	_vehSpawnMkr setMarkerAlpha 1;
	};

if !(isNil "RRR") then {
	_RRRMkr = createMarker ["mrk_RRR", getPos RRR];
	_RRRMkr setMarkerType "o_maint";
	_RRRMkr setMarkerSize [0.75,0.75];
	_RRRMkr setMarkerColor "ColorEAST";
	_RRRMkr setMarkerText "RRR";
	_RRRMkr setMarkerAlpha 1;
	};

if !(isNil "LAMBS_Hospital") then {
	_HospMkr = createMarker ["mrk_hospital", getPos LAMBS_Hospital];
	_HospMkr setMarkerType "o_med";
	_HospMkr setMarkerSize [0.75,0.75];
	_HospMkr setMarkerColor "ColorEAST";
	_HospMkr setMarkerText "";
	_HospMkr setMarkerAlpha 1;
	};