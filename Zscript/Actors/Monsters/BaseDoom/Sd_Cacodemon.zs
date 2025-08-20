
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
		HEAD B 5 A_FaceTarget;
		HEAD C 5 A_FaceTarget;
		HEAD D 5 BRIGHT A_CacoAttack();
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
		HEAD L -1 A_SetFloorClip;
		Stop;
	XDeath:
		HEDX A 4 {bFLOATBOB = False;}
		HEDX B 4 A_XScream;
		HEDX C 4;
		HEDX D 4 A_NoBlocking();
		HEDX EFGHI 4;
		HEDX J -1;
		Stop;
	Raise:
		HEAD L 8 A_UnSetFloorClip;
		HEAD KJIHG 8;
		HEAD A 0 {bFLOATBOB = True;}
		Goto See;
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

Class Shin_DeadCaco : Shin_Cacodemon Replaces DeadCacodemon
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			TNT1 A 0 A_Jump(50, "Gibbed");
			Goto Super::DeathStop+3;
		Gibbed:
			Goto Super::XDeath+9;
	}
}

Extend Class Shin_cacodemon
{
	Void A_CacoAttack()
	{
		A_FaceTarget();
		A_CustomMeleeAttack(10 * random(1, 6), "caco/melee");
		A_SpawnProjectile("Shin_CacodemonBall", 22, 0, 0, CMF_BADPITCH);
	}
}