
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
		BloodColor "red";
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
	Spawn:
		BOS2 AB 10 { A_Look(); A_RestoreSprite(); }
		Loop;
	See:
		"####" A 3 A_Footstep();
		"####" ABB 3 A_Chase;
		"####" C 3 A_Footstep();
		"####" CDD 3 A_Chase;
		Loop;
	Melee:
		Goto Missile+1;
	Missile:
		"####" A 0 A_JUMP(70, "Missile.Triple");
		"####" EF 8 A_FaceTarget;
		"####" G 8 A_HKnightAttack();
		Goto See;
	Missile.RightHand:
		"####" PQ 8 A_FaceTarget;
		"####" R 8 A_HKnightAttack();
		Goto See;
	Missile.Triple:
		"####" ST 8 A_FaceTarget;
		"####" U 8 A_FireVolley("Shin_KnightBall");
		Goto See;
	Pain:
		"####" H  2;
		"####" H  2 A_Pain;
		Goto See;
	Death:
		"####" I  8;
		"####" J  8 A_Scream;
		"####" K  8;
		"####" L  8 A_NoBlocking;
		"####" MN 8;
		"####" O -1 A_BossDeath;
		Stop;
	XDeath:
		"####" A 0 A_Jumpif((BaseSprite == GetSpriteIndex('ZBS2')), "XDeath.D1");
		BS2X A 5;
		BS2X B 5 A_XScream;
		BS2X C 5;
		BS2X D 5 A_NoBlocking;
		BS2X EFGH 5;
		BS2X I -1; //A_BossDeath;
		Stop;
	XDeath.D1:
		ZBX2 A 5;
		ZBX2 B 5 A_XScream;
		ZBX2 C 5;
		ZBX2 D 5 A_NoBlocking;
		ZBX2 EFGH 5;
		ZBX2 I -1; //A_BossDeath;
		Stop;
	Raise:
		"----" A 0 A_RestoreSprite();
		"####" M 8;
		"####" LKJI  8;
		Goto See;
	}
}

Class Shin_KnightBall : BaronBall
{
	Default
	{
		Seesound "knight/attack";
		Deathsound "knight/shotx";
	}
	States
	{
		Spawn:
			KNBL AB 4 BRIGHT;
			Loop;
		Death:
			KNBL CDE 6 BRIGHT;
			Stop;
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
		
		if ( mapName == "test" )
		{
			i = random(0,1); //Spawn with ethier appearence in the test map.
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
		A_FaceTarget();
		A_CustomComboAttack("Shin_KnightBall", 32, 10 * random(1, 8), "knight/melee");
	}
}