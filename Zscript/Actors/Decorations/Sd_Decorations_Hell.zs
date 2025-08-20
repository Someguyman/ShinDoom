
Class Shin_EvilEye : ShinDoom_Actor
{
	Default
	{
		-SOLID
		+FLOATBOB
		FloatBobStrength 0.3;
	}
	States
	{
	Spawn:
		CEY1 ABCB 6 BRIGHT;
		Loop;
	}
}

Class Shin_EvilEyeCandle : ShinDoom_Actor Replaces EvilEye
{
	Default
	{
		Radius 16;
		Height 54;
		ProjectilePassHeight -16;
		+SOLID
	}
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 0 A_SpawnItemEx("Shin_EvilEye",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION | SXF_TRANSFERAMBUSHFLAG ,0);
		goto idle;
	Idle:
		CEY2 ABCB 6 BRIGHT;
		Loop;
	}
}

Class Shin_FloatingSkull : ShinDoom_Actor Replaces FloatingSkull 
{
	Default
	{
		Radius 16;
		Height 26;
		ProjectilePassHeight -16;
		+SOLID
		+FLOATBOB
		FloatBobStrength 0.3;	
	}
	States
	{
	Spawn:
		FSKF ABCB 6 BRIGHT;
		Loop;
	}
}