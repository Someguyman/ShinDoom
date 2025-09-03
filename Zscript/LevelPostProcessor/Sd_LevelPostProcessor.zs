
Class ShinDoom_LevelPostProcessor : LevelPostProcessor
{
	static void Shin_Spawnthing(Class<actor> actorclass, Vector3 pos, int angle = 0, uint flags = MODES_ALL|MTF_AMBUSH)
	{
		actor SpawnedThing = Actor.Spawn(actorclass, pos, ALLOW_REPLACE);
		SpawnedThing.angle = angle;
	}
	
	protected void Apply(Name checksum, String mapname)
	{
		for (uint i = 0; i < GetThingCount(); i++)
		{
			let flags = GetThingFlags(i);
			int ednum = GetThingEdNum(i);
			String mapPrefix = level.MapName.Left(3);
			mapPrefix = mapPrefix.MakeLower();
			String mapName = level.MapName.MakeLower();
			int skill_level = G_SkillPropertyInt(SKILLP_ACSReturn);
			
			int Arachnotron = 	  	  68;
			int Archvile = 		  	  64;
			int Baronofhell = 	    3003;
			int BossBrain =		  	  88;
			int Cacodemon = 	    3005;
			int Chaingunner = 	  	  65;
			int CommanderKeen =   	  72;
			int Cyberdemon = 	  	  16;
			int DoomImp = 		    3001;
			int Fatso = 	  	  	  67;
			int Hellknight = 	  	  69;
			int LostSoul = 		    3006;
			int Painelemental =   	  71;
			int PinkyDemon = 	    3002;
			int Revenant = 		  	  66;
			int Shotgunner = 	  	   9;
			int SpectreDemon = 	  	  58;
			int SpiderMastermind =     7;
			int ZombieMan = 	    3004;
			int WolfensteinSS =   	  84;

			int Banshee = 		 	3008;
			int Ghoul = 			3007;
			int Mindweaver = 		3009;
			int ShockTropper = 		3010;
			int Tyrant = 			3012;
			int Vassago = 			3011;
			
			//
			
			if (ednum == Baronofhell && 
			( mapName != "e1m8" || 
			  mapName != "test" || 
			  mapName != "testmap" ))
			SetThingEdNum(i, Hellknight);
			
			Switch (Checksum)
			{
				case 'E43C1797DFD9443D1B4C035327743588' :
				{
					SetThingEdNum(1,0);
					SetThingEdNum(3,0);
					SetThingEdNum(4,0);
					SetThingEdNum(5,0);
					SetThingEdNum(6,0);
					SetThingEdNum(7,0);
					SetThingEdNum(8,0);
					SetThingEdNum(9,0);
					SetThingEdNum(10,0);
					SetThingEdNum(11,0);
					SetThingEdNum(12,0);
					SetThingEdNum(13,0);
					SetThingEdNum(14,0);
					SetThingEdNum(15,0);
					SetThingEdNum(288,0);
					SetThingEdNum(16,0);
					SetThingEdNum(17,0);
					SetThingEdNum(18,0);
					//SetThingEdNum(39,0);
					Break;
				}
				
				case 'b49f7a6c519757d390d52667db7d8793' :
				{
					SetThingEdNum(90,0);
					Break;
				}
			}
			
			//if  (ednum == Chaingunner && (mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m"))
		}	
	}
}

Class ShinDoom_MonsterSpawner play
{
	static void CheckMapHashes()
	{
		if(level.GetChecksum() == 'E43C1797DFD9443D1B4C035327743588')
		{
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_ZombieMan_Standie",( -3616, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Shotgunguy_Standie",( -3456, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Chaingunguy_Standie",( -3296, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_DoomImp_Standie",( -3136, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Pinky_Standie",( -2976, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Spectre_Standie",( -2816, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Cacodemon_Standie",( -2656, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_LostSoul_Standie",( -2496, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_HellKnight_Standie",( -2336, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_BaronOfHell_Standie",( -2176, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Archvile_Standie",( -2016, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Arachnotron_Standie",( -1856, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Fatso_Standie",( -1696, 1824, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Revenant_Standie",( -1536, 1824, -999 ), 270, MTF_AMBUSH);
			
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_PainElemental_Standie",( -3616, 1504, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_WolfensteinSS_Standie",( -3456, 1504, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Cyberdemon_Standie",( -3296, 1504, -999 ), 270, MTF_AMBUSH);
			ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_Mastermind_Standie",( -3072, 1504, -999 ), 270, MTF_AMBUSH);
		}
		
		if(level.GetChecksum() == 'b49f7a6c519757d390d52667db7d8793')
		{
			if (G_SkillPropertyInt(SKILLP_ACSReturn) >= 3)
			{
				ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_MachinegunGuy",( 2464, -2432, -999 ), 180, MTF_AMBUSH);
			}
		}
	}
}