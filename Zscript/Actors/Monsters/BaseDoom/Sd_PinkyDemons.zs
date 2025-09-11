
Class Shin_Pinky : ShinDoom_Actor Replaces Demon
{
	Default
	{
		Health 150;
		PainChance 180;
		PainChance "Cutting", 255;
		Speed 12;
		Radius 30;
		Height 56;
		Mass 400;
		Monster;
		Scale 1.1;
		Gibhealth 20;
		+FLOORCLIP
		SeeSound "demon/sight";
		AttackSound "demon/melee";
		PainSound "demon/pain";
		DeathSound "demon/death";
		ActiveSound "demon/active";
		Obituary "$OB_DEMONHIT";
		Tag "$FN_DEMON";
	}
	
	States
	{
	Spawn:
		SARG AB 10 { A_Look(); A_RestoreSprite(); }
		Loop;
	See:
		SARG AABBCCDD 2 fast A_Chase;
		Loop;
	Melee:
		SARG EF 8 Fast A_FaceTarget;
		SARG G 8 Fast A_SargAttack;
		Goto See;
	Pain:
		SARG H 2 Fast;
		SARG H 2 Fast A_Pain;
		Goto See;
	Death.Ice:
		SARG H 5 A_GenericFreezeDeath;
		TNT1 A 1 A_Freezedeathchunks;
		WAIT;
	Death:
		SARG I 1 A_RestoreSprite();
		SARG I 7;
		SARG J 8 A_Scream;
		SARG K 4;
		SARG L 3 A_NoBlocking;
	DeathLoop:
		SARG L 1 A_CheckFloor("DeathStop");
		Loop;
	DeathStop:
		SARG M 0 A_StartSound("misc/thud", 0);
		SARG M 4;
		SARG N -1;
		Stop;
	Raise:
		"----" A 0 { A_RestoreSprite(); }
		SARG M 1;
		SARG M 4 A_SpectreDisappear();
		SARG LKJI 5;
		Goto See;
	XDeath:
		SRGX A 1;
		SRGX A 3;
		SRGX B 4 A_XScream;
		SRGX C 4 A_NoBlocking();
		SRGX DEFGHI 4;
		SRGX J -1;
		Stop;
	Crush:
		POL5 A 0;
		POL5 A 0 A_Startsound("Bloody/crush");
		POL5 A -1;
		stop;
	}
}

Class Shin_Spectre : Shin_Pinky Replaces Spectre
{	
	Default
	{
		+SHADOW
		RenderStyle "OptFuzzy";
		SeeSound "spectre/sight";
		AttackSound "spectre/melee";
		PainSound "spectre/pain";
		DeathSound "spectre/death";
		ActiveSound "spectre/active";
		Obituary "$OB_SPECTREHIT";
		Tag "$FN_SPECTRE";
	}
	States
	{
	XDeath:
		SR2X A 1;
		SR2X A 3;
		SR2X B 4 A_XScream;
		SR2X C 4 A_NoBlocking();
		SR2X DEFGHI 4;
		SR2X J -1;
		Stop;
	}
}

Extend Class Shin_Pinky
{
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		

		BaseSprite = GetSpriteIndex("SARG");	
		sprite = BaseSprite;
		Return;
	}
}

Extend Class Shin_Spectre
{
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		

		BaseSprite = GetSpriteIndex("SAR2");	
		sprite = BaseSprite;
		Return;
	}
}