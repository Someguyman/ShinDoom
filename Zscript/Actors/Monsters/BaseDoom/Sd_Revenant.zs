
Class Shin_Revenant : ShinDoom_Actor Replaces Revenant
{
	Default
	{
		Health 300;
		Radius 20;
		Height 56;
		Mass 500;
		Speed 10;
		PainChance 100;
		Monster;
		MeleeThreshold 196;
		MissileChanceMult 0.5;
		+FLOORCLIP
		scale 0.95;
		SeeSound "skeleton/sight";
		PainSound "skeleton/pain";
		DeathSound "skeleton/death";
		ActiveSound "skeleton/active";
		MeleeSound "skeleton/melee";
		ShinDoom_Actor.FootstepSound "skeleton/walk";
		HitObituary "$OB_UNDEADHIT";
		Obituary "$OB_UNDEAD";
		Tag "$FN_REVEN";
	}
	States
	{
	Spawn:
		SKEL AB 10 A_Look;
		Loop;
	See:
		SKEL A 2 A_Footstep();
		SKEL ABBCC 2 A_Chase;
		SKEL D 2 A_Footstep();
		SKEL DEEFF 2 A_Chase;
		Loop;
	Melee:
		SKEL G 6 A_FaceTarget;
		SKEL G 0 A_SkelWhoosh;
		SKEL H 6 A_FaceTarget;
		SKEL I 6 A_SkelFist;
		Goto See;
	Missile:
		SKEL J 0 BRIGHT A_FaceTarget;
		SKEL K 16 A_FaceTarget;
		SKEL J 10 BRIGHT A_SkelMissile;
		SKEL K 10 A_FaceTarget;
		Goto See;
	Pain:
		SKEL L 5;
		SKEL L 5 A_Pain;
		Goto See;
	Death:
		SKEL LM 7;
		SKEL N 7 A_Scream;
		SKEL O 7 A_NoBlocking;
		SKEL P 7;
		SKEL Q -1 A_NormalDeath();
		Stop;
	XDeath:
		SKEX A 5;
		SKEX B 5 A_XScream;
		SKEX C 5;
		SKEX D 5 A_NoBlocking();
		SKEX EFG 5;
		SKEX H -1 A_NormalDeath();
		Stop;
	Shin.Raise:
		SKEL P 5;
		SKEL OMN 5;
		Goto See;
	XRaise:
		SKEX E 5;
		SKEX DCBA 5;
		Goto See;
	}
}

Class Shin_RevenantTracer : ShinDoom_Projectile
{
	Default
	{
		Radius 11;
		Height 8;
		Speed 10;
		Damage 7;
		+SEEKERMISSILE 
		scale 0.8;
		SeeSound "skeleton/attack";
		DeathSound "skeleton/tracex";
	}
	States
	{
	Spawn:
		FATB AB 2 BRIGHT A_Tracer;
		Loop;
	Death:
		FBXP A 8 BRIGHT;
		FBXP B 6 BRIGHT;
		FBXP C 4 BRIGHT;
		Stop;
	}
}

Class Shin_RevenantTracerNoHomo : Shin_RevenantTracer
{
	Default
	{
		Speed 12;
	}
	States
	{
	Spawn:
		FATB AB 2 BRIGHT;
		Loop;
	Death:
		FBXP A 8 BRIGHT;
		FBXP B 6 BRIGHT;
		FBXP C 4 BRIGHT;
		Stop;
	}
}

Extend Class Shin_Revenant
{
	Void A_SkelMissile()
	{
		A_Facetarget();
		if (level.maptime & 3)
		{
			A_SpawnProjectile("Shin_RevenantTracerNoHomo",53,-20);
			A_SpawnProjectile("Shin_RevenantTracerNoHomo",54,9);
		}
		else
		{
			A_SpawnProjectile("Shin_RevenantTracer",53,-20);
			A_SpawnProjectile("Shin_RevenantTracer",54,9);
		}
	}
}