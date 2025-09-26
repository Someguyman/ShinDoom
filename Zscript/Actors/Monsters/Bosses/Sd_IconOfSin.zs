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
		BBRN A 100 A_BrainScream;
		BBRN AA 10;
		BBRN A -1 A_BrainDie;
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
		for (double x = -280; x < +280; x += 8)
		{
			// (1 / 512.) is actually what the original value of 128 did, even though it probably meant 128 map units.
			BrainishExplosion(Vec2OffsetZ(x, -320, (1 / 512.) + random[BrainExplode](0, 255) * 2));
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
}