
Class Shin_Cybruiser : Shin_BaronOfHell
{
  Default
  {
		Health 700;
		PainChance 15;
		Speed 8;
		Obituary "%o was blown away by a Cybruiser.";
		HitObituary "%o was smashed by a Cybruiser.";
		SeeSound "Cybruiser/sight";
		ActiveSound "Cybruiser/active";
		PainSound "Cybruiser/pain";
		DeathSound "Cybruiser/death";
		BloodColor "red";
		Scale 1.2;
		-BOSSDEATH
		-E1M8BOSS
		+FLOORCLIP
		+NORADIUSDMG
		Tag "Cybruiser";
  }
	
	States
	{
	Spawn:
		CBOS AB 10 A_Look;
		Loop;
	See:
		CBOS A 3 A_Cybrustomp();
		CBOS ABB 3 A_Chase();
		CBOS C 3 A_Cybrustomp();
		CBOS CDD 3 A_Chase();
		Loop;
	Melee:
		CBOS GH 8 A_FaceTarget();
		CBOS I 8 A_CustomMeleeAttack(10 * random(1, 8),"knight/melee");
		Goto See;
	Missile:
		CBOS E 10 A_FaceTarget;
		CBOS F 6 Bright A_CybruAttack("Shin_EnemyRocket");
		CBOS E 8 A_FaceTarget;
		Goto See;
	Pain:
		CBOS J 2;
		CBOS J 2 A_Pain;
		Goto See;
	Death.Ice:
		CBOS J 5 A_GenericFreezeDeath;
		TNT1 A 1 A_Freezedeathchunks;
		WAIT;
	XDeath:
	Death:
		CBOS K 1 Bright;
		CBOS K 5 Bright A_Scream();
		CBOS LMN 6 Bright;
		CBOS O 6 Bright A_NoBlocking();
		CBOS QR 6 Bright;
		CBOS S 6;
		CBOS T -1 A_BossDeath();
		Stop;
	Raise:
		stop;
	}
}

Extend Class Shin_Cybruiser
{
	Void A_CybruAttack(Class<Actor> p)
	{
		A_FaceTarget();
		A_SpawnProjectile(p,32,12,0,CMF_BADPITCH);
	}
	
	void A_Cybrustomp()
	{
		A_StartSound("Cybruiser/Walk", CHAN_BODY, CHANF_DEFAULT, 1, ATTN_IDLE);
		A_Chase();
	}
}