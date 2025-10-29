
Class Shin_Cacodemon : ShinDoom_Actor Replaces Cacodemon
{
	Default
	{
		Health 400;
		Radius 31;
		Height 56;
		Mass 400;
		Speed 8;
		Gibhealth 20;
		PainChance 128;
		Monster;
		+FLOAT +NOGRAVITY
		BloodColor "blue";
		FloatBobStrength 0.5;
		FloatBobFactor 0.8;
		Scale 1.1;
		Species "Cacodemon";
		SeeSound "caco/sight";
		PainSound "caco/pain";
		DeathSound "caco/death";
		ActiveSound "caco/active";
		Obituary "$OB_CACO";
		HitObituary "$OB_CACOHIT";
		Tag "$FN_CACO";
	}
	
	States
	{
	Spawn:
		HEAD A 10 { A_Look(); bFLOATBOB = True; }
		Loop;
	See:
		HEAD A 3 A_Chase();
		Loop;
	Missile:
		HEAD B 0 A_Jump(40, "Missile2");
		HEAD B 0 A_Jump(40, "Missile3");
		HEAD B 5 A_FaceTarget(); 
		HEAD C 5 A_FaceTarget;
		HEAD D 5 BRIGHT A_HeadAttack();
		HEAD B 0 A_Jump(50, "Missile3");
		Goto See;
	Missile2:
		HEAD E 5 A_FaceTarget;
		HEAD P 5 A_FaceTarget;
		HEAD Q 5 A_FaceTarget;
		HEAD RRR 5 BRIGHT A_HeadAttack();
		HEAD Q 0 A_Jump(50, "Missile3");
		Goto See;
	Missile3:
		HEAD M 5 A_FaceTarget; 
		HEAD N 5 A_FaceTarget;
		HEAD O 5 BRIGHT A_HeadAttack2();
		HEAD M 5 A_FaceTarget; 
		Goto See;
	Melee:
		HEAD C 4 A_FaceTarget();
		HEAD DC 6 A_FaceTarget();
		HEAD B 6 A_CustomMeleeAttack(30,"caco/melee");
		Goto See;
	Pain:
		HEAD E 3;
		HEAD E 3 A_Pain;
		HEAD F 6;
		Goto See;
	Death:
		HEAD G 8 { bFLOATBOB = False; }
		HEAD H 8 A_Scream;
		HEAD I 7;
	DeathLoop:
		HEAD I 1 A_CheckFloor("DeathStop");
		Loop;
	DeathStop:
		HEAD J 0 A_StartSound("caco/deathland", 0);
		HEAD J 8;
		HEAD K 8 A_NoBlocking;
		HEAD L -1 { A_SetFloorClip; A_NormalDeath(); }
		Stop;
	XDeath:
		HEDX A 4 {bFLOATBOB = False; }
		HEDX B 4 A_XScream;
		HEDX C 4;
		HEDX D 4 A_NoBlocking;
		HEDX EFGHI 4;
		HEDX J -1 { A_SetFloorClip; A_NormalDeath(); }
		Stop;
	Shin.Raise:
		HEAD L 8 A_UnSetFloorClip;
		HEAD KJIHG 8;
		HEAD A 0 {bFLOATBOB = True; }
		Goto See;
	XRaise:
		HEDX H 5 A_UnSetFloorClip;
		HEDX GFEDCBA 5;
		HEDX A 0 {bFLOATBOB = True; }
		Goto See;
	Crush.Loop:
		HEGI A -1;
		Stop;
	}
}

Class Shin_CacodemonBall : ShinDoom_Actor
{
	Default
	{
		Radius 6;
		Height 8;
		Speed 10;
		FastSpeed 20;
		Damage 5;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 1;
		SeeSound "caco/attack";
		DeathSound "caco/shotx";
	}
	States
	{
	Spawn:
		BAL6 AB 4 BRIGHT;
		Loop;
	Death:
		BAL6 CDE 6 BRIGHT;
		Stop;
	}
}

Class Shin_Cacodemonball2 : Shin_CacodemonBall
{
	States
	{
		Spawn:
			BAL2 AB 4 BRIGHT;
			Loop;
		Death:
			BAL2 CDE 6 BRIGHT;
			Stop;
	}
}

Extend Class Shin_cacodemon
{
	void A_HeadAttack()
	{
		let targ = target;
		if (targ)
		{
			if (CheckMeleeRange())
			{
				int damage = random[pr_headattack](1, 6) * 10;
				A_StartSound (AttackSound, CHAN_WEAPON);
				int newdam = target.DamageMobj (self, self, damage, "Melee");
				targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			}
			else
			{
				// launch a missile
				A_FaceTarget();
				A_SpawnProjectile("Shin_CacodemonBall", 22, 0, 0, CMF_BADPITCH);
			}
		}
	}
	
	void A_HeadAttack2()
	{
		let targ = target;
		if (targ)
		{
			if (CheckMeleeRange())
			{
				int damage = random[pr_headattack](1, 6) * 10;
				A_StartSound (AttackSound, CHAN_WEAPON);
				int newdam = target.DamageMobj (self, self, damage, "Melee");
				targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			}
			else
			{
				// launch a missile
				A_FaceTarget();
				A_SpawnProjectile("Shin_PlasmaBall3", 22, 0, 0, CMF_BADPITCH);
			}
		}
	}
}