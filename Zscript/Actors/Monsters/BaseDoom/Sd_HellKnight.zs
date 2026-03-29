
Class Shin_HellKnight : Shin_BaronOfHell Replaces Hellknight
{
	Default
	{
		Health 500;
		Species "HellKnoble";
		SeeSound "knight/sight";
		ActiveSound "knight/active";
		PainSound "knight/pain";
		DeathSound "knight/death";
		HitObituary "$OB_KNIGHTHIT";
		Obituary "$OB_KNIGHT";
		-BOSSDEATH
		-E1M8BOSS
		ShinDoom_Actor.FootstepSound "Knight/walk";
		//BloodColor "red";
		Tag "$FN_HELL";
		MissileChanceMult 1.0;
		Scale 1.1;
	}
	
	States
	{
	Precache:
		ZBS2 A 0;
		BOS2 A 0;
		Stop;
	Melee:
		Goto Missile+1;
	Missile:
		"####" A 0 A_JUMPIF(MissileCount == 0, "Missile.SuperAtk");
		"####" A 0 A_JUMPIF(MissileCount == 1, "Missile.RightHand");
		"####" EF 8 A_FaceTarget;
		"####" G 8 A_HKnightAttack();
		Goto See;
	Missile.RightHand:
		"####" PQ 8 A_FaceTarget;
		"####" R 8 A_HKnightAttack();
		Goto See;
	Missile.SuperAtk:
		"####" ST 8 A_FaceTarget;
		"####" U 8 A_HKnightAttack2();
		Goto See;
	XDeath:
		"####" A 0 A_Jumpif((BaseSprite == GetSpriteIndex('ZBS2')), "XDeath.D1");
		BS2X A 5;
		BS2X B 5 A_XScream;
		BS2X C 5;
		BS2X D 5 A_NoBlocking;
		BS2X EFGH 5;
		BS2X I -1 A_ShinBossDeath();
		Stop;
	XDeath.D1:
		ZBX2 A 5;
		ZBX2 B 5 A_XScream;
		ZBX2 C 5;
		ZBX2 D 5 A_NoBlocking;
		ZBX2 EFGH 5;
		ZBX2 I -1 A_ShinBossDeath();
		Stop;
	XRaise:
		"####" A 0 A_Jumpif((BaseSprite == GetSpriteIndex('ZBS2')), "XRaise.D1");
		BS2X H 5;
		BS2X GFEDCBA 5;
		"####" A 0 A_RestoreSprite();
		Goto See;
	XRaise.D1:
		ZBX2 H 5;
		ZBX2 GFEDCBA 5;
		"####" A 0 A_RestoreSprite();
		Goto See;
	}
}

Class Shin_KnightBall : Shin_BaronBall
{
	Default
	{
		Seesound "knight/attack";
		Deathsound "knight/shotx";
	}
}

extend Class Shin_Hellknight
{	
	static const name HellKnightSprite[] = 
    {
        'BOS2',
        'ZBS2'
    };
	
	override void PostBeginPlay()
	{
		string mapName = Level.MapName.MakeLower();
		super.PostBeginPlay();
		int i = 0; //The Regular Hell Knight sprites are the default.
		
		if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
		{
			i = 1; //Switch the sprite to the Doom 1 version.
		}
		
		if (wads.FindLump("KDISCR01") != -1)
		{
			i = 1;
		}
		
		if (mapName == "test")
		{
			i = random(0,1);
		}
		
		if ( i == 1 ) //If we are using the Doom 1 sprites, then change the sounds to the Doom 1 versions as well.
		{
			SeeSound = "KnightD1/Sight";
			DeathSound = "KnightD1/Death";
		}

		BaseSprite = GetSpriteIndex(HellKnightSprite[i]);	
		sprite = BaseSprite;
		
		Return;
	}
	
	void A_HKnightAttack()
	{
		MissileCount -= 1;
		A_FaceTarget();
		A_CustomComboAttack("Shin_KnightBall", 32, 10 * random(1, 8), "knight/melee");
	}
	
	Void A_HKnightAttack2()
	{
		MissileCount = InitialCount;
		A_FireVolley("Shin_KnightBall");
	}
}