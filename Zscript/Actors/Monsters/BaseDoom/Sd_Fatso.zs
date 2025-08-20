
Class Shin_Mancubus : ShinDoom_Actor Replaces Fatso
{
	Default
	{
		Health 600;
		Radius 48;
		Height 64;
		Mass 1000;
		Speed 8;
		Gibhealth 40;
		Scale 1.1;
		PainChance 80;
		Monster;
		+FLOORCLIP
		+BOSSDEATH
		+MAP07BOSS1
		+NOINFIGHTSPECIES
		+DONTHARMSPECIES
		SeeSound "fatso/sight";
		PainSound "fatso/pain";
		DeathSound "fatso/death";
		ActiveSound "fatso/active";
		ShinDoom_Actor.FootstepSound "fatso/walk";
		Obituary "$OB_FATSO";
		Tag "$FN_MANCU";
	}

	States
	{
	Precache:
		FAT2 A 0;
		FATT A 0;
		Stop;
	Spawn:
		FATT AB 15 { A_Look(); A_RestoreSprite(); }
		Loop;
	See:
		"####" A 4 A_Footstep();
		"####" ABBCC 4 A_Chase;
		"####" D 4 A_Footstep();
		"####" DEEFF 4 A_Chase;
		Loop;
	Missile:
		"####" G 12 A_FatRaise();
		"####" A 0 Bright A_JumpIfCloser(260,"Missile.Flamethrower");
		"####" G 8 A_FaceTarget;
		"####" H 10 BRIGHT A_ManAttack1();
		"####" IG 5 A_FaceTarget;
		"####" H 10 BRIGHT A_ManAttack2();
		"####" IG 5 A_FaceTarget;
		"####" H 10 BRIGHT A_ManAttack3();
		"####" IG 5 A_FaceTarget;
		Goto See;
	Melee:
		"####" G 12 A_FatRaise();
		Goto Missile.Flamethrower;
	Missile.Flamethrower:
		"####" HHHHHHHHHHHHH 3 BRIGHT A_ManAttack4();
		"####" IG 5 A_FaceTarget;
		Goto See;
	Pain:
		"####" J 3;
		"####" J 3 A_Pain;
		Goto See;
	 Death:
		"####" K 6;
		"####" L 6 A_Scream;
		"####" M 6 A_NoBlocking;
		"####" NOPQRS 6;
		"####" T -1 A_BossDeath;
	    Stop;
	Death.Ice:
		"####" J 5 A_GenericFreezeDeath;
		TNT1 J 1 A_Freezedeathchunks;
		WAIT;
	XDeath:
		"####" A 0 A_Jumpif((BaseSprite == GetSpriteIndex('FAT2')), "Death");
		FATX A 5;
		FATX B 5 A_XScream;
		FATX C 5 A_NoBlocking();
		FATX DEF 5;
		FATX G -1 A_BossDeath;
		Stop;
	Crush:
		MANG A 0;
		MANG A 0 A_Startsound("Bloody/crush");
		MANG A -1;
		stop;
	Raise:
		"----" A 0 A_RestoreSprite();
		"####" R 5;
		"####" QPONMLK 5;
		Goto See;
	}
}

Class Shin_CorpulentShot : Fatshot
{
	Default
	{
		SeeSound "corpulent/shot";
		DeathSound "corpulent/shotX";
	}
}

Class Shin_FireTrail : ShinDoom_Actor
{
	Default
	{
		Radius 13.0;
		Height 8.0;
		Speed 25;
		//FastSpeed 20;
		DamageFunction 1;
		Mass 1000;
		Scale 1.0;
		Projectile;
		BounceType "Doom";
		+ZDOOMTRANS
		+Ripper
		+MTHRUSPECIES
		RenderStyle "Add";
		Seesound "vile/firecrkl";
		Alpha 1;
	}
	
	void A_Vilefirestart()
	{
		A_Fire();
		A_Startsound("vile/Firestart");
	}
	
	States
	{
	Spawn:
		FLAM A 0 BRIGHT { A_Vilefirestart(); A_FireCrackle(); }
		FLAM A 3 BRIGHT { A_Fire(); A_LowGravity(); }
		FLAM B 4 BRIGHT;
		FLAM C 2 BRIGHT;
		//FLAM B 1 BRIGHT;
		Stop;
		Stop;
	}
}

Class Shin_DeadMancubus : Shin_Mancubus
{
	Default { -COUNTKILL +NEVERRESPAWN }
	
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

Extend Class Shin_Mancubus
{	
	static const name FatsoSprite[] = 
    {
        'FATT',
        'FAT2'
    };
	
	static const Class<Actor> ManShot[] =
	{
		'FatShot',
		'Shin_CorpulentShot'
	};
	
	int s;
	
	override void PostBeginPlay()
	{
		string mapName = Level.MapName.MakeLower();
		super.PostBeginPlay();
		int i = 0; //The Regular Mancubus sprites are the default.
				
		if (wads.FindLump("D_FLEE") && wads.FindLump("dswlfhwl") != -1)
		{
			i = 1;
			//A_Log("Ancient Aliens Detected");
		}
		
		if ( mapName == "test" )
		{
			i = random(0,1); //Spawn with ethier appearence in the test map.
		}
		
		
		if ( i == 1 )
		{
			SeeSound = "corpulent/see";
			PainSound = "corpulent/pain";
			DeathSound = "corpulent/death";
			ActiveSound = "corpulent/active";
			SetTag("Corpulent");
		}
		

		BaseSprite = GetSpriteIndex(FatsoSprite[i]);	
		sprite = BaseSprite;
		
		Return;
	}
	
	Void A_FatRaise()
	{
		if (BaseSprite == GetSpriteIndex('FAT2'))
			A_BattleCry("corpulent/attack");
		else
			A_BattleCry("fatso/raiseguns");
	}
	
	void A_ManAttack1()
	{
		//ManShot = "FatShot";
		s = 0;
		if (BaseSprite == GetSpriteIndex('FAT2'))
			s = 1;
		
		A_FaceTarget();
		A_SpawnProjectile(ManShot[s],18,-34,20,CMF_BADPITCH);
		A_SpawnProjectile(ManShot[s],18,34,0,CMF_BADPITCH);
	}
	
	void A_ManAttack2()
	{
		s = 0;
		if (BaseSprite == GetSpriteIndex('FAT2'))
			s = 1;
		
		A_FaceTarget();
		A_SpawnProjectile(ManShot[s],18,-34,0,CMF_BADPITCH);
		A_SpawnProjectile(ManShot[s],18,34,-20,CMF_BADPITCH);
	}
	
	void A_ManAttack3()
	{
		s = 0;
		if (BaseSprite == GetSpriteIndex('FAT2'))
			s = 1;
		
		A_FaceTarget();
		A_SpawnProjectile(ManShot[s],18,-34,8,CMF_BADPITCH);
		A_SpawnProjectile(ManShot[s],18,34,-8,CMF_BADPITCH);
	}
	
	void A_ManAttack4()
	{
		A_FaceTarget();
		A_SpawnProjectile("Shin_FireTrail",18,-34,8,CMF_BADPITCH);
		A_SpawnProjectile("Shin_FireTrail",18,34,-8,CMF_BADPITCH);
	}
}