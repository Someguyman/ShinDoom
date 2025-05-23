Class ShinDoom_Actor : Actor
{
	private int ICONSPAWN;
	flagdef FlagName : ICONSPAWN, 32;
	
	int FootstepSoundChannel;
	sound FootstepSound;
	
	property FootstepSound : FootstepSound;
	property FootstepSoundChannel : FootstepSoundChannel;
	
	Default
	{
		//ShinDoom_Actor.FootstepSound
	}
	
	States
	{
		Crush:
			POL5 A 0;
			POL5 A 0 A_Startsound("Bloody/crush");
			POL5 A -1;
			stop;
	}
	
	void A_BruisAttack()
	{
		let targ = target;
		if (targ)
		{
			if (CheckMeleeRange())
			{
				int damage = random[pr_bruisattack](1, 8) * 10;
				A_StartSound ("baron/melee", CHAN_WEAPON);
				int newdam = target.DamageMobj (self, self, damage, "Melee");
				targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			}
			else
			{
				A_FaceTarget();
				SpawnMissile (target, "BaronBall");
			}
		}
	}
	
	Void A_BspiAttack()
	{
		if (target)
		{
			A_FaceTarget();
			//SpawnMissile(target, "ArachnotronPlasma");
			A_SpawnProjectile("ArachnotronPlasma",19,4);
		}
	}
	
	void A_HKnightAttack()
	{
		A_FaceTarget();
		A_CustomComboAttack("Shin_KnightBall", 32, 10 * random(1, 8), "baron/melee");
	}
	
	void A_GaurdAttack()
	{
		A_FaceTarget();
		A_CustomComboAttack("Shin_Gaurdball", 32, 10 * random(1, 8), "baron/melee");
	}
	
	void A_DualProjectileAttack(Class<Actor> spawntype = "PlasmaBall", double height = 32, double offset = 25)
	{
		A_FaceTarget();
		A_SpawnProjectile(spawntype, height, offset, 0);
		A_SpawnProjectile(spawntype, height,-offset, 0);
	}
	
	void A_FireVolley(Class<Actor> spawntype = "PlasmaBall", int numMissiles = 3, double coneAngle = 30, double spawnHeight = 32, int flags = 0)
	{
		double angStep = coneAngle / (numMissiles - 1);
		for (double pAngle = coneAngle * -0.5; pangle <= coneAngle * 0.5; pAngle += angStep)
		{
			A_SpawnProjectile(spawntype, spawnHeight, angle: pAngle, flags: flags);
		}
	}
	
	void A_Footstep()
	{
		PlayFootstepSound(FootstepSound);
		A_Chase();
	}
	
	private void PlayFootstepSound(sound soundname)
    {
        if (!soundname || !cx_mfs_enabled) return;
		if (Pos.Z > FloorZ || self.bOnMobj || waterlevel > 0) return;
		
        A_StartSound(soundname, FootstepSoundChannel, CHANF_DEFAULT);
    }
}