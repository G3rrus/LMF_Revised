// CBA SETTINGS ///////////////////////////////////////////////////////////////////////////////////
/*
	- File to define settings handled by CBA, could be from various mods such as ACE3, ACRE2 etc.,
	  but also from scripted components like Diwakos punish-unknown-weapons.
	  It is important to note that some settings might be overwritten by whatever server you might
	  play your mission on.
*/
///////////////////////////////////////////////////////////////////////////////////////////////////



// RECOMMENDED ////////////////////////////////////////////////////////////////////////////////////
// ACE Mk6 Mortar
force force ace_mk6mortar_useAmmoHandling = false; // Keep this if you want fn_mortarAttack.sqf to work

// TFAR - Global settings
force TFAR_giveLongRangeRadioToGroupLeaders = false; // Already given by Loadout
force TFAR_giveMicroDagrToSoldier = false; // Already given by Loadout
force TFAR_givePersonalRadioToRegularSoldier = false; // Already given by Loadout
force tfar_radioCodesDisabled = true; // Not a TvT Framework, hence same Encryption
force TFAR_SameLRFrequenciesForSide = true; // Important for accurate radio preset and Signals Briefing
force TFAR_SameSRFrequenciesForSide = true; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_lr_east = "31,32,33,34,35,36,37,38,39"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_lr_independent = "31,32,33,34,35,36,37,38,39"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_lr_west = "31,32,33,34,35,36,37,38,39"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_sr_east = "31,101,102,103,104,105,106,107,108"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_sr_independent = "31,101,102,103,104,105,106,107,108"; // Important for accurate radio preset and Signals Briefing
force TFAR_setting_defaultFrequencies_sr_west = "31,101,102,103,104,105,106,107,108"; // Important for accurate radio preset and Signals Briefing