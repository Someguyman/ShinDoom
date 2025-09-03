
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