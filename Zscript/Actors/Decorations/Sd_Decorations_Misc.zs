
Class Shin_Candlestick : ShinDoom_Actor Replaces Candlestick
{
	Default
	{
		Radius 20;
		Height 14;
		ProjectilePassHeight -16;
	}
	States
	{
		Spawn:
			CNDL ABCB 6 BRIGHT;
			Loop;
	}
}

class Shin_CandelabraShort : ShinDoom_Actor
{
	Default
	{
		Radius 16;
		Height 16;
		+SOLID
	}
	States
	{
	Spawn:
		CBR2 A -1 BRIGHT;
		Stop;
	}
}

Class Shin_Candelabra : ShinDoom_Actor Replaces Candelabra
{
	Default
	{
		Radius 16;
		Height 60;
		ProjectilePassHeight -16;
		+SOLID
	}
	States
	{
		Spawn:
			CBR1 ABCB 6 BRIGHT;
			Loop;
	}
}