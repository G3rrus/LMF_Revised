// ADMIN creates and links ZEUS module 
// version 1.0
// by nkenny

if (!isserver) exitWith {}; 

// init
_p = Param [0]; 

// create it! 
_z = creategroup sideLogic;  
_zeus = _z createunit ["ModuleCurator_F", [0, 0, 0],[],1,"NONE"];    
_zeus setvariable ["text","ZEUS"];    
_zeus setvariable ["Addons",3,true];
_zeus setvariable ["owner","objnull"];  
_zeus setvariable ["vehicleinit","_this setvariable ['Addons',3,true]; _this setvariable ['owner','objnull'];"];
unassignCurator _zeus;
objnull assignCurator _zeus;

// link it! 
_p assignCurator _zeus; 
_zeus addCuratorEditableObjects [allPlayers,true];

// Message
_txt = format ["ADMIN: ZEUS ACCESS ACTIVE %1",name _p];
[_txt] remoteExec ["systemChat",_p,false];

// end 
true 

