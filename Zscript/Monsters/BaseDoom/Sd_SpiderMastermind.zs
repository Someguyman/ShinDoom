//
class Shin_SpiderMastermind : ShinDoom_Actor Replaces SpiderMastermind
{
	Default
	{
		Health 3000;
		Radius 77;
		Height 100;
		Mass 2000;
		Speed 12;
		PainChance 40;
		MissileChanceMult 0.5;
		Monster;
		+BOSS
		+FLOORCLIP
		+NORADIUSDMG
		+DONTMORPH
		+BOSSDEATH
		+E3M8BOSS
		+E4M8BOSS
		+NOFEAR
		Scale 1.1;
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
		SPID AB 10 A_Look;
		Loop;
	See:
		SPID A 3 A_Metal;
		SPID ABB 3 A_Chase;
		SPID C 3 A_Metal;
		SPID C 3 A_Chase;
		SPID D 3 A_Metal;
		SPID DEE 3 A_Chase;
		SPID F 3 A_Metal;
		SPID F 3 A_Chase;
		Loop;
	Missile:
		SPID A 20 A_FaceTarget;
		SPID G 2 BRIGHT A_SPosAttackUseAtkSound;
		SPID H 2 BRIGHT A_FaceTarget;
		SPID H 1 BRIGHT A_SpidRefire;
		Goto Missile+1;
	Pain:
		SPID I 3;
		SPID I 3 A_Pain;
		Goto See;
	Death:
		SPID J 1;
		SPID J 19 A_Scream;
		SPID K 10 A_NoBlocking;
		SPID LMNOPQR 10 Bright;
		SPID S 30;
		SPID S -1 A_BossDeath;
		Stop;
	}
}