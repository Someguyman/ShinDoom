//
class Shin_SpiderMastermindBoss : Shin_SpiderMastermind
{
	Default
	{
		Health 10000;
		Radius 128;
		Height 100;
		Mass 1000;
		Speed 12;
		Scale 1.0;
		PainChance 40;
		MissileChanceMult 0.5;
		SeeSound "spider/sight";
		AttackSound "spider/attack";
		PainSound "spider/pain";
		DeathSound "spider/death";
		ActiveSound "spider/active";
		Obituary "$OB_SPIDER";
		Tag "$FN_SPIDER";
	}
	States
	{
	Spawn:
		SPIB AB 10 A_Look;
		Loop;
	See:
		SPIB A 3 A_Metal;
		SPIB ABB 3 A_Chase;
		SPIB C 3 A_Metal;
		SPIB CDD 3 A_Chase;
		SPIB E 3 A_Metal;
		SPIB EFF 3 A_Chase;
		Loop;
	Missile:
		SPIB A 20 BRIGHT A_FaceTarget;
		SPIB G 2 BRIGHT A_SPosAttackUseAtkSound;
		SPIB H 2 BRIGHT A_FaceTarget;
		SPIB H 1 BRIGHT A_SpidRefire;
		Goto Missile+1;
	Pain:
		SPIB I 3;
		SPIB I 3 A_Pain;
		Goto See;
	Death:
		SPIB J 20 A_Scream;
		SPIB K 10 A_NoBlocking;
		SPIB LMNO 10;
		SPIB P 30;
		SPIB P -1 A_BossDeath;
		Stop;
	}
}