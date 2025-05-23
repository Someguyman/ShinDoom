//
class Shin_Cacodemon : ShinDoom_Actor Replaces Cacodemon
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
		+FLOAT +NOGRAVITY //+FLOATBOB
		BloodColor "blue";
		FloatBobStrength 0.5;
		Scale 1.1;
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
		HEAD A 3 A_Chase;
		Loop;
	Missile:
		HEAD B 5 A_FaceTarget;
		HEAD C 5 A_FaceTarget;
		HEAD D 5 BRIGHT A_HeadAttack;
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
		HEAD G 8;
		HEAD H 8 A_Scream;
		HEAD I 8;
		HEAD J 8;
		HEAD K 8 A_NoBlocking;
		HEAD L -1 A_SetFloorClip;
		Stop;
	XDeath:
		HEDX A 1 {bFLOATBOB = False;}
		HEDX A 3;
		HEDX B 4 A_XScream;
		HEDX C 4;
		HEDX D 4 A_NoBlocking();
		HEDX EFGHI 4;
		HEDX J -1;
		Stop;
	Raise:
		HEAD L 8 A_UnSetFloorClip;
		HEAD KJIHG 8;
		Goto See;
	}
}