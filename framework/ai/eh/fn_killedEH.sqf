// eventhandler function that handles gear removed on AI death (NVGs, Binos, Weapon Attachements)
params ["_unit"];
removeAllPrimaryWeaponItems _unit;
_unit unlinkItem "NVGoggles_OPFOR";
_unit removeWeapon "Binocular";