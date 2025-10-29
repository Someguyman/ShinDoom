//

Class Shin_Spectre_ZombieMan : Shin_ZombieMan Replaces StealthZombieMan
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		Obituary "$OB_STEALTHZOMBIE";
		tag "camo trooper";
	}
}

Class Shin_Spectre_ShotgunGuy : Shin_ShotgunGuy Replaces StealthShotgunGuy
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		Obituary "$OB_STEALTHSHOTGUNGUY";
		tag "camo seregant";
	}
}

Class Shin_Spectre_ChaingunGuy : Shin_ChaingunGuy Replaces StealthChaingunGuy
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		Obituary "$OB_STEALTHCHAINGUY";
		tag "heavy camoguy";
	}
}

Class Shin_Spectre_DoomImp : Shin_DoomImp Replaces StealthDoomImp
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		Obituary "$OB_STEALTHIMP";
		HitObituary "$OB_STEALTHIMP";
		tag "spectre imp";
	}
}

Class Shin_Spectre_Demon : Shin_Pinky Replaces StealthDemon 
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		HitObituary "$OB_STEALTHDEMON";
		tag "spectre pinky";
	}
}

Class Shin_Spectre_Lostsoul : Shin_Lostsoul
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		tag "spectre soul";
	}
}

Class Shin_Spectre_Painsoul : Shin_Painsoul
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		+ShinDoom_Actor.STARTINVIS
		tag "spectre soul";
	}
}

Class Shin_Spectre_Cacodemon : Shin_Cacodemon Replaces StealthCacodemon
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		Obituary "$OB_STEALTHCACO";
		HitObituary "$OB_STEALTHCACO";
		tag "spectre cacodemon";
	}
}

Class Shin_Spectre_Revenant : Shin_Revenant Replaces StealthRevenant
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		Obituary "$OB_STEALTHUNDEAD";
		HitObituary "$OB_STEALTHUNDEAD";
		tag "spectre fiend";
	}
}

Class Shin_Spectre_HellKnight : Shin_HellKnight Replaces StealthHellKnight
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW		
		Obituary "$OB_STEALTHKNIGHT";
		HitObituary "$OB_STEALTHKNIGHT";
		tag "spectre knight";
	}
}

Class Shin_Spectre_BaronOfHell : Shin_BaronOfHell Replaces StealthBaron
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW		
		Obituary "$OB_STEALTHBARON";
		HitObituary "$OB_STEALTHBARON";
		tag "spectre baron";
	}
}

Class Shin_Spectre_PainElemental : Shin_Painelemental Replaces StealthBaron
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		Alpha 0.25;
		tag "spectre elemental";
	}
}

Class Shin_Spectre_Arachnotron : Shin_Arachnotron Replaces StealthArachnotron
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW		
		Obituary "$OB_STEALTHBABY";
		tag "spectretron";
	}
}

Class Shin_Spectre_Fatso : Shin_Mancubus Replaces StealthFatso
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW		
		Obituary "$OB_STEALTHFATSO";
		tag "spectrebus";
	}
}

Class Shin_Spectre_Archvile : Shin_Archvile replaces StealthArchvile
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		Obituary "$OB_STEALTHVILE";
		tag "spectrevile";
	}
}

Class Shin_Spectre_Cyberdemon : Shin_Cyberdemon
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		Obituary "$OB_STEALTHCYBER";
		tag "cyberspectre";
	}
}

Class Shin_Spectre_SpiderMastermind : Shin_spidermastermind
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		Obituary "$OB_STEALTHSPIDER";
		tag "spectre mastermind";
	}
}

Class Shin_Spectre_Ghoul : Shin_Ghoul
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		tag "invisaghoul";
	}
}

Class Shin_Spectre_Banshee : Shin_Banshee
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		tag "phantom banshee";
	}
}

Class Shin_Spectre_Shocktrooper : Shin_ShockTrooper
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		tag "spec op";
	}
}

Class Shin_Spectre_Mindweaver : Shin_Mindweaver
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		tag "Mindspectre";
	}
}

Class Shin_Spectre_Vassago : Shin_Vassago
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW
		tag "Spectre Vassago";
	}
}

Class Shin_Spectre_Tyrant : Shin_Tyrant
{
		Default
	{
		+ShinDoom_Actor.SHINSHADOW
		tag "Ghost Tyrant";
	}
}