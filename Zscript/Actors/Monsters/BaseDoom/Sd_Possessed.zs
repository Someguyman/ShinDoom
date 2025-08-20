
Class Shin_ZombieMan : ShinDoom_Actor Replaces ZombieMan
{
	Default
	{
		Health 20;
		Radius 20;
		Height 56;
		Speed 8;
		PainChance 200;
		Monster;
		+FLOORCLIP
		SeeSound "grunt/sight";
		AttackSound "grunt/attack";
		PainSound "grunt/pain";
		DeathSound "grunt/death";
		ActiveSound "grunt/active";
		Obituary "$OB_ZOMBIE";
		Tag "$FN_ZOMBIE";
		DropItem "Shin_Pistol";
	}
	States
	{
	Spawn:
		POSS AB 10 A_Look;
		Loop;
	See:
		POSS AABBCCDD 4 A_Chase;
		Loop;
	Missile:
		POSS E 10 A_FaceTarget;
		POSS F 4 Bright A_PosAttack;
		POSS E 12;
		Goto See;
	Pain:
		POSS G 3;
		POSS G 3 A_Pain;
		Goto See;
	Death:
		POSS H 5;
		POSS I 5 A_Scream;
		POSS J 5 A_NoBlocking;
		POSS K 5;
		POSS L -1;
		Stop;
	XDeath:
		POSS M 5;
		POSS N 5 A_XScream;
		POSS O 5 A_NoBlocking;
		POSS PQRST 5;
		POSS U -1;
		Stop;
	Raise:
		POSS K 5;
		POSS JIH 5;
		Goto See;
	}
}

Class Shin_Deadzombieman : Shin_ZombieMan Replaces DeadZombieMan
{
	Default
	{
		+NEVERRESPAWN
		-COUNTKILL
		DropItem "None";
	}
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
			Goto Super::Death+4;
	}
}

Class Shin_ShotgunGuy : ShinDoom_Actor Replaces ShotgunGuy
{
	Default
	{
		Health 30;
		Radius 20;
		Height 56;
		Mass 100;
		Speed 8;
		PainChance 170;
		Monster;
		+FLOORCLIP
		SeeSound "shotguy/sight";
		AttackSound "shotguy/attack";
		PainSound "shotguy/pain";
		DeathSound "shotguy/death";
		ActiveSound "shotguy/active";
		Obituary "$OB_SHOTGUY";
		Tag "$FN_SHOTGUN";
		DropItem "Shin_Shotgun";
	}
	States
	{
	Spawn:
		SPOS AB 10 A_Look;
		Loop;
	See:
		SPOS AABBCCDD 3 A_Chase;
		Loop;
	Missile:
		SPOS E 10 A_FaceTarget;
		SPOS F 4 BRIGHT A_SposAttackUseAtkSound;
		SPOS E 16;
		Goto See;
	Pain:
		SPOS G 3;
		SPOS G 3 A_Pain;
		Goto See;
	Death:
		SPOS H 5;
		SPOS I 5 A_Scream;
		SPOS J 5 A_NoBlocking;
		SPOS K 5;
		SPOS L -1;
		Stop;
	XDeath:
		SPOS M 5;
		SPOS N 5 A_XScream;
		SPOS O 5 A_NoBlocking;
		SPOS PQRST 5;
		SPOS U -1;
		Stop;
	Raise:
		SPOS L 5;
		SPOS KJIH 5;
		Goto See;
	}
}

Class Shin_DeadShotgunner : Shin_ShotgunGuy Replaces DeadShotgunGuy
{
	Default
	{
		+NEVERRESPAWN
		-COUNTKILL
		DropItem "None";
	}
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
			Goto Super::Death+4;
	}
}

Class Shin_ChaingunGuy : ShinDoom_Actor Replaces ChaingunGuy
{
	Default
	{
		Health 70;
		Radius 20;
		Height 56;
		Mass 100;
		Speed 8;
		PainChance 170;
		Monster;
		+FLOORCLIP
		SeeSound "chainguy/sight";
		PainSound "chainguy/pain";
		DeathSound "chainguy/death";
		ActiveSound "chainguy/active";
		AttackSound "chainguy/attack";
		Obituary "$OB_CHAINGUY";
		Tag "$FN_HEAVY";
		Dropitem "Shin_Chaingun";
		Dropitem "Shin_LightAmmo";
		Dropitem "Shin_LightAmmo";
	}
	
	static const name ChaingunnerSprite[] = 
    {
        'CPOS',
        'CPS2'
    };
	
	override void PostBeginPlay()
	{
		string mapName = Level.MapName.MakeLower();
		super.PostBeginPlay();
		int i = 0;
		
		if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
		{
			i = 1;
		}
		
		if ( mapName == "test" )
		{
			i = random(0,1);
		}
		
		BaseSprite = GetSpriteIndex(ChaingunnerSprite[i]);
		
		sprite = BaseSprite;
		
		Return;
	}
	
	States
	{
	Precache:
		CPS2 A 0;
		CPOS A 0;
		Stop;
		
	Spawn:
		CPOS AB 10 { A_Look(); A_RestoreSprite(); }
		Loop;
	See:
		"####" AABBCCDD 3 A_Chase;
		Loop;
	Missile:
		CPOS H 0 A_Jumpif((BaseSprite == GetSpriteIndex('CPS2')), "Missile.D1");
		CPOS V 11 A_FaceTarget;
		Goto Attack;
	Missile.D1:
		CPS2 Z 11 A_FaceTarget;
		Goto Attack;
	Attack:
		"####" F 2 BRIGHT A_CPosAttack;
		"####" E 2 BRIGHT A_FaceTarget;
		"####" F 1 A_CPosRefire;
		Goto Attack;
	Pain:
		"####" G 3;
		"####" G 3 A_Pain;
		Goto See;
	Death:
		CPOS H 0 A_Jumpif((BaseSprite == GetSpriteIndex('CPS2')), "Death.D1");
		CPOS H 5;
		CPOS I 5 A_Scream;
		CPOS J 5 A_NoBlocking;
		CPOS KLM 5;
		CPOS N -1;
		Stop;
	Death.D1:
		CPS2 H 5;
		CPS2 I 5 A_Scream();
		CPS2 J 5 A_NoBlocking;
		CPS2 KLMNO 5;
		CPS2 P -1;
		Stop;
	XDeath:
		CPOS H 0 A_Jumpif((BaseSprite == GetSpriteIndex('CPS2')), "XDeath.D1");
		CPOS O 5;
		CPOS P 5 A_XScream;
		CPOS Q 5 A_NoBlocking;
		CPOS RST 5;
		CPOS U -1;
		Stop;
	XDeath.D1:
		CPS2 Q 5 ;
		CPS2 R 5 A_XScream();
		CPS2 S 5A_NoBlocking;
		CPS2 TUVWX 5;
		CPS2 Y -1;
		Stop;
	Raise:
		"----" A 0 A_RestoreSprite();
		"####" N 5;
		"####" MLKJIH 5;
		Goto See;
	}
}

Class Shin_DeadChaingunguy : Shin_Chaingunguy
{
	Default
	{
		-COUNTKILL
		+NEVERRESPAWN
		DropItem "None";
	}
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
			TNT1 A 0 A_Jumpif((BaseSprite == GetSpriteIndex('CPS2')), "D1.Corpse");
			Goto Super::Death+7;
		D1.Corpse:
			Goto Super::Death.D1+8;
	}
}