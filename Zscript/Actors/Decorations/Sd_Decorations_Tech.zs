
Class Shin_OfficeChair : ShinDoom_Actor
{
	Default
	{
		Radius 12;
		Height 16;
		+SOLID
	}
	States
	{
		Spawn:
			CHR1 A -1;
			Stop;
	}
}

Class Shin_Lamp_Breakable : ShinDoom_Actor
{
	Default
	{
		Radius 12;
		Height 52;
		Health 20;
		Mass 65536;
		DeathSound "world/officelamp";
		+SOLID
		+SHOOTABLE
		+NOBLOOD
		+DONTGIB
		+NOICEDEATH
	}
	States
	{
	Spawn:
		LAMP A -1 BRIGHT;
		Stop;
	Death:
		LAMP B 3 BRIGHT A_Scream;
		LAMP B 3 BRIGHT A_Fall;
	DeathLoop:
		LAMP CD 5 BRIGHT;
		Loop;
	}
}

Class Shin_Column : ShinDoom_Actor Replaces Column
{
	Default
	{
		Radius 16;
		Height 48;
		ProjectilePassHeight -16;
		+SOLID
	}
	States
	{
		Spawn:
			STLP ABCB 6 BRIGHT;
			Loop;
	}
}