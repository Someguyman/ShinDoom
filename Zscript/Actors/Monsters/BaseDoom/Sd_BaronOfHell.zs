
Class Shin_BaronOfHell : ShinDoom_Actor Replaces Baronofhell
{
	Default
	{
		Health 1200;
		Radius 24;
		Height 64;
		Mass 1000;
		Speed 8;
		PainChance 50;
		Gibhealth 40;
		Monster;
		+FLOORCLIP
		+BOSSDEATH
		+E1M8BOSS
		MissileChanceMult 0.5;
		Species "HellKnoble";
		SeeSound "baron/sight";
		PainSound "baron/pain";
		DeathSound "baron/death";
		ActiveSound "baron/active";
		Obituary "$OB_BARON";
		HitObituary "$OB_BARONHIT";
		ShinDoom_Actor.FootstepSound "Baron/walk";
		Tag "$FN_BARON";
		BloodColor "30 67 23";
		+NOINFIGHTSPECIES
		Scale 1.3;
		+NOFEAR
	}
	
	States
	{
	Spawn:
		BOSS AB 10 A_Look ;
		Loop;
	See:
		BOSS A 3 A_Footstep();
		BOSS ABB 3 A_Chase;
		BOSS C 3 A_Footstep();
		BOSS CDD 3 A_Chase;
		Loop;
	Melee:
	Missile:
		BOSS EF 8 A_FaceTarget;
		BOSS G 8 A_BaronAttack();
		Goto See;
	Pain:
		BOSS H  2;
		BOSS H  2 A_Pain;
		Goto See;
	Death:
		BOSS I  8;
		BOSS J  8 A_Scream;
		BOSS K  8;
		BOSS L  8 A_NoBlocking;
		BOSS MN 8;
		BOSS O -1 A_BossDeath;
		Stop;
	XDeath:
		BOSX A 5;
		BOSX B 5 A_XScream;
		BOSX C 5;
		BOSX D 5 A_NoBlocking();
		BOSX EFGH 5;
		BOSX I -1 A_BossDeath;
		Stop;
	Raise:
		BOSS M 8;
		BOSS LKJI  8;
		Goto See;
	}
}

Class Shin_BaronBall_Big : ShinDoom_Actor
{
	Default
	{
	
	}
	States
	{
	
	}
}

Extend Class Shin_BaronOfHell
{
	void A_BaronAttack()
	{
		let targ = target;
		if (targ)
		{
			if (CheckMeleeRange())
			{
				int damage = random[pr_bruisattack](1, 8) * 20;
				A_StartSound ("baron/melee", CHAN_WEAPON);
				int newdam = target.DamageMobj (self, self, damage, "Melee");
				targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			}
			else
			{
				A_FireVolley("Baronball", 5, 45);
			}
		}
	}
	
	void A_BaronAttack2()
	{
	
	}
}