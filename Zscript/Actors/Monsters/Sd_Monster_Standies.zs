
Class Shin_Zombieman_Standie : Shin_MonsterStandie
{
	States
	{
		Spawn:
			POSS E -1;
			Stop;
	}
}

Class Shin_Shotgunguy_Standie : Shin_MonsterStandie
{
	States
	{
		Spawn:
			SPOS E -1;
			Stop;
	}
}

Class Shin_Chaingunguy_Standie : Shin_MonsterStandie
{
	States
	{
		Spawn:
			CPOS V -1;
			Stop;
	}
}

Class Shin_DoomImp_Standie : Shin_MonsterStandie
{
	States
	{
		Spawn:
			TROO G -1;
			Stop;
	}
}

Class Shin_Pinky_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 1.1;
	}
	States
	{
		Spawn:
			SARG F -1;
			Stop;
	}
}

Class Shin_Spectre_Standie : Shin_Pinky_Standie
{
	Default
	{
		//+SHADOW
		RenderStyle "OptFuzzy";
		Alpha 0.25;
		Translation "Monochrome";
	}
	States
	{
		Spawn:
			SAR2 G -1;
			Stop;
	}
}

Class Shin_LostSoul_Standie : Shin_MonsterStandie
{
	Default
	{
		+FLOAT 
		+NOGRAVITY 
	}
	States
	{
		Spawn:
			SKUL C -1;
			Stop;
	}
}

Class Shin_Cacodemon_Standie : Shin_MonsterStandie
{
	Default
	{
		+FLOAT 
		+NOGRAVITY 
		Scale 1.1;
	}
	States
	{
		Spawn:
			HEAD C -1;
			Stop;
	}
}

Class Shin_PainElemental_Standie : Shin_MonsterStandie
{
	Default
	{
		+FLOAT 
		+NOGRAVITY 
		Scale 1.2;
	}
	States
	{
		Spawn:
			PAIN E -1;
			Stop;
	}
}

Class Shin_Revenant_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 0.95;
	}
	States
	{
		Spawn:
			SKEL I -1;
			Stop;
	}
}

Class Shin_Arachnotron_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 1.1;
	}
	States
	{
		Spawn:
			BSPI Q -1;
			Stop;
	}
}

Class Shin_Fatso_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 1.1;
	}
	States
	{
		Spawn:
			FATT G -1;
			Stop;
	}
}

Class Shin_HellKnight_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 1.1;
	}
	States
	{
		Spawn:
			BOS2 G -1;
			Stop;
	}
}

Class Shin_BaronOfHell_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 1.3;
	}
	States
	{
		Spawn:
			BOSS E -1;
			Stop;
	}
}

Class Shin_Mastermind_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 1.1;
	}
	States
	{
		Spawn:
			SPID T -1;
			Stop;
	}
}

Class Shin_Cyberdemon_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 1.1;
	}
	States
	{
		Spawn:
			CYBR E -1;
			Stop;
	}
}

Class Shin_WolfensteinSS_Standie : Shin_MonsterStandie
{
	States
	{
		Spawn:
			SSWV F -1;
			Stop;
	}
}