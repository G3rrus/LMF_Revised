// ADD MURSHUN ACTIONS TO CBA ITEM CONTEXT MENU OPTIONS
//TAKE CIGARETTE FROM PACK
[
    "murshun_cigs_cigpack",
    "CONTAINER",
    (localize "STR_murshun_cigs_take_cig_from_pack"),
    nil,
    "murshun_cigs\UI\take_cig.paa",
    {true},
    {[(_this select 0)] spawn murshun_cigs_fnc_take_cig_from_pack},
    false,
    []
] call CBA_fnc_addItemContextMenuOption;

//CIGARETTE AND CIGAR
{
    //LIGHT
    [
        _x,
        "GOGGLES",
        (localize "STR_murshun_cigs_start_cig"),
        nil,
        "murshun_cigs\UI\light_cig.paa",
        [{true},{!((_this select 0) getVariable ['murshun_cigs_cigLitUp', false])}],
        {[(_this select 0)] spawn murshun_cigs_fnc_start_cig_your},
        false,
        []
    ] call CBA_fnc_addItemContextMenuOption;

    //PUT OUT
    [
        _x,
        "GOGGLES",
        (localize "STR_murshun_cigs_stop_cig"),
        nil,
        "murshun_cigs\UI\light_cig.paa",
        [{true},{((_this select 0) getVariable ['murshun_cigs_cigLitUp', false])}],
        {[(_this select 0)] spawn murshun_cigs_fnc_stop_cig},
        false,
        []
    ] call CBA_fnc_addItemContextMenuOption;
} forEach ["murshun_cigs_cig0","immersion_cigs_cigar0"];

//LOLLIPOP
[
    "immersion_pops_poppack",
    "CONTAINER",
    (localize "STR_immersion_pops_take_cig_from_pack"),
    nil,
    "immersion_pops\UI\take_cig.paa",
    {true},
    {[(_this select 0)] spawn immersion_pops_fnc_take_cig_from_pack},
    false,
    []
] call CBA_fnc_addItemContextMenuOption;

//LICK
[
    "immersion_pops_pop0",
    "GOGGLES",
    (localize "STR_immersion_pops_start_cig"),
    nil,
    "immersion_pops\UI\light_cig.paa",
    [{true},{!((_this select 0) getVariable ['immersion_pops_cigLitUp', false])}],
    {[(_this select 0)] spawn immersion_pops_fnc_start_cig_your},
    false,
    []
] call CBA_fnc_addItemContextMenuOption;

//STOP LICKING
[
    "immersion_pops_pop0",
    "GOGGLES",
    (localize "STR_immersion_pops_stop_cig"),
    nil,
    "immersion_pops\UI\light_cig.paa",
    [{true},{((_this select 0) getVariable ['immersion_pops_cigLitUp', false])}],
    {[(_this select 0)] spawn immersion_pops_fnc_stop_cig},
    false,
    []
] call CBA_fnc_addItemContextMenuOption;