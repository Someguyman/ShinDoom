//
Class Shin_BaronOfHell : ShinDoom_Actor Replaces Baronofhell
{
	Default
	{
		Health 1200;
		Radius 24;
		Height 64;
		Mass 1000;
		Speed 8;
		PainChance 50;
		Gibhealth 40;
		Monster;
		+FLOORCLIP
		+BOSSDEATH
		+E1M8BOSS
		MissileChanceMult 0.5;
		SeeSound "baron/sight";
		PainSound "baron/pain";
		DeathSound "baron/death";
		ActiveSound "baron/active";
		Obituary "$OB_BARON";
		HitObituary "$OB_BARONHIT";
		Tag "$FN_BARON";
		BloodColor "30 67 23";
		+NOINFIGHTSPECIES
		Scale 1.3;
		+NOFEAR
	}
	States
	{
	Spawn:
		BOSS AB 10 A_Look ;
		Loop;
	See:
		BOSS AABBCCDD 3 A_Chase;
		Loop;
	Melee:
	Missile:
		BOSS EF 8 A_FaceTarget;
		BOSS G 8 A_BruisAttack;
		Goto See;
	Pain:
		BOSS H  2;
		BOSS H  2 A_Pain;
		Goto See;
	Death:
		BOSS I  8;
		BOSS J  8 A_Scream;
		BOSS K  8;
		BOSS L  8 A_NoBlocking;
		BOSS MN 8;
		BOSS O -1 A_BossDeath;
		Stop;
	XDeath:
		BOSX A 5;
		BOSX B 5 A_XScream;
		BOSX C 5;
		BOSX D 5 A_NoBlocking();
		BOSX EFGH 5;
		BOSX I -1 A_BossDeath;
		Stop;
	Raise:
		BOSS M 8;
		BOSS LKJI  8;
		Goto See;
	}
}