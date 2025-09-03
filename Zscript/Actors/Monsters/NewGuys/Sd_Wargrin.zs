
Class Shin_Wargrin : ShinDoom_Actor
{
	Default
	{
		Health 250;
		Radius 20;
		Height 56;
		Speed 8;
		Gibhealth 40;
		PainChance 140;
		Mass 200;
		Monster;
		+FLOORCLIP
		SeeSound "Wargrin/Sight";
		PainSound "Wargrin/pain";
		DeathSound "Wargrin/death";
		ActiveSound "Wargrin/active";
		DropItem "ID24Fuel";
		Obituary "%o was squished by a wargrin.";
		Tag "Wargrin";
	}
	
	States
	{
	Spawn:
		WARG AB 10 A_Look;
		Loop;
	See:
		WARG AABBCCDD 2 A_Chase;
		Loop;
	Melee:
		WARG HI 8 A_FaceTarget;
		WARG J 8 A_CustomMeleeAttack(random(1, 10) * 4, "Imp/melee");
		Goto see;
	Missile:
		WARG E 18 A_BattleCry("Wargrin/active");
		WARG F 6 Bright A_FireVolley("Shin_WargrinFireball",0,0,18);
		WARG E 9 A_FaceTarget;
		WARG F 6 Bright A_FireVolley("Shin_WargrinFireball",4,30,18);
		WARG E 9 A_FaceTarget;
		WARG F 6 Bright A_FireVolley("Shin_WargrinFireball",0,0,18);
		WARG G 26 A_FaceTarget;
		Goto See;
	Pain:
		WARG K 4;
		WARG K 4 A_Pain;
		Goto See;
	Death:
		WARG L 8;
		WARG M 8 A_Scream;
		WARG N 6;
		WARG O 6 A_NoBlocking;
		WARG P -1;
		Stop;
	Death.Ice:
		WARG H 5 A_GenericFreezeDeath;
		TNT1 A 1 A_Freezedeathchunks;
		WAIT;
	XDeath:
		WARG Q 5;
		WARG R 5 A_XScream;
		WARG S 5;
		WARG T 5 A_NoBlocking;
		WARG UVW 5;
		WARG X -1;
		Stop;
	Raise:
		WARG ML 6;
		WARG KJI 8;
		Goto See;
	}
}

class Shin_WargrinFireball : Doomimpball
{
	Default
	{
		SPEED 12; 
		FastSpeed 20;
		//SeeSound "Superimp/attack";
	}
	
	States
	{
		Spawn:
			BRB2 AB 4 BRIGHT;
			Loop;
		Death:
			BRB2 CDEFGHI 3 Bright;
			Stop;
	}
}