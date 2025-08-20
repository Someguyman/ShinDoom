
Class Shin_Arachnotron : ShinDoom_Actor Replaces Arachnotron
{
	Default
	{
		Health 500;
		Radius 50;
		Height 64;
		Mass 600;
		Speed 12;
		Gibhealth 40;
		Scale 1.1;
		PainChance 128;
		Monster;
		+FLOORCLIP
		+BOSSDEATH
		+MAP07BOSS2
		+NOINFIGHTSPECIES
		+DONTHARMSPECIES
		SeeSound "baby/sight";
		PainSound "baby/pain";
		DeathSound "baby/death";
		ActiveSound "baby/active";
		ShinDoom_Actor.FootstepSound "Baby/step";
		Obituary "$OB_BABY";
		Tag "$FN_ARACH";
	}
	
	States
	{
	Precache:
		BSP2 A 0;
		BSPI A 0;
		Stop;
	Spawn:
		BSPI AB 10 { A_Look(); A_RestoreSprite(); }
		Loop;
	See:
		"####" A 20;
		"####" A 3 A_Footstep();
		"####" A 3 A_Chase;
		"####" B 3 A_BabyMetal();
		"####" BCC 3 A_Chase;
		"####" D 3 A_Footstep();
		"####" D 3 A_Chase;
		"####" E 3 A_BabyMetal();
		"####" EFF 3 A_Chase;
		Goto see+1;
	Missile:
		"####" A 0 BRIGHT A_jump(100, "Missile.Barrage");
		"####" A 20 A_FaceTarget;
		"####" G 4 BRIGHT A_ArachnidAttack();
		"####" H 4 BRIGHT A_FaceTarget();
		"####" H 1 BRIGHT A_SpidRefire;
		Goto Missile+2;
	Missile.Barrage:
		"####" Q 10 A_BspiFaceTarget();
	Barrage.Attack:
		"####" G 1 BRIGHT A_ArachnidAttack();
		"####" H 2 BRIGHT A_SpidRefire;
		"####" Q 20 A_BspiRefire();
		Goto Missile+2;	
	Pain:
		"####" I 3;
		"####" I 3 A_Pain;
		Goto See+1;
	Death.Ice:
		"####" I 5 A_GenericFreezeDeath;
		TNT1 A 1 A_Freezedeathchunks;
		WAIT;
	Death: //A_StartSound("misc/thud", 0);
		"####" J 1;
		"####" J 19 A_Scream;
		"####" K 7 A_NoBlocking;
		"####" LM 7;
		"####" N 7 A_StartSound("misc/HeavyThud", 0);
		"####" O 7;
		"####" P -1 A_BossDeath;
		Stop;
	XDeath:
		"####" A 0 A_Jumpif((BaseSprite == GetSpriteIndex('BSP2')), "Death");
		BSPX A 1;
		BSPX A 5 A_XScream;
		BSPX B 6 A_NoBlocking;
		BSPX CD 6;
		BSPX E 6 A_StartSound("caco/deathland", 0);
		BSPX F 6;
		BSPX G -1 A_BossDeath;
		Stop;
	 Raise:
		"----" A 0 A_RestoreSprite();
		"####" O 5;
		"####" NMLKJ 5;
		Goto See+1;
	Crush:
		BSPI A 0;
		BSPI A 0 A_Startsound("Bloody/crush");
		BSPG A -1;
	}
}

Class Shin_ArachnotronPlasma : ShinDoom_Actor Replaces ArachnotronPlasma
{
	Default
	{
		Radius 13;
		Height 8;
		Speed 25;
		Damage 5;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		SeeSound "baby/attack";
		DeathSound "baby/shotx";
	}
	States
	{
	Spawn:
		APLS AB 6 BRIGHT;
		Loop;
	Death:
		APBX ABCDE 4 BRIGHT;
		Stop;
	}
}

Class Shin_ArachknightPlasma : Shin_ArachnotronPlasma
{
	Default
	{
		SeeSound "Arachknight/Attack";
		//DeathSound "baby/shotx";
	}
	States
	{
	Spawn:
		ARAX AB 3 BRIGHT;
		Loop;
	Death:
		ARAX CDEFGHI 3 BRIGHT;
		Stop;
	}
}

Class Shin_DeadArachnotron : Shin_Arachnotron
{
	Default { -COUNTKILL +NEVERRESPAWN }
	States
	{
		Spawn:
			BSPI P 0;
			BSPI P 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			BSPI P 0 A_NoBlocking;
			BSPI P -1;
			Stop;
	}
}

Extend Class Shin_Arachnotron
{		
	int userReactionTime;
	
	static const name ArachnoSprite[] = 
    {
        'BSPI',
        'BSP2'
    };
	
	override void PostBeginPlay()
	{
		string mapName = Level.MapName.MakeLower();
		super.PostBeginPlay();
		int i = 0; //The Regular Hell Knight sprites are the default.

		if (wads.FindLump("D_FLEE") && wads.FindLump("dswlfhwl") != -1)
		{
			i = 1;
			//A_Log("Ancient Aliens Detected");
		}
		
		if ( mapName == "test" )
		{
			i = random(0,1); //Spawn with ethier appearence in the test map.
		}
		
		
		if ( i == 1 ) //If we are using the Doom 1 sprites, then change the sounds to the Doom 1 versions as well.
		{
			SeeSound = "Arachknight/Sight";
			ActiveSound = "Arachknight/Active";
			PainSound = "Arachknight/Pain";
			DeathSound = "Arachknight/Death";
			SetTag("Arachknight");
		}
		

		BaseSprite = GetSpriteIndex(ArachnoSprite[i]);	
		sprite = BaseSprite;
		
		Return;
	}
	
	Void A_BabyMetal()
	{
		if (BaseSprite == GetSpriteIndex('BSP2'))
			A_StartSound("Arachknight/walk", CHAN_AUTO, CHANF_DEFAULT, 1, ATTN_IDLE);
		else
			A_StartSound("baby/walk", CHAN_BODY, CHANF_DEFAULT, 1, ATTN_IDLE);
			
		A_Chase();
	}
			
	Void A_ArachnidAttack()
	{
		A_FaceTarget();
		if (BaseSprite == GetSpriteIndex('BSP2'))
			A_SpawnProjectile("Shin_ArachknightPlasma",19,0,0,CMF_BADPITCH);
		else
			A_SpawnProjectile("ArachnotronPlasma",19,4,0,CMF_BADPITCH);
	}
	
	void A_BspiFaceTarget()
	{
        A_FaceTarget();
		userReactionTime = 7;
	}
	
	Void A_BspiRefire()
	{
		if (userReactionTime > 0) SetStateLabel("Barrage.Attack");
        userReactionTime--;
	}
}