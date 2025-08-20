
Class Shin_MonsterCloset : ShinDoom_Actor
{
	Default
	{
		Height 32;
		Mass 10000;
		+SOLID;
		+SHOOTABLE;
	}
	States
	{
		Spawn:
			MCLS ABCB 8;
			Loop;
		Chase:
			MCLS ABCB 6;
			Loop;
		Death:
			MCLS DEFGH 5;
			MCLS I -1;
			Stop;
	}
}