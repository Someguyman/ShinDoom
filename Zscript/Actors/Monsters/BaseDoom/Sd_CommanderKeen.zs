
Class Shin_CommanderKeen : ShinDoom_Actor Replaces CommanderKeen
{
	Default
	{
		Health 100;
		Radius 16;
		Height 72;
		Mass 10000000;
		PainChance 256;
		+SOLID 
		+SPAWNCEILING 
		+NOGRAVITY 
		+SHOOTABLE 
		+COUNTKILL 
		+NEVERRESPAWN
		+NOICEDEATH
		+DONTFALL
		+ISMONSTER
		PainSound "Commanderkeen/pain";
		DeathSound "Commanderkeen/death";
		Tag "Commander keen";
	}
	States
	{
	Spawn:
	Idle:
		KEEN A -1;
		Loop;
	Pain:
		KEEN N	4;
		KEEN N	8 A_Pain;
		Goto Spawn;
	Death:
		ROPE A 3 A_SpawnItemEx("Shin_Keenbodie", 0, 0, -8);
		ROPE B 3;
		ROPE C 4 A_Scream;
		ROPE D 4;
		ROPE E 5;
		ROPE F 6;
		ROPE F 30;
		ROPE F 0 A_KeenDie;
		ROPE F -1;
		Stop;
	XDeath:
		Stop;
	}
}

Class Shin_Keenbodie : ShinDoom_Actor
{
	default
	{
		+NOGRAVITY 
		+NEVERRESPAWN
		+NOBLOCKMAP
		+NOCLIP
		Mass 10000000;
	}
	States
	{
	Spawn:
		KEEN M 4;
		KEEN B 6 { bNOGRAVITY = false; }
		KEEN CDEFGHIJK 6;
		KEEN L -1;
		Stop;
	}
}