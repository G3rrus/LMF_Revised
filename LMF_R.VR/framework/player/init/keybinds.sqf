// FRAMEWORK CBA KEYBINDS /////////////////////////////////////////////////////////////////////////
/*
	- File gets included in pre-init. Adds keybinds to addon controls that do a bunch of useful stuff.
*/
// INIT ///////////////////////////////////////////////////////////////////////////////////////////
lmf_acreToggle = true;
[
	"LMF Revised",
	"toggle_spec_key",
	"Toggle ACRE Spectator",
	{[] call lmf_player_fnc_toggleSpectator},
	{},
	[0x1A,[true,false,false]] // SHIFT + DIK_LBRACKET
] call CBA_fnc_addKeybind;

[
	"LMF Revised",
	"enter_spec_remote",
	["Spectator Take Control","Remote control the spectated unit."],
	{},
	{},
	[0x1B,[true,false,false]] // SHIFT + DIK_RBRACKET
] call CBA_fnc_addKeybind;