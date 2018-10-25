# LMF_Revised
## Description
This Framework is based on the original LAMBS Framework and as such contains portions of code from it.\
This revise of the above mentioned Framework is intended to bring old code up to date, address previously unresolved issues,
and add functionality all while making sure it stays simple and easy to understand for end users.\
Big thanks to **Diwako**, **nkenny** and **Alex2k** for some of the code used in this Framework.

## Requirements:
In order to use this Framework, you need to run these mods alongside it:
* CBA_A3
* ACE3
* ACEX
* ACRE2

Furthermore by default this Framework is configured to run with some LAMBS specific mods.\
If you do not have these mods you will have to configure:\
-> All occurrences of player_insignia below line 30 in `framework\player\fn_initPlayerGear.sqf`.\
-> All LAMBS specific marker types below line 46 in `framework\player\init\groupMarkers.sqf`.

## Installation:
Copy over the contents of the "LMF_R.VR" folder into your mpmission folder.\
Installation is done.

### For mission makers:
Here a small rundown on how create a mission using the Framework.

__VR Mission:__\
The Framework comes with a form of template mission. In this template you will find examples on how to configure your mission
to properly use most of the Frameworks' various components. There are many different ways to get the components from this VR
mission into yours, but as an example let's just say you changed the .VR ending of the template mission folder to fit the map
you want your mission to be on and then dragged all components to where you want them to be.

__Settings Folder:__\
After you have properly placed all Framework relevant things in your mission and removed the ones you don't need,
head over to the settings folder and configure all the setting files according to your preference.

__AI Spawning:__\
The Framework also comes with some spawning functions for AI groups performing various tasks. One example would be:\
`0 = [this,"TEAM",100,1] spawn lmf_ai_fnc_garrison;` which would spawn a team of AI soldiers that garrison a building together,
somwhere in a 100m radius.\
There are other spawning functions aswell. To see what they do and how they work, just open them in a text editor of your choice
and read over the information on top.\
You can find them in: `framework\ai\spawning`.

__Testing:__\
It is highly recommended to test your mission extensively while having "show script errors" is enabled.\
That way it is more likely you will spot any form of mistake you have made while setting up your mission
and scripts.

### Variables
This Framework uses global variables starting with prefix var_ and prefix lmf_.

## Additional
If you are unsure of what you are doing and this is your first time using this Framework to make a mission, it is recommended to get help from
someone that is more experienced with it.