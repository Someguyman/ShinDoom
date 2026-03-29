
Class Shin_PlasmaBall1 : Shin_PlasmaBall Replaces PlasmaBall1
{
	Default
	{
		Damage 4;
		BounceType "Classic";
		BounceFactor 1.0;
		Obituary "$OB_MPBFG_MBF";
		Seesound "PsxPlasma/Shot";
		Deathsound "PsxPlasma/ShotX";
	}
	States
	{
	Spawn:
		BAL8 AB 6 Bright;
		Loop;
	Death:
		BAL8 CDEFG 4 Bright;
		Stop;
	}
}
	
Class Shin_PlasmaBall2 : Shin_PlasmaBall1 Replaces PlasmaBall2
{
	States
	{
		Spawn:
			BAL5 AB 4 Bright;
			Loop;
		Death:
			BAL5 CDE 6 Bright;
			Stop;
	}
}

Class Shin_PlasmaBall4 : Shin_PlasmaBall3
{
	Default
	{
		Seesound "Beta/Shot";
		Deathsound "Beta/ShotX";
	}
	States
	{
		Spawn:
			BAL4 AB 4 BRIGHT;
			Loop;
		Death:
			BAL4 CDE 6 BRIGHT;
			Stop;
	}
}