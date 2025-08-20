
Class Shin_Infernoble : Shin_BaronOfHell
{
	Default
	{
		Health 1000;
		Radius 24;
		Height 64;
		Mass 1000;
		Speed 8;
		PainChance 50;
		Monster;
		+FLOORCLIP
		+BOSSDEATH
		+E1M8BOSS
		SeeSound "baron/sight";
		PainSound "baron/pain";
		DeathSound "baron/death";
		ActiveSound "baron/active";
		Obituary "$OB_BARON";
		HitObituary "$OB_BARONHIT";
		Tag "$FN_BARON";
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
	Raise:
		BOSS O 8;
		BOSS NMLKJI  8;
		Goto See;
	}
}