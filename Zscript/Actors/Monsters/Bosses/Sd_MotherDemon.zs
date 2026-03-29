
Class Shin_Motherdemon : ShinDoom_Actor
{
	Default
	{
		Health 5000;
		Radius 40;
		Height 105;
		Mass 10000;
		Speed 30;
		PainChance 50;
		Monster;
		FloatBobStrength 0.5;
		MinMissileChance 160;
		MissileChanceMult 0.0625;
		ReactionTime 8;
		+BOSS
		+NOFEAR
		+FLOORCLIP
		+NORADIUSDMG
		+DONTMORPH
		+BOSSDEATH
		+FLOAT
		+NOGRAVITY
		+NOTELEFRAG
		+DROPOFF
		SeeSound "mother/sight";
		AttackSound "";
		PainSound "mother/pain";
		DeathSound "mother/death";
		ActiveSound "mother/active";
		Obituary "$OB_MOTHER";
		Tag "Motherdemon";
	}
	
	States
	{
		Spawn:
			MOTH AB 10 A_Look;
			Loop;
		See:
			MOTH AAABBBAAACCC 3 A_RectChase();
			Loop;
		Melee:
			MOTH D 4 BRIGHT A_RectGroundFire();
			MOTH E 4 Bright;
			MOTH F 4 Bright;
			MOTH G 6 Bright;	
			MOTH H 6 BRIGHT A_FaceTarget;
			MOTH I 12 BRIGHT A_RectAttack();
			MOTH D 8 Bright;
			Goto See;
		Pain:
			MOTH J 1;
			MOTH J 7 A_Pain;
			MOTH J 18;
			Goto Melee;
		Death:
			MOTH K 1;
			MOTH K 19 A_Scream;
			MOTH L 10 A_Fall;
			MOTH MN 8;
			MOTH OPQR 6;
			MOTH S 48;
			MOTH S -1 A_BossDeath;
			Stop;
	}
}

Class Shin_GroundFire : ShinDoom_Projectile
{
	Default
	{
		Radius 16;
        Height 64;
        Speed 20;
        FastSpeed 40;
        Damage 5;
		DamageType "ThrustZ";
        SeeSound "mother/missile";
        DeathSound "fatso/shotx";
		-RANDOMIZE;
        +NODECAL;
        +NODAMAGETHRUST;
		+NOFRICTION;
		+FLOORHUGGER;
		+STEPMISSILE;
		+USEBOUNCESTATE;
		+NOFRICTIONBOUNCE;
		BounceFactor 0.1;
		BounceType "Classic";
		//Obituary "$OB_MOTHER";
	}
	
	States
	{
		Spawn:
			GFIR ABCD 3 BRIGHT A_SpawnItemEx("Shin_GroundFireTrail");
			loop;
			
		Bounce:
			GFIR A 1 { bUSEBOUNCESTATE = false; }
			Goto Spawn;
			
		Death:
			GFRX A 6 BRIGHT { bUSEBOUNCESTATE = false; }
			GFRX B 6 BRIGHT;
			GFRX C 6 BRIGHT;
			Stop;
	}
}

Class Shin_GroundFireTrail : ShinDoom_Projectile
{
	Default
	{
		Radius 16;
        Height 64;
        +NOBLOCKMAP;
        +NOGRAVITY;
		+FLOORHUGGER;
        //+NOTONAUTOMAP;
	}
	States
	{
		Spawn:
			TNT1 A 2;
			GFRE ABCD 4 Bright;
			Stop;
	}
}

class Shin_MotherTracer : Shin_RevenantTracer
{
	Default
	{
		Radius 11;
		Height 8;
		Speed 18;
		Damage 10;
		//RenderStyle "Add";
		threshold 0;
	}
	
	void A_RectTracer()
    {
		if (threshold < 0)
		{
			A_Tracer2();
			A_SpawnItemEx("Shin_MDTracerSmoke", 0, 0, 0, 0, 0, 0, 0, 128); 
		}
		else
		{
			threshold--;
		}
    }
	
	States
	{
	Spawn:
		RMIS AB 2 BRIGHT A_RectTracer();
		Loop;
	Death:
		RMIX A 8 BRIGHT;
		RMIX B 6 BRIGHT;
		RMIX C 4 BRIGHT;
		Stop;
	}
}

class Shin_MDTracerSmoke : RevenantTracerSmoke
{
	States
	{	
	Spawn:
		TNT1 A 2;
		PUFF ABABC 4;
		Stop;
	}
}

Extend Class Shin_MotherDemon
{
		
	void A_RectChase(int targetRange = 600)
	{
		if(!target || target.health <= 0 
		|| !(Distance2D(target) < targetRange
		&& CheckSight(target, SF_SEEPASTBLOCKEVERYTHING|SF_SEEPASTSHOOTABLELINES)))
		{
			A_Chase();
			return;
		}

		A_FaceTarget();
		SetState(meleestate);
	}
	
	Void A_RectAttack(Class<Actor> spawntype = "Shin_MotherTracer")
	{
		A_FaceTarget();
		Actor proj;
		proj = A_SpawnProjectile(spawntype, 40, 30, -90, CMF_AIMDIRECTION|CMF_BADPITCH);// Arm 1
		if (proj) proj.threshold = int(Round(5 * actor.TICRATE/30.0));
		proj = A_SpawnProjectile(spawntype, 80, 30, -90, CMF_AIMDIRECTION|CMF_BADPITCH);// Arm 2
		if (proj) proj.threshold = int(Round(1 * actor.TICRATE/30.0));
		proj = A_SpawnProjectile(spawntype, 40, -30, 90, CMF_AIMDIRECTION|CMF_BADPITCH);// Arm 3
		if (proj) proj.threshold = int(Round(5 * actor.TICRATE/30.0));
		proj = A_SpawnProjectile(spawntype, 80, -30, 90, CMF_AIMDIRECTION|CMF_BADPITCH);// Arm 4
		if (proj) proj.threshold = int(Round(1 * actor.TICRATE/30.0));
	}
	
	void A_RectGroundFire(Class<Actor> spawntype = "Shin_GroundFire")
    {
        A_FaceTarget();
        A_SpawnProjectile(spawntype, 0, 0, 0, CMF_AIMDIRECTION|CMF_BADPITCH, 0);
		A_SpawnProjectile(spawntype, 0, 0, -45, CMF_AIMDIRECTION|CMF_BADPITCH, 0);
		A_SpawnProjectile(spawntype, 0, 0, 45, CMF_AIMDIRECTION|CMF_BADPITCH, 0);
		A_StartSound(AttackSound, CHAN_BODY);
    }
}

Extend Class Shin_GroundFire
{		
	override int DoSpecialDamage (Actor target, int damage, Name damagetype)
	{
		//Will only apply vertical thrust to those derivative of the playerpawn class.
		//Much better then having the thrust baked into the player class entity itself.
		if(target && PlayerPawn(Target) != null && Target.GetClassName() != "PlayerPawn"
				  && !target.bDONTTHRUST //No brainer.
				  && !target.bISMONSTER //Backup check just in case something slips past the inital playerpawn check.
				  && !target.bINVULNERABLE //Note: Will only apply with invulnerability power ups and not when using the god mode cheat.
				  //&& !target.bGODMODE
				  && !target.bNODAMAGE) //Another no brainer.
		  {	target.vel.z = 1.0 * 1500 / target.Mass; } //Apply the vertical thust.
		target.DamageMobj (null, target, damage, 'Fire'); //Do damage.
		return -1;
	}
}