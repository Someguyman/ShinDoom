
Class Shin_CyberBoss : Shin_Cyberdemon
{
	Default
	{
		Health 10000;
		Radius 40;
		Height 110;
		Mass 1000;
		Speed 16;
		PainChance 2;
		Monster;
		Damage 8;
		+ShinDoom_Actor.STAYDEAD;
		MinMissileChance 160;
		MissileChanceMult 0.5;
		Scale 1.2;
		SeeSound "cyber/sight";
		PainSound "cyber/pain";
		DeathSound "cyber/death";
		ActiveSound "cyber/active";
		Obituary "$OB_CYBORG";
		Tag "$FN_CYBER";
	}
	
	States
	{
		Spawn:
			BCYB A 2 A_Look;
			Loop;
		See:
			BCYB B 3 A_Hoof;
			BCYB BCCDD 3 A_Chase;
			BCYB E 3 A_MetalHoof();
			BCYB E 3 A_Chase;
			Loop;
		Missile:
			BCYB F 6 A_Facetarget;
			BCYB G 6 bright A_CyberdemonAttack();
			BCYB F 14 A_Facetarget;
			BCYB G 6 bright A_CyberdemonAttack();
			BCYB F 14 A_Facetarget;
			BCYB G 6 bright A_CyberdemonAttack();
			BCYB F 14 A_Facetarget;
			BCYB G 6 bright A_CyberdemonAttack();
			Goto See;
		Pain:
			BCYB V 20 A_Pain;
		Stomp:
			BCYB H 6 A_Facetarget;
			BCYB I 8 A_Facetarget;
			// cool shaking stuff
			BCYB I 1 A_SpriteOffset(-1.0);
			BCYB I 1 A_SpriteOffset(1.0);
			BCYB I 1 A_SpriteOffset(-1.0);
			BCYB I 1 A_SpriteOffset(1.0);
			BCYB JK 8;
			BCYB L 6;		
		Dash: //DASHING!!!
			BCYB R 8 A_Facetarget;
			BCYB S 4 A_Facetarget;
			BCYB T 15 A_SkullAttack(40);
			BCYB U 6;
			BCYB A 6 A_ScaleVelocity(0); 
			Goto See;
		Melee:
			BCYB MN 8 A_Facetarget;
			BCYB O 4 A_Facetarget;
			BCYB P 14 A_CyberBossMelee();
			BCYB Q 8 A_Facetarget;
			Goto See;
		Death:
			CYBD AB 8;
			CYBD C 6; //A_Scream;
			CYBD D 15;
			CYBD EF 8;
			CYBD G 12;
			CYBD H 3;
			CYBD G 6;
			CYBD H 3; 
			CYBD G 3;
			CYBD I 6 Bright A_Scream;
			CYBD JK 6 Bright; 
			CYBD L 6 bright A_NoBlocking;
			CYBD MNO 6 bright;
			CYBD P 30;
			CYBD P -1 A_BossDeath;
			Stop;
		XDeath:
			Stop;
	}
}

extend class Shin_Cyberboss
{
	Void A_CyberBossMelee()
	{
		A_Facetarget();
		A_CustomMeleeAttack(10 * random(5, 8));
		A_Startsound("weapons/calamityblade/shoot", CHAN_BODY);
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, -20.0);
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, -15.0);
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, -10.0);
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, -5.0);
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, 0); 
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, 5.0);
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, 10.0); 
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, 15.0); 
		A_SpawnProjectile("ID24IncineratorProjectile", 32, 0, 20.0); 
		A_FaceTarget(); 
	}
	
	void A_CyberdemonAttack()
	{
		A_FaceTarget();
		A_SpawnProjectile("Shin_EnemyRocket",65,-28,0,CMF_BADPITCH);
	}
}