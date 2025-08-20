
Class Shin_Tyrant : ShinDoom_Actor
{
	Default
	{
		Health 1000;
		+BOSS 
		+FLOORCLIP
		+NORADIUSDMG
		+DONTMORPH
		+BOSSDEATH
		Radius 40;
		Height 110;
		Mass 1000;
		Speed 16;
		PainChance 20;
		Monster;
		Scale 1.1;
		MinMissileChance 160;
		MissileChanceMult 0.5;
		SeeSound "Tyrant/sight";
		ActiveSound "Tyrant/active";
		PainSound "Tyrant/pain";
		DeathSound "Tyrant/death";
		Obituary "$OB_ID24TYRANT";
		Tag "$FN_ID24TYRANT";
	}
	
	States
	{
		Spawn:
			CYB2 AB 10 A_Look;
			Loop;
		See:
			CYB2 A 3 A_Hoof;
			CYB2 ABBCC 3 A_Chase;
			CYB2 D 0 A_Startsound("Tyrant/hoof");
			CYB2 DD 3 A_Chase;
			Loop;
		Missile:
			CYB2 E 6 A_FaceTarget;
			CYB2 F 6 Bright A_TyrantAttack();
			CYB2 E 18 A_FaceTarget;
			CYB2 F 6 Bright A_TyrantAttack();
			CYB2 E 18 A_FaceTarget;
			CYB2 F 6 Bright A_TyrantAttack();
			Goto See;
		Pain:
			CYB2 G 10 A_Pain;
			Goto See;
	    XDeath:
		 Death:
			CYB2 H 1 Bright;
			CYB2 H 5 Bright A_Scream;
			CYB2 I 6 Bright;
			CYB2 J 6 Bright A_NoBlocking;
			CYB2 KLMNO 6 Bright;
			CYB2 P 30;
			CYB2 P -1 A_BossDeath;
			Stop;
	}
}

Class Shin_Tyrant_boss_1 : Shin_Tyrant
{

}

Class Shin_Tyrant_boss_2 : Shin_Tyrant
{

}

Class Shin_DeadTyrant : Shin_Tyrant
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

Extend Class Shin_Tyrant
{
	void A_TyrantAttack()
	{
		A_FaceTarget();
		A_SpawnProjectile("Shin_EnemyRocket",45,-20,0);
	}
}