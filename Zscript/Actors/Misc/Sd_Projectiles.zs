
Class Shin_PlasmaBall1 : PlasmaBall Replaces PlasmaBall1
{
	Default
	{
		Damage 4;
		BounceType "Classic";
		BounceFactor 1.0;
		Obituary "$OB_MPBFG_MBF";
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
		BAL5 AB 6 Bright;
		Loop;
	Death:
		BAL5 CDE 4 Bright;
		Stop;
	}
}