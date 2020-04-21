// SEND CHAT MESSAGE //////////////////////////////////////////////////////////////////////////////
/*
	* Author: cuel, G4rrus
	* URL: https://github.com/fparma/fparma-mods/blob/master/addons/common/functions/fnc_sendChatMessage.sqf
	* Sends chat message to target.
	* Note: Needs to be local to player.
	*
	* Arguments:
	* 0: Message <STRING>
	* 1: Type <STRING> possible cases are "zeus" or "whisper" else defaults to "Chat:"
	* 2: Receiver <OBJECT>
	*
	* Example:
	* ["Test","whisper",player] call lmf_player_fnc_sendChatMessage;
	*
	* Return Value:
	* <BOOL> true on success else false.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
params ["_msg","_type","_receiver"];

if (isNil "lmf_chatChannel") exitWith {false};


// SEND IT ////////////////////////////////////////////////////////////////////////////////////////
private _callsign = switch (toLower _type) do {
	case "zeus": {"to Zeus:"};
	case "whisper": {format ["Whisper to %1:", _receiver]};
	default {"Chat:"};
};

lmf_chatChannel radioChannelAdd [player];
lmf_chatChannel radioChannelSetCallsign _callsign;
player customChat [lmf_chatChannel, _msg];
lmf_chatChannel radioChannelRemove [player];

["lmf_chatMessage",[profileName, _msg, _type, _receiver]] call CBA_fnc_globalEvent;

playSound "3DEN_notificationDefault";


// RETURN /////////////////////////////////////////////////////////////////////////////////////////
true