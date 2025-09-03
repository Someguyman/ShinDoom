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
	}
	
	override void CheckReplacement(ReplaceEvent e)
	{
		String mapPrefix = level.MapName.Left(3);
        mapPrefix = mapPrefix.MakeLower();
		String mapName = level.MapName.MakeLower();
		
		if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
		{
			if (e.Replacee == 'Shin_Archvile')
			e.Replacement = 'Shin_Summoner';
		}
		
		if ( mapPrefix == "ab_" )
		{
			if (e.Replacee == 'Chainsaw')
			e.Replacement = 'Chainsaw';
			
			if (e.Replacee == 'Plasmarifle')
			e.Replacement = 'Plasmarifle';
			
			if (e.Replacee == 'CommanderKeen')
			e.Replacement = 'Shin_NightmareImp';
			
			if (e.Replacee == 'GibbedMarineExtra')
			e.Replacement = 'Shin_NightmareCacodemon';
		}
	}
}