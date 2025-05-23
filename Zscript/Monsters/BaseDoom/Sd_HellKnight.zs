
class Shin_HellKnight : Shin_BaronOfHell Replaces Hellknight
{
	Default
	{
		Health 500;
		SeeSound "knight/sight";
		ActiveSound "knight/active";
		PainSound "knight/pain";
		DeathSound "knight/death";
		HitObituary "$OB_KNIGHTHIT";
		Obituary "$OB_KNIGHT";
		BloodColor "red";
		Tag "$FN_HELL";
		MissileChanceMult 1.0;
		Scale 1.1;
	}
	
	action void A_RestoreSprite()
	{
		invoker.sprite = invoker.BaseSpriteHK;
	}
	
	SpriteID BaseSpriteHK;
	
	override void PostBeginPlay()
	{
		string mapName = Level.MapName.MakeLower();
		super.PostBeginPlay();
		
		if ( mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m" )
		{
			BaseSpriteHK = GetSpriteIndex('ZBS2');
			SeeSound = "KnightD1/Sight";
			DeathSound = "KnightD1/Death";
		}
		else
		{
			BaseSpriteHK = GetSpriteIndex('BOS2');
		}
		
		sprite = BaseSpriteHK;
		
		Return;
	}
	
	States
	{
	Precache:
		ZBS2 A 0;
		BOS2 A 0;
		Stop;		
	Spawn:
		BOS2 A 0 A_RestoreSprite();
		"####" AB 10 A_Look;
		Loop;
	See:
		"####" AABBCCDD 3 A_Chase;
		Loop;
	Melee:
	Missile:
		"####" A 0 A_JUMP(70, "Missile.Triple");
		"####" EF 8 A_FaceTarget;
		"####" G 8 A_HKnightAttack();
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
		TNT1 A 0 A_Jumpif((BaseSpriteHK == GetSpriteIndex('ZBS2')), "XDeath.D1");
		BS2X A 5;
		BS2X B 5 A_XScream;
		BS2X C 5;
		BS2X D 5 A_NoBlocking;
		BS2X EFGH 5;
		BS2X I -1 A_BossDeath;
		Stop;
	XDeath.D1:
		ZB2X A 5;
		ZB2X B 5 A_XScream;
		ZB2X C 5;
		ZB2X D 5 A_NoBlocking;
		ZB2X EFGH 5;
		ZB2X I -1 A_BossDeath;
		Stop;
	Raise:
		"----" A 0 A_RestoreSprite();
		"####" M 8;
		"####" LKJI  8;
		Goto See;
	}
}

class Shin_KnightBall : BaronBall
{
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