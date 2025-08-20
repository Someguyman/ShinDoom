
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
		SARG I 8;
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
		SARG M 5;
		SARG LKJI 5;
		Goto See;
	XDeath:
		SRGX A 4;
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

Class Shin_DeadPinky : Shin_Pinky Replaces DeadDemon
{
	Default { +NEVERRESPAWN -COUNTKILL }
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
			TNT1 A 0 A_Jump(50, "Gibbed");
			Goto Super::DeathStop+2;
		Gibbed:
			Goto Super::XDeath+9;
	}
}

Class Shin_Spectre : Shin_Pinky Replaces Spectre
{	
	Default
	{
		+SHADOW
		RenderStyle "OptFuzzy";
		Alpha 0.25;
		Translation "SpectrePal1";
		SeeSound "spectre/sight";
		AttackSound "spectre/melee";
		PainSound "spectre/pain";
		DeathSound "spectre/death";
		ActiveSound "spectre/active";
		Obituary "$OB_SPECTREHIT";
		Tag "$FN_SPECTRE";
	}
}

Class Shin_DeadSpectre : Shin_Spectre
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
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
			TNT1 A 0 A_Jump(50, "Gibbed");
			Goto Super::DeathStop+2;
		Gibbed:
			Goto Super::XDeath+9;
	}
}