// BRIEFING TXT
// version 1.7
// by nkenny

/*
USAGE: 
Simply edit the string or array in question to generate the mission briefing. Huzzah! 
*/


// BRIEFING MATERIAL ---------------------------------------

// Situation  -- String description of mission
_brf_situation = "
The Malden Insurgent Army (MIA) has taken over most of the islands southern half and is sure to expand its controlled territory northwards if we do not do something about it. That is why approximately 16 hours ago 'Operation Flying Redemption' has been green lit for execution by Headquarters. As a part of the COIN forces stationed on Malden, FOX Platoon has been tasked with carrying out the Operation. Enemy resistance is expected to be fierce and they will most likely deploy armed vehicles, which used to belong to the Malden Armed Forces (MAF). However it is not all bad news as a large portion of the civilian populous remains indifferent or supportive of the CSAT presence on Malden and that is precisely why damage to civilians, their properties and livestock must be avoided at all costs.
"; 

// METT-TC : Description 
// enemy forces~ Array of strings
_brf_enemy = [
          "MIA Insurgents",
          "Static Threats: KORD-12.7mm, ZU-23, Mk.6 Mortar",
          "Mobile Threats: UAZ mounted DSHKM, BTR-70"
             ];

// Friendly forces
_brf_friend = [
          "CSAT (Players)",
          "Elements: FOX6, FOX1, FOX2, FOX3, FOX4",
          "Air: CONDOR1, FALCON1"
              ];

// Other remarks
_brf_remarks = [
				"Time: 0520 hours",
        "Weather: Medium Overcast, expected Rain, Wind from N and NW",
        "Terrain: Lots of Foliage and Rocks, spread out Houses and Villages",
        "The Medical Pod is capable of treating wounds in a timely fashion.",
        "Although unlikely other captured MAF vehicles might be deployed against us.",
        "We know the approximate location of some of their AA positions."
               ];


// Mission -- String description I prefer numbered lists! 
_brf_mission = "
FOX Platoon supported by CONDOR1 and FALCON1 is to move out and clear enemy presence in <marker name='marker_14'>Sainte Marie</marker>. We also have Intel that a Cell-Leader of the MIA is currently hiding in an area near the village. These areas have been marked as points <marker name='marker_15'>Alpha</marker>, <marker name='marker_17'>Bravo</marker> and <marker name='marker_16'>Charlie</marker>. He must be neutralized. After these two Objectives have been completed, move further west and deal with the <marker name='marker_21'>enemy Encampment</marker>. There is also a second Insurgent Cell-Leader located somewhere in Zone <marker name='marker_19'>Delta</marker>. Eliminate him and move to strike down any remaining Insurgent forces in <marker name='marker_20'>Arette</marker>. Once all Tasks have been achieved RTB. It is important to note that any imprecise fire or CAS in and around Civilian Centers is not permitted by HQ.
";

// EXECUTION
_brf_execution = [
"I: FOX Platoon will move out to clear Sainte Marie",
"II: FOX Pl will find and neutralize Cell-Leader near Sainte Marie",
"III: FOX Pl continues west to clear Encampment",
"IV: FOX Pl locates and kills 2nd enemy Cell-Leader",
"V: FOX Pl drives enemies out of Arette",
"VI: FOX Pl returns to base"
			           ];

// ADMINISTRATION
_brf_administration = [
"1x Radio Supply Box",
"1x Mi-290 Taru",
"1x Field Hospital Taru Pod",
"1x Transport Taru Pod",
"1x Supplies Taru Pod refillable at  <marker name='marker_43'>its Pad</marker>",
"RRR available near Base",
"Ka-60-Armed available near Base",
"Miscellaneous Supplies available near Base"
                      ];