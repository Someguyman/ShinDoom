//
Class Shin_MonsterCloset : ShinDoom_Actor
{
	Default
	{
		Height 32;
		Mass 10000;
		+Solid;
		+Shootable;
	}
	States
	{
		Spawn:
			MCLS ABCB 8;
			Loop;
		Death:
			MCLS DEFGH 5;
			MCLS I -1;
			Stop;
	}
}