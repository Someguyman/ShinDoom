
Class Shin_Deadzombieman : Shin_ZombieMan Replaces DeadZombieMan
{
	Default
	{
		+NEVERRESPAWN
		-COUNTKILL
		DropItem "None";
	}
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+4;
	}
}

Class Shin_DeadShotgunner : Shin_ShotgunGuy Replaces DeadShotgunGuy
{
	Default
	{
		+NEVERRESPAWN
		-COUNTKILL
		DropItem "None";
	}
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+4;
	}
}

Class Shin_DeadChaingunguy : Shin_Chaingunguy
{
	Default
	{
		-COUNTKILL
		+NEVERRESPAWN
		DropItem "None";
	}
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			TNT1 A 0 A_Jumpif((BaseSprite == GetSpriteIndex('CPS2')), "D1.Corpse");
			Goto Super::Death+7;
		D1.Corpse:
			Goto Super::Death.D1+8;
	}
}

Class Shin_DeadDoomimp : Shin_DoomImp Replaces DeadDoomImp
{
	Default { +NEVERRESPAWN -COUNTKILL }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+4;
	}
}

Class Shin_DeadPinky : Shin_Pinky
{
	Default { +NEVERRESPAWN -COUNTKILL }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			TNT1 A 0 A_Jump(50, "Gibbed");
			Goto Super::DeathStop+2;
		Gibbed:
			Goto Super::XDeath+10;
	}
}

Class Shin_DeadSpectre : Shin_Spectre
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			TNT1 A 0 A_Jump(50, "Gibbed");
			Goto Super::DeathStop+2;
		Gibbed:
			Goto Super::XDeath+10;
	}
	
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		A_SetTranslucent(1.0, 0);
	}
}

Class Shin_DeadPinky_Spawner : RandomSpawner Replaces DeadDemon
{
	Default
	{
		DropItem "Shin_DeadPinky", 256, 128;
		DropItem "Shin_DeadSpectre", 256, 70;
	}
}

Class Shin_DeadCaco : Shin_Cacodemon Replaces DeadCacodemon
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			TNT1 A 0 A_Jump(50, "Gibbed");
			Goto Super::DeathStop+3;
		Gibbed:
			Goto Super::XDeath+9;
	}
}

Class Shin_DeadRevenant : Shin_Revenant
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+5;
	}
}

Class Shin_DeadArachnotron : Shin_Arachnotron
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			BSPI P 0;
			BSPI P 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			BSPI P 0 A_NoBlocking;
			BSPI P -1;
			Stop;
	}
}

Class Shin_DeadMancubus : Shin_Mancubus
{
	Default { -COUNTKILL +NEVERRESPAWN }
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+9;
	}
}

Class Shin_DeadHellKnight : Shin_HellKnight
{
	Default { -COUNTKILL }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+6;
	}
}

Class Shin_DeadBaronOfHell : Shin_BaronOfHell
{
	Default { -COUNTKILL +NEVERRESPAWN }
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+6;
	}
}

Class Shin_DeadArchvile : Shin_Archvile
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+9;
	}
}

Class Shin_DeadSpiderMastermind : Shin_SpiderMastermind
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+11;
	}
}

Class Shin_DeadCyberdemon : Shin_Cyberdemon
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+9;
	}
}

Class Shin_DeadWolfensteinSS : Shin_WolfensteinSS
{
	Default
	{
		-COUNTKILL
		+NEVERRESPAWN
		DropItem "None";
	}
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+4;
	}
}

Class Shin_DeadGhoul : Shin_Ghoul Replaces DeadLostSoul
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+7;
	}
}

Class Shin_DeadShockTrooper : Shin_ShockTrooper
{
	Default { -COUNTKILL +NEVERRESPAWN }
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			TNT1 A 0 A_Jump(60, "XDeath.Spawndeath");
			Goto Super::Death+5;
		XDeath.Spawndeath:
			Goto Super::XDeath+7;
	}
}

Class Shin_DeadMindweaver : Shin_Mindweaver
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+7;
	}
}

Class Shin_DeadVassago : Shin_Vassago
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+7;
	}
}

Class Shin_DeadTyrant : Shin_Tyrant
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+9;
	}
}

Class Shin_DeadMachinegunGuy : Shin_MachinegunGuy
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+4;
	}
}

Class Shin_DeadMechaZombie : Shin_MechaZombie
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+4;
	}
}

Class Shin_DeadGargoyle : Shin_Gargoyle
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+5;
	}
}

Class Shin_DeadSoulHarvester : Shin_SoulHarvester
{
	Default { +NEVERRESPAWN -COUNTKILL }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+8;
	}
}

Class Shin_DeadNightmareImp : Shin_NightmareImp
{
	Default { +NEVERRESPAWN -COUNTKILL }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+4;
	}
}

Class Shin_DeadNightmareSpectre : Shin_NightmareSpectre
{
	Default { +NEVERRESPAWN -COUNTKILL }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+7;
	}
}

Class Shin_DeadHellHound : Shin_HellHound
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+7;
	}
}

Class Shin_DeadWatcher : Shin_Watcher
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+7;
	}
}

Class Shin_DeadSoulDevourer : Shin_SoulDevourer
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+10;
	}
}

Class Shin_DeadNightmareCacodemon : Shin_NightmareCacodemon
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+5;
	}
}

Class Shin_DeadWargrin : Shin_Wargrin
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+4;
	}
}

Class Shin_DeadSoulReaper : Shin_SoulReaper
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+10;
	}
}

Class Shin_DeadHellgaurd : Shin_Hellgaurd
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+10;
	}
}

Class Shin_DeadSummoner : Shin_summoner
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+8;
	}
}

Class Shin_DeadCybruiser : Shin_Cybruiser
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+9;
	}
}

Class Shin_DeadCyberFatso : Shin_CyberFatso
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+9;
	}
}