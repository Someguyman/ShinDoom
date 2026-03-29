//

class Shin_BossBrain : ShinDoom_Actor Replaces Bossbrain
{
	Default
	{
		Health 250;
		Mass 10000000;
		PainChance 255;
		Radius 16;
		+SOLID +SHOOTABLE
		+NOICEDEATH
		+OLDRADIUSDMG
		PainSound "brain/pain";
		DeathSound "brain/death";
	}
	States
	{
	Spawn:
		BBRN A -1;
		Stop;
	Pain:
		BBRN B 36 A_BrainPain;
		Goto Spawn;
	Death:	
		BBRN B 100 A_BrainScream;
		BBRN BB 10;
		BBRN B -1 A_BrainDie;
		Stop;
	Death.InstantEnd:
		BBRN B -1 A_BrainDie;
		Stop;
	}
}

class Shin_BossEye : ShinDoom_Actor Replaces Bosseye
{
	Default
	{
		
		Height 32;
		+NOBLOCKMAP
		+NOSECTOR
		+ISMONSTER
		-COUNTKILL 
		+DONTGIB
	}
	States
	{
	Spawn:
		SSWV A 10 A_Look;
		Loop;
	See:
		SSWV A 181 A_BrainAwake;
		SSWV A 150 A_BrainSpit("Shin_SpawnShot");
		Wait;
	}
}

class Shin_SpawnShot : ShinDoom_Actor Replaces SpawnShot
{
	Default
	{
		Radius 6;
		Height 32;
		Speed 10;
		Damage 3;
		Projectile;
		+NOCLIP
		-ACTIVATEPCROSS
		+RANDOMIZE
		+ISMONSTER
		+DONTFALL
		-COUNTKILL
		+NOSPRITESHADOW
		SeeSound "brain/spit";
		DeathSound "brain/cubeboom";
	}
	States
	{
	Spawn:
		BOSF A 3 BRIGHT A_SpawnSound;
		BOSF BCD 3 BRIGHT A_SpawnFly;
		Loop;
	Death:
		TNT1 A 0;
		Stop;
	}
}

Class Shin_SpawnCube : ShinDoom_Actor
{
	Default
	{
		Radius 20;
		Height 56;
		Health 10;
		Speed 0;
		monster;
		+NOBLOOD
		//Dropitem "Shin_Spectre", -1, 128;
		//Dropitem "Shin_Spectre_DoomImp", -1, 128;
		//Deathsound "brain/cubeboom";
	}
	States
	{
		Spawn:
			BOSF A 4 Bright { A_Look(); A_Startsound("brain/cube"); }
			BOSF BCD 4 Bright A_Look();
			Loop;
		See:
			BOSF A 4 Bright A_Startsound("brain/cube");
			BOSF BCD 4 Bright;
			Loop;
		Death:
			FIRE A 0 A_NoBlocking();
			FIRE A 4 A_CubeSpawn();
			FIRE BCDEFGH 4 Bright A_Fire;
			Stop;
	}
}

Class Shin_SpawnCube_Large : Shin_SpawnCube
{
	Default
	{
		Scale 2.0;
		///*
		Dropitem "Shin_Arachnotron", -1, 128;
		Dropitem "Shin_Mancubus", -1, 128;
		Dropitem "Shin_Mindweaver", -1, 90;
		Dropitem "Shin_Archvile", -1, 90;
		Dropitem "Shin_Baronofhell", -1, 90;
		Dropitem "Shin_Vassago", -1, 60;
		Dropitem "Shin_Tyrant", -1, 60;
		Dropitem "Shin_Cyberdemon", -1, 30;
		//*/
		//Dropitem "Shin_Spidermastermind", -1, 30;
	}
}

Extend Class Shin_Bossbrain
{
	private static void BrainishExplosion(vector3 pos)
	{
		Actor boom = Actor.Spawn("Rocket", pos, NO_REPLACE);
		if (boom)
		{
			boom.DeathSound = "misc/brainexplode";
			boom.Vel.z = random[BrainScream](0, 255)/128.;

			boom.SetStateLabel ("Brainexplode");
			boom.bRocketTrail = false;
			boom.SetDamage(0);	// disables collision detection which is not wanted here
			boom.tics -= random[BrainScream](0, 7);
			if (boom.tics < 1) boom.tics = 1;
		}
	}

	void A_BrainScream()
	{	
		int Ypos;
		int Zpos;
		int Xpos;
		
		if(level.GetChecksum() == '42B68B84FF8E55F264C31E6F4CFEA82D')
		{
			Ypos = 623;
		}
		else
		{
			Ypos = -320;
		}
		
		for (double x = -280; x < +280; x += 8)
		{
			// (1 / 512.) is actually what the original value of 128 did, even though it probably meant 128 map units.
			BrainishExplosion(Vec2OffsetZ(x, Ypos, (1 / 512.) + random[BrainExplode](0, 255) * 2));
		}
		A_StartSound("brain/death", CHAN_VOICE, CHANF_DEFAULT, 1., ATTN_NONE);
		
		// New dmflag: Kill all boss spawned monsters before ending the level.
			int count;	// Repeat until we have no more boss-spawned monsters.
			ThinkerIterator it = ThinkerIterator.Create("Actor");
			do			// (e.g. Pain Elementals can spawn more to kill upon death.)
			{
				Actor mo;
				it.Reinit();
				count = 0;
				while (mo = Actor(it.Next()))
				{
					if (mo.health > 0 && mo.bBossSpawned)
					{
						mo.DamageMobj(self, self, mo.health, "None", DMG_NO_ARMOR|DMG_FORCED|DMG_THRUSTLESS|DMG_NO_FACTOR);

						// [Blue Shadow] If 'mo' is a RandomSpawner or another actor which can't be killed,
						// it could cause this code to loop indefinitely. So only let it trigger a loop if it
						// has been actually killed.
						if (mo.bKilled) count++;
					}
				}
			} while (count != 0);
	}
	
	void A_BrainExplode()
	{
		double x = random2[BrainExplode]() / 32.;
		Vector3 pos = Vec2OffsetZ(x, 0, 1 / 512. + random[BrainExplode]() * 2);
		BrainishExplosion(pos);
	}
	
	override void Die(Actor source, Actor inflictor, int dmgflags, Name MeansOfDeath)
	{
		if(level.GetChecksum() == '42B68B84FF8E55F264C31E6F4CFEA82D')
			ACS_NamedExecuteAlways("TNTSkyChange",0);
			
		super.Die(source, inflictor, dmgflags, MeansOfDeath);
	}	
}

Extend Class Shin_Spawncube
{
	
	Void A_CubeSpawn()
	{
		if (DamageType == 'Massacre') return;
		
		A_Facetarget();
		A_StartSound("brain/cubeboom");
		
		Actor newmobj;
		int r;
		
		DropItem di;   // di will be our drop item list iterator
		DropItem drop; // while drop stays as the reference point.
		int n = 0;
		
		class<Actor> SpawnName = null;
		
		drop = GetDropItems();
		
		if (drop != null)
		{
			for (di = drop; di != null; di = di.Next)
			{
				if (di.Name != 'None')
				{
					int amt = di.Amount;
					if (amt < 0)
					{
						amt = 1; // default value is -1, we need a positive value.
					}
					n += amt; // this is how we can weight the list.
				}
			}
			di = drop;
			n = random[pr_spawnfly](0, n);
			while (n >= 0)
			{
				if (di.Name != 'none')
				{
					int amt = di.Amount;
					if (amt < 0)
					{
						amt = 1;
					}
					n -= amt;
				}
				if ((di.Next != null) && (n >= 0))
				{
					di = di.Next;
				}
				else
				{
					n = -1;
				}
			}
			SpawnName = di.Name;
		}
		if (SpawnName == null)
		{
			// Randomly select monster to spawn.
			r = random[pr_spawnfly](0, 255);

			// Probability distribution (kind of :),
			// decreasing likelihood.
				 if (r < 50)  SpawnName = "DoomImp";
			else if (r < 90)  SpawnName = "Demon";
			else if (r < 120) SpawnName = "Spectre";
			else if (r < 130) SpawnName = "PainElemental";
			else if (r < 160) SpawnName = "Cacodemon";
			else if (r < 162) SpawnName = "Archvile";
			else if (r < 172) SpawnName = "Revenant";
			else if (r < 192) SpawnName = "Arachnotron";
			else if (r < 222) SpawnName = "Fatso";
			else if (r < 246) SpawnName = "HellKnight";
			else			  SpawnName = "BaronOfHell";
		}
		if (spawnname != null)
		{
			newmobj = Spawn (spawnname, self.pos, ALLOW_REPLACE);
			if (newmobj != null)
			{
				newmobj.CopyFriendliness (self, false);
				// Make it act as if it was around when the player first made noise
				// (if the player has made noise).
				newmobj.LastHeard = newmobj.CurSector.SoundTarget;

				if (newmobj.SeeState != null && newmobj.LookForPlayers (true))
				{
					newmobj.SetState (newmobj.SeeState);
				}
				if (!newmobj.bDestroyed)
				{
					// telefrag anything in this spot
					newmobj.TeleportMove (newmobj.pos, true);
				}
				newmobj.bBossSpawned = true;
			}
		}
	}
}