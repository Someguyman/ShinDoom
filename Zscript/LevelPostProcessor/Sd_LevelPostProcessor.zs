
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
			//ShinDoom_LevelPostProcessor.Shin_Spawnthing("Shin_hellgaurd",( -3072, 320, -999 ), 0, MTF_AMBUSH);
		}
	}
}