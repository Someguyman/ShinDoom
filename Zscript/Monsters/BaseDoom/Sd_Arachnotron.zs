//
class Shin_Arachnotron : ShinDoom_Actor Replaces Arachnotron
{
	Default
	{
		Health 500;
		Radius 50;
		Height 64;
		Mass 600;
		Speed 12;
		Gibhealth 40;
		Scale 1.1;
		PainChance 128;
		Monster;
		+FLOORCLIP
		+BOSSDEATH
		+MAP07BOSS2
		+NOINFIGHTSPECIES
		+DONTHARMSPECIES
		SeeSound "baby/sight";
		PainSound "baby/pain";
		DeathSound "baby/death";
		ActiveSound "baby/active";
		Obituary "$OB_BABY";
		Tag "$FN_ARACH";
	}
	
	States
	{
	Spawn:
		BSPI AB 10 A_Look;
		Loop;
	See:
		BSPI A 20;
		BSPI A 3 A_BabyMetal;
		BSPI ABB 3 A_Chase;
		BSPI C 3 A_Chase;
		BSPI C 3 A_Chase;
		BSPI D 3 A_BabyMetal;
		BSPI DEE 3 A_Chase;
		BSPI F 3 A_Chase;
		BSPI F 3 A_Chase;
		Goto see+1;
	Missile:
		BSPI A 0 BRIGHT A_jump(100, "Missile.Barrage");
		BSPI A 20 A_FaceTarget;
		BSPI G 4 BRIGHT A_BspiAttack;
		BSPI H 4 BRIGHT A_FaceTarget();
		BSPI H 1 BRIGHT A_SpidRefire;
		Goto Missile+2;
	Missile.Barrage:
		BSPI Q 10 A_FaceTarget;
	Barrage.Attack:
		BSPI G 2 BRIGHT A_BspiAttack;
		BSPI H 1 BRIGHT A_SpidRefire;
		BSPI G 2 BRIGHT A_BspiAttack;
		BSPI H 1 BRIGHT A_SpidRefire;
		BSPI G 2 BRIGHT A_BspiAttack;
		BSPI H 1 BRIGHT A_SpidRefire;
		BSPI G 2 BRIGHT A_BspiAttack;
		BSPI H 1 BRIGHT A_SpidRefire;
		BSPI G 2 BRIGHT  A_BspiAttack;
		BSPI H 1 BRIGHT A_SpidRefire;
		BSPI G 2 BRIGHT  A_BspiAttack;
		BSPI H 1 BRIGHT A_SpidRefire;
		BSPI G 2 BRIGHT  A_BspiAttack;
		BSPI Q 20 BRIGHT A_SpidRefire;
		BSPI Q 0 BRIGHT A_jump(20, "Barrage.Attack");
		Goto Missile+2;
	Pain:
		BSPI I 3;
		BSPI I 3 A_Pain;
		Goto See+1;
	Death.Ice:
		BSPI I 5 A_GenericFreezeDeath;
		TNT1 A 1 A_Freezedeathchunks;
		WAIT;
	Death:
		BSPI J 1;
		BSPI J 19 A_Scream;
		BSPI K 7 A_NoBlocking;
		BSPI LMNO 7;
		BSPI P -1 A_BossDeath;
		Stop;
	XDeath:
		BSPX A 1;
		BSPX A 5 A_XScream;
		BSPX B 5 A_NoBlocking;
		BSPX CDEF 5;
		BSPX G -1 A_BossDeath;
		Stop;
	 Raise:
		BSPI O 5;
		BSPI NMLKJ 5;
		Goto See+1;
	Crush:
		BSPI A 0;
		BSPI A 0 A_Startsound("Bloody/crush");
		BSPG A -1;
	}
}