// wait a little bit
sleep 2;

// QUOTES /////////////////////////////////////////////////////////////////////////////////////////
// by nkenny
_quote = SelectRandom 
  [
    ["It is not death that a man should fear, but he should fear never beginning to live.","Marcus Aurelius"],
    ["Cowards die many times before their deaths; the valiant never taste of death but once.","William Shakespeare"],
    ["Do not fear death so much but rather the inadequate life. ","Bertolt Brecht"],
    ["Call no man happy before he dies, he is at best but fortunate.","Solon"],
    ["Man dies of cold, not of darkness.","Miguel de Unamuno"],
    ["Some people are so afraid to die that they never begin to live.","Henry Van Dyke"],
    ["The fear of death follows from the fear of life. A man who lives fully is prepared to die at any time.","Mark Twain"],
    ["I didn't attend the funeral, but I sent a nice letter saying I approved of it.","Mark Twain"],
    ["Someone has to die in order that the rest of us should value life more.","Virginia Woolf"],
    ["Some people die at 25 and aren't buried until 75.","Benjamin Franklin"],
    ["I'm not afraid to die, I just don't want to be there when it happens.","Woody Allen"],
    ["I am prepared to meet my Maker. Whether my Maker is prepared for the great ordeal of meeting me is another matter.","Winston Churchill"],
    ["I intend to live forever, or die trying.","Groucho Marx"],
    ["In war, truth is the first casualty.","Aeschylus"],    
    ["Of all the gods only death does not desire gifts.","Aeschylus"],
    ["When you're dead, you're dead. That's it.","Marlene Dietrich"],
    ["To have died once is enough.","Virgil"],
    ["Healthy children will not fear life if their elders have integrity enough not to fear death.","Erik Erikson"],
    ["Courage is being scared to death... and saddling up anyway.","John Wayne"],
    ["The death of one man is a tragedy. The death of millions is a statistic.","Joseph Stalin"],
    ["Death is pitch-dark, but colors are light. To be a painter, one must work with rays of light.","Edvard Munch"],
    ["Death may be the greatest of all human blessings.","Socrates"],
    ["The goal of all life is death. ","Sigmund Freud"],
    ["The idea is to die young as late as possible.","Ashley Montagu"],
    ["Death is a debt we all must pay.","Euripides"],
    ["Life and death are balanced on the edge of a razor.","Homer, Iliad"],
    ["Paradise~<br/>I see flowers<br/>from the cottage where I lie.","Yaitsu's death poem, 1807"],
    ["'There are no atheists in foxholes' isn't an argument against atheism, it's an argument against foxholes.","James Morrow"],
    ["A soldier will fight long and hard for a bit of colored ribbon.","Napoleon"],
    ["A great war leaves the country with three armies, an army of cripples, an army of mourners, and an army of thieves.","German Proverb"],
    ["Join the Army, see the world, meet interesting people and kill them.","Pacifist Badge, 1978"],
    ["Sometime they'll give a war and nobody will come.","Carl Sandburg"],
    ["War! that mad game the world so loves to play.","Jonathan Swift"],
    ["Only the dead have seen the end of war.","Plato"],
    ["When the rich wage war, it's the poor who die.","Jean-Paul Sartre"],
    ["I think war might be God's way of teaching us geography.","Paul Rodriguez"],
    ["War is fear cloaked in courage.","William Westmoreland"],
    ["The object of war is not to die for your country, but to make the other bastard die for his.","George Patton"],
    ["It is good that war is terrible, otherwise men would grow fond of it.","Robert E. Lee"],
    ["The difficulty is not so great to die for a friend, as to find a friend worth dying for.","Homer"],
    ["Be still my heart; thou hast known worse than this.","Homer"],
    ["And what he greatly thought, he nobly dared.","Homer"],
    ["There is a time for many words, and there is also a time for sleep.","Homer"],
    ["After your death you will be what you were before your birth.","Arthur Schopenhauer"],
    ["A man can do what he wants, but not want what he wants.","Arthur Schopenhauer"],
    ["The two enemies of human happiness are pain and boredom.","Arthur Schopenhauer"],
    ["Everything has been figured out, except how to live.","Jean-Paul Sartre"],
    ["Every existing thing is born without reason, prolongs itself out of weakness, and dies by chance.","Jean-Paul Sartre"],
    ["Man is condemned to be free; because once thrown into the world, he is responsible for everything he does.","Jean-Paul Sartre"],
    ["That which does not kill us makes us stronger.","Friedrich Nietzsche"],
    ["When you look into an abyss, the abyss also looks into you.","Friedrich Nietzsche"],
    ["Whereof one cannot speak, thereof one must be silent.","Ludwig Wittgenstein"],
    ["A single death is a tragedy, a million deaths is a statistic.","Joseph Stalin"],
    ["Ideas are more powerful than guns. We would not let our enemies have guns, why should we let them have ideas.","Joseph Stalin"],
    ["Death is the solution to all problems. No man - no problem.","Joseph Stalin"],
    ["The Pope! How many divisions has he got?","Joseph Stalin"],
    ["In the Soviet army it takes more courage to retreat than advance.","Joseph Stalin"],
    ["The only real power comes out of a long rifle.","Joseph Stalin"],
    ["I like pigs. Dogs look up to us. Cats look down on us. Pigs treat us as equals.","Winston Churchill"],
    ["Success is not final, failure is not fatal: it is the courage to continue that counts.","Winston Churchill"],
    ["Battle is an orgy of disorder.","George S. Patton"],
    ["We herd sheep, we drive cattle, we lead people. Lead me, follow me, or get out of my way.","George S. Patton"],
    ["Untutored courage is useless in the face of educated bullets.","George S. Patton"],
    ["Let me not then die ingloriously and without a struggle, but let me first do some great thing that shall be told among men hereafter.","Homer, The Iliad"],
    ["Sing, O muse, of the rage of Achilles, son of Peleus, that brought countless ills upon the Achaeans.","Homer, The Iliad"],
    ["Nay if even in the house of Hades the dead forget their dead, yet will I even there be mindful of my dear comrade","Homer, The Iliad"],
    ["Marines don't know how to spell the word defeat.","General James Mattis"],
    ["There is nothing better than getting shot at and missed. It’s really great.","General James Mattis"],
    ["Culture is roughly anything we do and the monkeys don’t.","Lord Raglan"],
    ["In some cases nonviolence requires more militancy than violence.","Cesar Chavez"],
    ["He who fights with monsters should be careful lest he thereby become a monster.","Friedrich Nietzsche, Beyond Good and Evil"],
    ["An inability to stay quiet is one of the most conspicuous failings of mankind.","Walter Bagehot"],
    ["Silence is a fence around wisdom.","German proverb"],
    ["Honk if you hate noise pollution.",""],
    ["A cat bitten once by a snake dreads even rope.","Arab Proverb"],
    ["Just remember, there's a right way and a wrong way to do everything and the wrong way is to keep trying to make everybody else do it the right way.","Colonel Potter"],
    ["It's too big a world to be in competition with everyone. The only person who I have to be better than is myself.","Colonel Potter"],
    ["Sometimes I think it should be a rule of war that you have to see somebody up close and get to know him before you can shoot him.","Colonel Potter"],
    ["Having is not so pleasing a thing as wanting, it may not be logical but it is often true.","Star Trek, Mr. Spock"],
    ["In the strict scientific sense we all feed on death - even vegetarians.","Star Trek, 'Wolf in the Fold,' Mr. Spock"],
    ["I must acknowledge, once and for all, that the purpose of diplomacy is to prolong a crisis.","Star Trek, Mr. Spock"],
    ["To study philosophy is nothing but to prepare one's self to die.","Cicero"],
    ["The good are always prone to tears.","Anon"],
    ["Praise Old wine, but new poetry.","Pindar"],
    ["Sons of heroes are a pestilence","Anon"],
    ["Another victory like that one and we are lost.","Pyrrhus"],
    ["When in apes' compnay, one must playthe ape.","Apollodorus"],
    ["fish begins to stink at the head.","Ancient Greek proverb"],
    ["My horse carries me, but the king supports me.","Ancient Greek proverb"],
    ["Ears had they and heard not.","Aeschylus"],
    ["Better to do a little than a great deal badly.","Socrates"],
    ["Death is the only god whom gifts cannot appease.","Aeschylus"],
    ["A rolling stone gathers no moss.","Anon"],
    ["In great attempts, even to fail is glorious.","Ancient Greek proverb"],
    ["War is sweet to those who never tried it.","Pindar"],
    ["Women know everything about evrything.","Theocritus"],
    ["Lif eis short, art is long.","Hippocrates"],
    ["Who will rule the ruler?","Plutarch"],
    ["It is difficult to argue with the belly, as it has no ears.","Plutarch"]
  ];

// BLACK OUT
cutText  ["", "BLACK OUT", 4, true];
[false] call ace_common_fnc_setVolume;
//0.5 fadeSound 0.1;
sleep 2;
_msg1 = ("<t size='0.75' align='left'>" + (_quote select 0) + "<br/><t align='right'>"+ "~"+ (_quote select 1) +"</t>");
[format   ["%1",_msg1],0,0.7,4,1] spawn BIS_fnc_dynamicText;

// CALCULATE RESPAWNTIME //////////////////////////////////////////////////////////////////////////
if (hasInterface AND !alive player) then {

	if (typename var_respawnType == "STRING") then {

		if (var_respawnType == "WAVE") then {
			setPlayerRespawnTime (var_respawnTime - ((floor CBA_missionTime) % var_respawnTime));
		};

		if (var_respawnType == "OFF") then {
			setPlayerRespawnTime 1000000;
		};

	};
	
	if (typename var_respawnType == "SCALAR") then {
		setPlayerRespawnTime var_respawnType;
	};

};

sleep 1;
[true] call acre_api_fnc_setSpectator;
sleep 4;

// INITIALIZE SPECTATOR ///////////////////////////////////////////////////////////////////////////
["Initialize", [player, [], false, true, true, false, false, false, false, true]] call BIS_fnc_EGSpectator;
[true] call ace_common_fnc_setVolume;
//2 fadeSound 1;

// ADD CUSTOM CHAT CHANNEL AND NOTIFY PLAYER //////////////////////////////////////////////////////
if (hasInterface AND !alive player) then {

	_id = clientOwner;
  [player,true,1] remoteExec ["RADIO_fnc_manage", _id, false];

	sleep 1;

	_msg = ("<t size='0.75'>Use the</t>" + "<t size='0.75' color='#FF9900'>  SPECTATOR CHANNEL  </t><t size='0.75'>" + "<t size='0.75'>to text chat</t>");
	[_msg,0,0.4,8,2] spawn BIS_fnc_dynamicText;

	0 enableChannel false;
	1 enableChannel false;
	2 enableChannel false;
	3 enableChannel false;
	4 enableChannel false;
	5 enableChannel false;
};

// FADE IN
cutText  ["", "BLACK IN", 5, true];

// RESPAWN COUNTER ////////////////////////////////////////////////////////////////////////////////
[] spawn 
{
nk_fnc_timemagic = {
  private ["_n"];
  _n = _this select 0; 
  if (_n < 10) then {_n = format ["0%1",_n]};
  _n
};

  waitUntil {playerRespawnTime < 4000};

  while {playerRespawnTime > 0 and !alive player} do 
  {
  if (typename var_respawnType == "STRING") then {
  if (var_respawnType == "WAVE") then {
  _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call nk_fnc_timemagic,[(playerRespawnTime mod 60)] call nk_fnc_timemagic];
  //_stitle = "<t size='1.4' align='Center'>Respawn</t><br/>";
  _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
  hintSilent parsetext (_time);
  uiSleep 1;
  };

  if (var_respawnType == "OFF") then {
  _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call nk_fnc_timemagic,[(playerRespawnTime mod 60)] call nk_fnc_timemagic];
  //_stitle = "<t size='1.4' align='Center'>Respawn</t><br/>";
  _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
  hintSilent parsetext (_time);
  uiSleep 1;
  };
};
  if (typename var_respawnType == "SCALAR") then {
  _time_is = format ["%1:%2",[floor (playerRespawnTime/60)] call nk_fnc_timemagic,[(playerRespawnTime mod 60)] call nk_fnc_timemagic];
  //_stitle = "<t size='1.4' align='Center'>Respawn</t><br/>";
  _time = format ["<t font='PuristaBold' align='Center'>Time until redeployment: %1</t><br/>",_time_is];
  hintSilent parsetext (_time);
  uiSleep 1;
  };



  };
  // End it! 
  hintSilent ""; 
};