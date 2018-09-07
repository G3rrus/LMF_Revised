/*
  Function:

  Description:
    Add CBA settings to editor and ingame

  Parameters:
  none

  Returns:
    nothing

  Author:
  diwako 2018-06-24
*/
#define CBA_SETTINGS_CAT "Punish unknown weapon"

[
  "diw_unknownwp_enable"
  ,"CHECKBOX"
  ,["Enable","Enable/Disable punishing unknown weapons"]
  ,[CBA_SETTINGS_CAT,"Basic"]
  ,false
  ,true
] call CBA_Settings_fnc_init;

[
  "diw_unknownwp_cooldown"
  ,"SLIDER"
  ,["Wait after mission begin","How long should the server wait in seconds to populate known weapons? Do not worry about JIPs, their weapons will be added as well once they connect!"]
  ,[CBA_SETTINGS_CAT,"Basic"]
  ,[1, 600, 60, 0]
  ,true
] call CBA_Settings_fnc_init;

[
  "diw_unknownwp_dispersion_add"
  ,"SLIDER"
  ,["Add weapon dispersion","This will add a flat value to dispersion"]
  ,[CBA_SETTINGS_CAT,"Basic"]
  ,[0, 200, 25, 0]
  ,true
] call CBA_Settings_fnc_init;

[
  "diw_unknownwp_jamchance_add"
  ,"SLIDER"
  ,["Add jam chance","This will add the selected percentage to the weapon"]
  ,[CBA_SETTINGS_CAT,"Basic"]
  ,[0, 100, 1.5, 2]
  ,true
] call CBA_Settings_fnc_init;

[
  "diw_unknownwp_reload_failure"
  ,"SLIDER"
  ,["Reload failure chance","Chance that the reload wil fail and leave an empty mag inside the gun"]
  ,[CBA_SETTINGS_CAT,"Basic"]
  ,[0, 100, 25, 0]
  ,true
] call CBA_Settings_fnc_init;

[
  "diw_unknownwp_jam_explosion"
  ,"SLIDER"
  ,["Chance to destroy weapon on jam","Chance that the unkown weapon will be destroyed and inflict small damage to player when it jams"]
  ,[CBA_SETTINGS_CAT,"Basic"]
  ,[0, 100, 2, 2]
  ,true
] call CBA_Settings_fnc_init;

[
  "diw_unknownwp_add_weapons"
  ,"EDITBOX"
  ,["Add more weapons","Use this to add primary weapons players will not have on mission start. Write in classnames with commas separating them, NO WHITESPACES!"]
  ,[CBA_SETTINGS_CAT,"Basic"]
  ,"arifle_Mk20_plain_F,arifle_CTAR_blk_F,hlc_rifle_g3a3v"
  ,true
] call CBA_Settings_fnc_init;

[
  "diw_unknownwp_briefing"
  ,"CHECKBOX"
  ,["Add briefing entry","Add a diary entry that this script is active"]
  ,[CBA_SETTINGS_CAT,"Basic"]
  ,true
  ,true
] call CBA_Settings_fnc_init;

[
  "diw_unknownwp_propagation"
  ,"CHECKBOX"
  ,["Enable propagation","Set if the server should sync trained weapons or not. Enables the 'Add more weapons' option!"]
  ,[CBA_SETTINGS_CAT,"Advanced"]
  ,true
  ,true
] call CBA_Settings_fnc_init;