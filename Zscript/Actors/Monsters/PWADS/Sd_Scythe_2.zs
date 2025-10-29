
Class Shin_EvilMarine : Shin_Shocktrooper
{
	Default
	{
		Health 250;
		Speed 16;
		Translation "EvilMarine";
		Tag "Evil Marine";
	}
	States
	{
		see:
			PPOS AABBCCDD 1 A_Chase;
			loop;
		missile:
			PPOS E 2 A_Facetarget();
			PPOS F 1 bright A_STrooperBlast("ArachnotronPlasma");
			PPOS E 2;
			PPOS F 1 bright A_STrooperBlast("ArachnotronPlasma");
			PPOS E 2;
			PPOS F 1 bright A_STrooperBlast("ArachnotronPlasma");
			PPOS E 2;
			goto see;
		Pain:
			PPOS G 3;
			PPOS G 3 A_Pain;
			goto see;
	}
}

Class Shin_Afrit : Shin_BaronOfHell
{
	Default
	{
		Health 2500;
		Speed 9;
		PainChance 30;
		Mass 500;
		Scale 1.3;
		RenderStyle "Translucent";
		Alpha 0.8;
		+NoGravity
		+DONTGIB
		+NOICEDEATH
		+DONTFALL
		+Float
		+FLOATBOB
		FloatBobStrength 0.5;
		Tag "Afrit";
		+ShinDoom_Actor.STAYDEAD
		BloodColor "Red";
	}
	States
	{
	Spawn:
		BFRT ABCD 6 Bright A_Look();
		Loop;
	See:
		BFRT AABBCCDD 2 Bright A_Chase();
		Loop;
	Melee:
		Stop;
	Missile:
		BFRT EF 6 Bright A_FaceTarget();
		BFRT G 1 Bright A_fatattack1("Shin_Afrit_Ball");
		BFRT G 1 Bright A_fatattack2("Shin_Afrit_Ball");
		BFRT G 1 Bright A_fatattack3("Shin_Afrit_Ball");
		BFRT G 1 Bright A_FaceTarget();
		BFRT G 1 Bright A_SkelMissile;
		BFRT G 1 Bright A_SkelMissile;
		BFRT G 8 Bright A_SkelMissile;
		Goto See;
	Pain:
		BFRT H 4 Bright;
		BFRT H 4 Bright A_Pain();
		Goto See;
	XDeath:
	Death:
		TNT1 A 0 A_Stopsound(CHAN_AUTO);
		TNT1 A 0 A_NoGravity();
		BFRT I 1 Bright;
		BFRT I 5 Bright A_Scream();
		BFRT J 5 Bright;
		BFRT KLMNOPQR 4 Bright;
		Stop;
	Raise:
		Stop;
	}
}

Class Shin_Afrit_Ball : Shin_FatShot
{
	Default
	{
		SeeSound "baron/attack";
		DeathSound "baron/shotx";
	}
}	

Extend Class Shin_EvilMarine
{
	override void PostBeginPlay()
	{
		string mapName = Level.MapName.MakeLower();
		super.PostBeginPlay();
		
		if (wads.FindLump("SC2MTL") && wads.FindLump("PRODIGY") != -1)
		{
			If (mapName == "map16")
				SetTag("Mr. X");
		}
	}
}

Extend Class Shin_Afrit
{
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		BaseSprite = GetSpriteIndex("BFRT");	
		sprite = BaseSprite;
	}
}