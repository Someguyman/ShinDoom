//
class Shin_PainElemental : ShinDoom_Actor Replaces PainElemental
{
	Default
	{
		Health 400;
		Radius 31;
		Height 56;
		Mass 400;
		Speed 8;
		PainChance 128;
		Monster;
		+FLOAT 
		+NOGRAVITY
		//+FLOATBOB
		+NEVERRESPAWN
		+DONTGIB
		+ZDOOMTRANS
		SeeSound "pain/sight";
		PainSound "pain/pain";
		DeathSound "pain/death";
		ActiveSound "pain/active";
		Tag "$FN_PAIN";
		Scale 1.2;
		FloatBobStrength 0.5;
	}
	States
	{
	Spawn:
		PAIN AB 10 { A_Look(); bFLOATBOB = True; }
		Loop;
	See:
		PAIN AABBCC 3 A_Chase;
		Loop;
	Missile:
		PAIN D 5 A_FaceTarget;
		PAIN E 5 A_FaceTarget;
		PAIN F 5 BRIGHT A_FaceTarget;
		PAIN F 0 BRIGHT A_PainAttack();
		Goto See;
	Pain:
		PAIN G 6;
		PAIN G 6 A_Pain;
		Goto See;
	Death.Ice:
		PAIN G 0 {bFLOATBOB = False;}
		PAIN G 5 A_GenericFreezeDeath;
		TNT1 A 1
		{
		A_PainDie();
		A_Freezedeathchunks();
		}
		WAIT;
	Death:
		PAIN H 8 BRIGHT {bFLOATBOB = False;}
		PAIN I 8 BRIGHT A_Scream;
		PAIN J 8 BRIGHT;
		PAIN K 8 BRIGHT;
		PAIN L 8 BRIGHT A_PainDie;
		PAIN M 8 BRIGHT A_FadeOut(0.247059);
		Stop;
	Crush:
		stop;
	Raise:
		Stop;
	}
}