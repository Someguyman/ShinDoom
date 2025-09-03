class Shin_DeadMarine_Spawner : RandomSpawner
{
	Default
	{
		DropItem "DeadMarine", 256, 90;
		DropItem "Shin_DeadMarine_Alt", 256, 90;
		DropItem "Shin_DeadMarine_frontup", 256, 90;
		DropItem "Shin_DeadMarine_strife", 256, 90;
		DropItem "Shin_DeadMarine_Headless", 256, 10;
	}
}

Class Shin_DeadMarine_Headless : ShinDoom_Actor
{
	States
	{
		Spawn:
			MRNB A -1;
			Stop;
	}
}

Class Shin_DeadMarine_Alt : ShinDoom_Actor
{
	States
	{
		Spawn:
			MRNB B -1;
			Stop;
	}
}

Class Shin_DeadMarine_frontup : ShinDoom_Actor
{
	States
	{
		Spawn:
			MRNB C -1;
			Stop;
	}
}


Class Shin_DeadMarine_strife : ShinDoom_Actor
{
	States
	{
		Spawn:
			MRNB D -1;
			Stop;
	}
}

Class Shin_DeadMarine_torso : ShinDoom_Actor
{
	States
	{
		Spawn:
			MRNB E -1;
			Stop;
	}
}

Class Shin_DeadMarine_legs : ShinDoom_Actor
{
	States
	{
		Spawn:
			MRNB F -1;
			Stop;
	}
}

Class Shin_CorpsePile : ShinDoom_Actor
{
	Default
	{
		Radius 40;
		Height 16;
		+SOLID
	}
	States
	{
		Spawn:
			POL7 A -1;
			Stop;
	}
}

Class Shin_SweatDeadBunny : ShinDoom_Actor
{
	Default
	{
		Radius 16;
		Height 56;
		ProjectilePassHeight -16;
		+SOLID
	}
	States
	{
		Spawn:
			BUNS A -1;
			Stop;
	}
}

Class Shin_SweatDeadBunny2 : ShinDoom_Actor
{
	Default
	{
		Radius 16;
		Height 40;
		ProjectilePassHeight -16;
		+SOLID
	}
	States
	{
		Spawn:
			BUNN A -1;
			Stop;
	}
}

Class Shin_DeadStick : ShinDoom_Actor Replaces DeadStick
{
	Default
	{
		+SOLID
		+SHOOTABLE
		Radius 16;
		Height 64;
		Mass 0x7fffffff;
		ProjectilePassHeight -16;
		Health 15;
	}
	States
	{
		Spawn:
			POL1 A 1;
			Loop;
		Death:
			POL1 Q 5;
			POL1 D 5;
			POL1 E 5;
			POL1 F 5;
			POL1 G -1;
			Stop;
		XDeath:
			POL1 H 5;
			POL1 I 5 A_XScream;
			POL1 J 5 ;
			POL1 KLMNO 5;
			POL1 P -1;
			Stop;
	}
}

Class Shin_LiveStick : ShinDoom_Actor Replaces LiveStick
{
	Default
	{
		Radius 16;
		Height 64;
		Mass 0x7fffffff;
		ProjectilePassHeight -16;
		Health 20;
		PainChance 200;
		+SOLID
		+SHOOTABLE
	}
	States
	{
		Spawn:
			POL6 A 6;
			POL6 B 8;
			Loop;
		Pain:
			POL6 B 6;
			POL6 B 6 A_Pain;
			Goto Spawn;
		Death:
			POL6 C 5;
			POL6 D 5 A_Scream;
			POL6 E 5;
			POL6 F 5;
			POL6 G -1;
			Stop;
		XDeath:
			POL6 H 5;
			POL6 I 5 A_XScream;
			POL6 J 5;
			POL6 KLMNO 5;
			POL6 P -1;
			Stop;
	}
}

Class Shin_ConsoleMeat : ShinDoom_Actor
{
	Default
	{
		Radius 16;
		Height 84;
		//+SOLID
		+NOGRAVITY
		+SPAWNCEILING
	}
	States
	{
		Spawn:
			CCPR A -1;
			Stop;
	}
}

Class Shin_ConsoleMeat2 : Shin_ConsoleMeat
{
	States
	{
		Spawn:
			CCPR B -1;
			Stop;
	}
}

Class Shin_ConsoleMeat3 : Shin_ConsoleMeat
{
	States
	{
		Spawn:
			CCPR C -1;
			Stop;
	}
}

Class Shin_ConsoleMeat4 : Shin_ConsoleMeat
{
	States
	{
		Spawn:
			CCPR D -1;
			Stop;
	}
}