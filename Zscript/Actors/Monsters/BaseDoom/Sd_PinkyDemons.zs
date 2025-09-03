
Class Shin_Pinky : ShinDoom_Actor Replaces Demon
{
	Default
	{
		Health 150;
		PainChance 180;
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
		SARG AB 10 A_Look;
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
		SARG I 1;
		SARG I 7 A_SpectreAppear();
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
		SARG M 1;
		SARG M 4 A_SpectreDisappear();
		SARG LKJI 5;
		Goto See;
	XDeath:
		SRGX A 1;
		SRGX A 3 A_SpectreAppear();
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
		//Alpha 0.25;
		Translation "SpectrePal1";
		SeeSound "spectre/sight";
		AttackSound "spectre/melee";
		PainSound "spectre/pain";
		DeathSound "spectre/death";
		//DeathSound "";
		ActiveSound "spectre/active";
		Obituary "$OB_SPECTREHIT";
		Tag "$FN_SPECTRE";
	}
	States
	{
	Spawn:
		SAR2 AB 10 A_Look;
		Loop;
	See:
		SAR2 AABBCCDD 2 fast A_Chase;
		Loop;
	Melee:
		SAR2 EF 8 Fast A_FaceTarget;
		SAR2 G 8 Fast A_SargAttack;
		Goto See;
	Pain:
		SAR2 H 2 Fast;
		SAR2 H 2 Fast A_Pain;
		Goto See;
	Death.Ice:
		SAR2 H 5 A_GenericFreezeDeath;
		TNT1 A 1 A_Freezedeathchunks;
		WAIT;
	Death:
		SAR2 I 1;
		SAR2 I 7 A_SpectreAppear();
		SAR2 J 8 A_Scream;
		SAR2 K 4;
		SAR2 L 3 A_NoBlocking;
	DeathLoop:
		SAR2 L 1 A_CheckFloor("DeathStop");
		Loop;
	DeathStop:
		SAR2 M 0 A_StartSound("misc/thud", 0);
		SAR2 M 4;
		SAR2 N -1;
		Stop;
	Raise:
		SAR2 M 1;
		SAR2 M 4 A_SpectreDisappear();
		SAR2 LKJI 5;
		Goto See;
	XDeath:
		SR2X A 1;
		SR2X A 3 A_SpectreAppear();
		SR2X B 4 A_XScream;
		SR2X C 4 A_NoBlocking();
		SR2X DEFGHI 4;
		SR2X J -1;
		Stop;
	Crush:
		POL5 A 0;
		POL5 A 0 A_Startsound("Bloody/crush");
		POL5 A -1;
		stop;
	}
}