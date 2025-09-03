
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

Class Shin_SigilEye : Shin_EvilEye
{
	States
	{
	Spawn:
		S8LE ABCB 6 BRIGHT;
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
		CEY2 ABCB 6 BRIGHT;
		Loop;
	}
	
	override void PostBeginPlay()
	{
		string mapName = Level.MapName.MakeLower();
		super.PostBeginPlay();
		
		if ((MapName.left(2) == "e5") || (MapName.left(2) == "e6"))
		{
			A_SpawnItemEx("Shin_SigilEye",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION | SXF_TRANSFERAMBUSHFLAG ,0);
		}
		Else
		{
			A_SpawnItemEx("Shin_EvilEye",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION | SXF_TRANSFERAMBUSHFLAG ,0);
		}
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