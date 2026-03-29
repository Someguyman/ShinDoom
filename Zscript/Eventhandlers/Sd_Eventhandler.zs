//
/*

First, we would have to figure out if the map is supported by our script

If it is, then we use that to spawn the new enemies and disable the random spawning algorithim.
If its not, then we'd run the standard rng spawner logic like normal.

The random spawner logic would run as such

First, we check what campain we are playing right now. Then, we'd adjust the spawners for the appropriate game.

Second, we have the spawners adjust the spawn rates depending on how far you are into the campain.
So in the eariler portions of a campain, you won't see very many strong monsters.
But as you go on, they start to appear more often.
However, I'd also make sure the spawners take into acount how many monsters are in the map and how much of that species makes up the overall bulk.
This is to ensure the best possible experience for each map.

*/

Class ShinDoom_EventHandler : EventHandler
{
	override void WorldLoaded(WorldEvent e)
	{
		ShinDoom_MonsterSpawner.CheckMapHashes();
	}
	
	override void CheckReplacee (ReplacedEvent e)
	{
		if (e.Replacement == 'Shin_Cyberboss')
			e.Replacee = 'Cyberdemon';
			
		if (e.Replacement == 'Shin_Spiderboss')
			e.Replacee = 'Spidermastermind';
			
		if (e.Replacement == 'Shin_BaronOfHell')
			e.Replacee = 'BaronOfHell';
	}
	
	static const Class<Actor> NobleSpawnD1[] =
	{
		'Shin_Hellknight',
		'Shin_HellGaurd'
	};
	
	static const Class<Actor> NobleSpawnD2[] =
	{
		'Shin_Hellknight',
		'Shin_Cybruiser'
	};
	
	override void WorldThingRevived(WorldEvent e)
	{
		RevertKillCounter(e);
	}
	
	override void WorldThingSpawned(worldEvent e)
	{
		let b1 = Shell(e.thing);
		let b2 = ShellBox(e.thing);
		let r1 = RocketAmmo(e.thing);
		let r2 = RocketBox(e.thing);
		let armor1 = GreenArmor(e.thing);
		let armor2 = BlueArmor(e.thing);
		
		let health1 = stimpack(e.thing);
		let health2 = medikit(e.thing);
		
		let keycardB = BlueCard(e.thing);
		let skullkeyB = BlueSkull(e.thing);
		let keycardR = RedCard(e.thing);
		let skullkeyR = RedSkull(e.thing);
		let keycardY = YellowCard(e.thing);
		let skullkeyY = YellowSkull(e.thing);
		
		if ( Level.MapTime > 0 )
			RevertKillCounter(e);
		
		if (b1)
		{  inventory(b1).PickupSound = "misc/a_pkup_b1"; }
		
		if (b2)
		{  inventory(b2).PickupSound = "misc/a_pkup_b2"; }
		
		if (r1)
		{  inventory(r1).PickupSound = "misc/a_pkup_r1"; }
		
		if (r2)
		{  inventory(r2).PickupSound = "misc/a_pkup_r2"; }
		
		if (armor1)
		{  inventory(armor1).PickupSound = "armor/pkup1"; }
		
		if (armor2)
		{  inventory(armor2).PickupSound = "armor/pkup2"; }
		
		if (health1)
		{  inventory(health1).PickupSound = "health/pkup1"; }
		
		if (health2)
		{  inventory(health2).PickupSound = "health/pkup2"; }
		
		if (keycardB)
		{  inventory(keycardB).PickupSound = "KeyCard/pkup"; }
		
		if (skullkeyB)
		{  inventory(skullkeyB).PickupSound = "SkullKey/pkup"; }
		
		if (keycardR)
		{  inventory(keycardR).PickupSound = "KeyCard/pkup"; }
		
		if (skullkeyR)
		{  inventory(skullkeyR).PickupSound = "SkullKey/pkup"; }
		
		if (keycardY)
		{  inventory(keycardY).PickupSound = "KeyCard/pkup"; }
		
		if (skullkeyY)
		{  inventory(skullkeyY).PickupSound = "SkullKey/pkup"; }
	}
	
	override void CheckReplacement(ReplaceEvent e)
	{
		String mapPrefix = level.MapName.Left(3);
        mapPrefix = mapPrefix.MakeLower();
		String mapName = level.MapName.MakeLower();
		
		if (e.Replacee == 'Shin_DoomPlayer')
			e.Replacement = 'playerpawn';
			
		if (e.Replacee == 'Pistol')
			e.Replacement = 'Shin_Pistol';
		
		if (e.Replacee == 'Shotgun')
			e.Replacement = 'Shin_Shotgun';
			
		if (e.Replacee == 'Chaingun')
			e.Replacement = 'Shin_Chaingun';
		
		if (e.Replacee == 'SuperShotgun')
			e.Replacement = 'Shin_SuperShotgun';
			
		if (e.Replacee == 'RocketLauncher')
			e.Replacement = 'Shin_RocketLauncher';
			
		if (e.Replacee == 'chaingunguy')
		{
			if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
				e.Replacement = 'Shin_Machinegunguy';
			else
				e.Replacement = 'Shin_Chaingunguy';
		}
		
		if (wads.FindLump("SC2MTL") && wads.FindLump("PRODIGY") != -1)
		{
			if (e.Replacee == 'wolfensteinss')
				e.Replacement = 'Shin_EvilMarine';
				
			if (mapName != "test")
			{
				if (e.Replacee == 'commanderkeen')
					e.Replacement = 'Shin_Afrit';
			}
		}	
			
		if (e.Replacee == 'doomimp')
			e.Replacement = 'Shin_DoomImp';
			
		if (e.Replacee == 'demon')
			e.Replacement = 'Shin_Pinky';
			
		if (e.Replacee == 'spectre')
			e.Replacement = 'Shin_Spectre';
			
		if (e.Replacee == 'cacodemon')
			e.Replacement = 'Shin_Cacodemon';
		
		/*
		if (e.Replacee == 'baronofhell')
		{
			if ((mapName == "e1m8") ||
				(mapName == "e1m8b") ||
				(mapName == "e2m9") ||
				(mapName == "test"))
			{
				e.Replacement = 'Shin_Baronofhell';
			}
			else
			{
				if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
				{
					e.Replacement = 'Shin_Hellknight';
				}
			}
		}
		*/
		
		if (e.Replacee == 'Shin_Archvile' && (mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" ))
		{
			e.Replacement = 'Shin_Summoner';
		}
		
		if ( mapPrefix == "ab_" )
		{
			if (e.Replacee == 'Chainsaw')
			e.Replacement = 'Shin_Chainsaw';
			
			if (e.Replacee == 'Plasmarifle')
			e.Replacement = 'Shin_Plasmarifle';
			
			if (e.Replacee == 'CommanderKeen')
			e.Replacement = 'Shin_NightmareImp';
			
			if (e.Replacee == 'GibbedMarineExtra')
			e.Replacement = 'Shin_NightmareCacodemon';
		}
	}
	
	void RevertKillCounter(WorldEvent e)
	{
		if ( e.Thing && e.Thing.bCountKill )
			e.Thing.ClearCounters();
	}
}