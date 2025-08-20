
Class Shin_Cyberdemon : ShinDoom_Actor Replaces Cyberdemon
{
	Default
	{
		Health 4000;
		GibHealth 10000;
		Radius 40;
		Height 110;
		Mass 1000;
		Speed 16;
		PainChance 20;
		Monster;
		MinMissileChance 160;
		MissileChanceMult 0.5;
		+BOSS 
		+FLOORCLIP
		+NORADIUSDMG
		+DONTMORPH
		+BOSSDEATH
		+E2M8BOSS
		+E4M6BOSS
		Scale 1.1;
		SeeSound "cyber/sight";
		PainSound "cyber/pain";
		DeathSound "cyber/death";
		ShinDoom_Actor.XDeathSound "cyber/death";
		ActiveSound "cyber/active";
		Obituary "$OB_CYBORG";
		Tag "$FN_CYBER";
	}
	
	States
	{
	Spawn:
		CYBR AB 10 A_Look;
		Loop;
	See:
		CYBR A 3 A_Hoof;
		CYBR ABBCC 3 A_Chase;
		CYBR D 3 A_MetalHoof();
		CYBR D 3 A_Chase;
		Loop;
	Missile:
		CYBR E 6 A_FaceTarget;
		CYBR F 6 Bright A_CyberdemonAttack();
		CYBR E 18 A_FaceTarget;
		CYBR F 6 Bright A_CyberdemonAttack();
		CYBR E 18 A_FaceTarget;
		CYBR F 6 Bright A_CyberdemonAttack();
		Goto See;
	Pain:
		CYBR G 10 A_Pain;
		Goto See;
	Death:
		CYBR H 1 Bright;
		CYBR H 9 Bright A_Scream;
		CYBR H 2 Bright;
		CYBR H 0 Bright A_NoBlocking;
		CYBR I 8 Bright A_Cyberexplode();
		CYBR I 2 Bright A_Cyberexplode();
		CYBR JJKKLLMM 5 Bright A_Cyberexplode();
		CYBR NO 10 Bright;
		CYBR P 30;
		CYBR P -1 A_BossDeath;
		Stop;
	  XDeath:
		CYBR H 1 Bright;
		CYBR H 5 Bright A_XScream;
		CYBR I 6 Bright;
		CYBR J 6 Bright A_NoBlocking;
		CYBR KLMNO 6 Bright;
		CYBR P 30;
		CYBR P -1 A_BossDeath;
		Stop;
	}
}

Class Shin_EnemyRocket : Shin_PlayerRocket Replaces Rocket
{
	Default
	{
		Speed 20;
		FastSpeed 25;
		SeeSound "cyber/attack";
		DeathSound "cyber/shotx";
	}
	States
	{
	Spawn:
		CMIS A 1 Bright;
		Loop;
	}
}

Class Shin_DeadCyberdemon : Shin_Cyberdemon
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
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
			Goto Super::Death+9;
	}
}

Extend Class Shin_Cyberdemon
{
	void A_CyberdemonAttack()
	{
		A_FaceTarget();
		A_SpawnProjectile("Shin_EnemyRocket",52,-28,0,CMF_BADPITCH);
	}
	
	Void A_Cyberexplode()
	{
		A_SpawnProjectile("Shin_BossExplosion",FRandom(20,80),FRandom(20,-20),FRandom(0,360),2,FRandom(0,360));
	}
}