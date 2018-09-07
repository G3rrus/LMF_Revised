// TEAM COLORS
// version 0.1
// by Alex2k

if (!hasInterface) exitWith {};
waitUntil {CBA_missionTime > 5};


_unitStr = str player;
if ((_unitStr find "_RED") != -1) then {
	player assignTeam "RED";
};

if ((_unitStr find "_BLUE") != -1) then {
	player assignTeam "BLUE";
};

if ((_unitStr find "_GREEN") != -1) then {
	player assignTeam "GREEN";
};

if ((_unitStr find "_YELLOW") != -1) then {
	player assignTeam "YELLOW";
};

if ((_unitStr find "_WHITE") != -1) then {
	player assignTeam "MAIN";
};
