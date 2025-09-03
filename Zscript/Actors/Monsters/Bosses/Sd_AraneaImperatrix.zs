
class Shin_SpiderBoss : Shin_SpiderMastermind
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
	
	Void A_SpiderAttack()
	{
		static const Class<Actor> PlasmaFire[] =
		{
			'Shin_PlasmaBall1',
			'Shin_PlasmaBall2'
		};
		
		A_FaceTarget();
		A_SpawnProjectile(PlasmaFire[Random(0,1)],32,0,random(-16,16),CMF_OFFSETPITCH,random(-4,4));
		A_SpawnProjectile(PlasmaFire[Random(0,1)],32,0,random(-16,16),CMF_OFFSETPITCH,random(-4,16));
		A_SpawnProjectile(PlasmaFire[Random(0,1)],32,0,random(-16,16),CMF_OFFSETPITCH,random(-4,4));
		A_SpawnProjectile(PlasmaFire[Random(0,1)],32);
	}
	
	States
	{
	Spawn:
		SPIB A 10 A_Look;
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
		SPIB G 2 BRIGHT A_SpiderAttack();
		SPIB H 2 BRIGHT A_FaceTarget;
		SPIB H 1 BRIGHT A_SpidRefire;
		Goto Missile+1;
	Pain:
		SPIB M 3;
		SPIB M 3 A_Pain;
		Goto See;
	Death:
		SPIB N 20 A_Scream;
		SPIB O 10 A_NoBlocking;
		SPIB PQ 10;
		SPIB R 50;
		SPIB STU 6 bright;
		SPIB V 30;
		SPIB V -1 A_BossDeath;
		Stop;
	XDeath:
		Stop;
	}
}