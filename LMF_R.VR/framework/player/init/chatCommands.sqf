// CHAT COMMANDS //////////////////////////////////////////////////////////////////////////////////
/*
	Adds various CBA chat commands to player/registered admins.
	Originally made by cuel, altered by G4rrus.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
//CHAT MESSAGE CHANNEL EVENT HANDLER
["lmf_chatMessage", {
    params ["_sender", "_msg", "_type", "_receiver", ["_ping", true]];

    private _args = switch (toLower _type) do {
        case "zeus": {
            [{!(profileName isEqualTo _sender) && !isNull (getAssignedCuratorLogic player)}, format ["(Zeus) %1:", _sender]];
        };
        case "whisper": {
            [{profileName isEqualTo _receiver}, format ["Whisper from %1:", _sender]];
        };
        default {
            [{true}, format ["Notice (%1):", _sender]];
        };
    };
    _args params ["_condition", "_text"];

    if ([] call _condition) then {
        lmf_chatChannel radioChannelAdd [ACE_player];
        lmf_chatChannel radioChannelSetCallsign _text;
        ACE_player customChat [lmf_chatChannel, _msg];
        lmf_chatChannel radioChannelRemove [ACE_player];
        playSound "3DEN_notificationWarning";
    };
}] call CBA_fnc_addEventHandler;

//ADMIN COMMANDS
["heal", {
	params [["_name", ""]];
	private _unit = _name call lmf_player_fnc_getPlayer;
	if (isNull _unit) exitWith {systemChat "Could not find unit"};

	[_unit] call ace_medical_treatment_fnc_fullHealLocal;
	_unit setDamage 0;
	systemChat format ["Fully healed %1.", name _unit];
}, "admin"] call CBA_fnc_registerChatCommand;

["heal.all", {
    {
	    [_x] call ace_medical_treatment_fnc_fullHealLocal;
	    _x setDamage 0;
    } forEach ([] call CBA_fnc_players);
	systemChat "Fully healed everyone.";
}, "admin"] call CBA_fnc_registerChatCommand;

["goto", {
	params [["_name", ""]];
	private _unit = _name call lmf_player_fnc_getPlayer;
	if (isNull _unit) exitWith {systemChat "Could not find unit"};

	moveOut ACE_player;
	ACE_player setPos (_unit modelToWorld [0, -2, 0]);
	systemChat format ["Teleported to %1.", name _unit];
}, "admin"] call CBA_fnc_registerChatCommand;

["bring", {
	params [["_name", ""]];
	private _unit = _name call lmf_player_fnc_getPlayer;
	if (isNull _unit) exitWith {systemChat "Could not find unit"};

	moveOut _unit;
	_unit setVelocity [0,0,0];
	_unit setPos (ACE_player modelToWorld [0, 1, 0]);
	systemChat format ["Teleported %1 to you.", name _unit];
}, "admin"] call CBA_fnc_registerChatCommand;

//CLIENT COMMANDS
["w", {
    params [["_str", ""]];
    private _split = (_str splitString " ");
    private _to = _split param [0, ""];
    _split deleteAt 0;
    private _msg = _split joinString " ";
    if (_to isEqualTo "" || _msg isEqualTo "") exitWith {systemChat "Invalid arguments"};

    private _receiver = [_to] call lmf_player_fnc_getPlayer;
    if (isNull _receiver) exitWith {systemChat "Could not find receiver"};
    [_msg, "whisper", name _receiver] call lmf_player_fnc_sendChatMessage;
}, "all",false] call CBA_fnc_registerChatCommand;

["zeus", {
    params [["_msg", ""]];
    _msg = [_msg] call CBA_fnc_trim;
    if (_msg isEqualTo "") exitWith {};
    [_msg, "zeus"] call lmf_player_fnc_sendChatMessage;
}, "all",false] call CBA_fnc_registerChatCommand;