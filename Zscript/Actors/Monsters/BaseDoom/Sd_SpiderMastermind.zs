
Class Shin_SpiderMastermind : ShinDoom_Actor Replaces SpiderMastermind
{
	Default
	{
		Health 3000;
		GibHealth 10000;
		Radius 77;
		Height 100;
		Mass 1000;
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
		ShinDoom_Actor.XDeathSound "spider/Xdeath";
		Obituary "$OB_SPIDER";
		Tag "$FN_SPIDER";
	}
	
	States
	{
	Spawn:
		SPID AB 10 A_Look;
		Loop;
	See:
		SPID AA 3 A_Chase;
		SPID B 3 A_Spiderweer();
		SPID BCC 3 A_Chase;
		SPID D 3 A_Metal();
		SPID D 3 A_Chase;
		SPID E 3 A_Spiderweer();
		SPID EFF 3 A_Chase;
		SPID A 3 A_Metal();
		Goto see+1;
	Missile:
		SPID A 20 A_FaceTarget;
		SPID H 2 BRIGHT A_SpidAttack();
		SPID G 2 BRIGHT A_FaceTarget;
		SPID H 1 BRIGHT A_SpidRefire;
		Goto Missile+1;
	Pain:
		SPID I 3;
		SPID I 3 A_Pain;
		Goto See;
	Death:
		SPID I 1 Bright;
		SPID J 19 Bright A_Scream;
		SPID J 0 Bright A_NoBlocking;
		SPID KL 10 Bright A_Spiderexplode();
		SPID M 8 Bright A_Spiderexplode();
		SPID M 2 Bright A_Spiderexplode();
		SPID NNOOPPQQ 5 Bright A_Spiderexplode();
		SPID R 10 Bright;
		SPID S 30;
		SPID S -1 A_BossDeath;
		Stop;
	XDeath:
		SPID J 1;
		SPID J 9 A_XScream();
		SPID K 6 A_NoBlocking;
		SPID LMNOPQR 6 Bright;
		SPID S 30;
		SPID S -1 A_BossDeath;
		Stop;
	}
}

Extend Class Shin_SpiderMastermind
{	
	void A_Spiderweer()
	{
		A_StartSound("Misc/MechanicalWeer", CHAN_AUTO, CHANF_DEFAULT, 1, ATTN_IDLE);
		A_Chase();
	}
	
	Void A_SpidAttack()
	{
		A_FaceTarget();
		A_CustomBulletAttack(22.5, 7.1, 7, 6, "BulletPuff", 0, CBAF_NORANDOM);
	}
	
	Void A_Spiderexplode()
	{
		A_SpawnProjectile("Shin_BossExplosion",FRandom(10,60),FRandom(30,-30),FRandom(0,360),2,FRandom(0,360));
	}
}