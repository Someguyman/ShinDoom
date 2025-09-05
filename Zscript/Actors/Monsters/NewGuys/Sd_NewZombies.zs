
Class Shin_MachinegunGuy : ShinDoom_Actor
{
	Default
	{
		Health 50;
		Radius 20;
		Height 56;
		Speed 8;
		PainChance 170;
		Monster;
		+FLOORCLIP
		Seesound "machinegunguy/sight";
		ActiveSound "machinegunguy/active";
		PainSound "machinegunguy/pain";
		DeathSound "machinegunguy/death";
		Obituary "$OB_BURST";
		Tag "$FN_BURST";
		Dropitem "Shin_CombatRifle";
		//DropItem "Shin_HeavyAmmo", 62;
		DropItem "Shin_LightAmmo", 63;
	}
	
	States
	{
	Spawn:
		XPOS AB 10 A_Look;
		Loop;
	See:
		XPOS AABBCCDD 3 A_Chase;
		Loop;
	Missile:
		XPOS E 20 A_FaceTarget;
		XPOS F 4 BRIGHT { A_GunnerAttack(); A_BattleCry("machinegunguy/attack"); }
		XPOS E 6 A_FaceTarget;
		XPOS F 4 BRIGHT A_GunnerAttack();
		XPOS E 1 A_CPosRefire;
		Goto Missile+1;
	Pain:
		XPOS G 3;
		XPOS G 3 A_Pain;
		Goto See;
	Death:
		XPOS H 5;
		XPOS I 5 A_Scream;
		XPOS J 5 A_NoBlocking;
		XPOS K 5;
		XPOS L -1;
		Stop;
	XDeath:
		XPOS M 5;
		XPOS N 5 A_XScream;
		XPOS O 5 A_NoBlocking;
		XPOS PQRST 5;
		XPOS U -1;
		Stop;
	Raise:
		XPOS K 5;
		XPOS JIH 5;
		Goto See;
	}
}

class Shin_MechaZombie : ShinDoom_Actor
{
	Default
	{
		Health 120;
		Radius 20;
		Height 56;
		Speed 8;
		scale 1.1;
		PainChance 200;
		Monster;
		+FLOORCLIP
		Gibhealth 20;
		SeeSound "MechaZombie/Sight";
		PainSound "MechaZombie/Pain";
		DeathSound "MechaZombie/Death";
		ActiveSound "MechaZombie/Active";
		Obituary "$OB_CYBERZ";
		Tag "$FN_CYBERZ";
	}
	States
	{
	Spawn:
		POSM A 10 A_Look;
		Loop;
	See:
		POSM BBCCDDEE 3 A_Chase;
		Loop;
	Missile:
		POSM AF 6 A_FaceTarget;
		POSM G 4 A_BspiAttack();
		POSM F 4 A_FaceTarget;
		POSM G 4 A_BspiAttack();
		POSM F 4 A_FaceTarget;
		POSM G 4 A_BspiAttack();
		POSM F 4 A_FaceTarget;
		POSM G 4 A_BspiAttack();
		POSM F 10 A_FaceTarget;
		Goto See;
	Pain:
		POSM H 3;
		POSM H 3 A_Pain;
		Goto See;
	Death:
		POSM I 8;
		POSM J 8 A_Scream;
		POSM K 8 A_NoBlocking;
		POSM L 8;
		POSM M -1;
		Stop;
	XDeath:
		POSM N 5;
		POSM O 5 A_XScream;
		POSM P 5 A_NoBlocking;
		POSM QRSTU 5;
		POSM V -1;
		Stop;
	Raise:
		POSM L 5;
		POSM KJI 5;
		Goto See;
	}
}

Class Shin_SMGDude : ShinDoom_Actor
{
	Default
	{
		Health 50;
		Radius 20;
		Height 56;
		Speed 8;
		PainChance 170;
		Monster;
		+FLOORCLIP
		SeeSound "SMGDude/sight";
		AttackSound "SMGDude/attack";
		PainSound "SMGDude/pain";
		DeathSound "SMGDude/death";
		ActiveSound "SMGDude/active";
		Obituary "$OB_BURST";
		Tag "$FN_BURST";
		Dropitem "Shin_MachinePistol";
		DropItem "Shin_HeavyAmmo", 63;
	}
	States
	{
		Spawn:
			MPOS AB 10 A_Look;
			Loop;
		See:
			MPOS AABBCCDD 3 A_Chase();
			Loop;
		Missile:
			MPOS E 11 A_FaceTarget;
			MPOS F 2 BRIGHT A_CPosAttack;
			MPOS E 2 BRIGHT A_FaceTarget;
			MPOS E 0 A_CPosRefire;
			Goto Missile+1;
		Pain:
			MPOS G 3;
			MPOS G 3 A_Pain;
			Goto See;
		Death:
			MPOS H 5;
			MPOS I 5 A_Scream;
			MPOS J 5 A_NoBlocking;
			MPOS K 5;
			MPOS L -1;
			Stop;
		XDeath:
			MPOS M 5;
			MPOS N 5 A_XScream;
			MPOS O 5 A_NoBlocking;
			MPOS PQRST 5;
			MPOS U -1;
			Stop;
	}
}

Extend Class Shin_MachineGunGuy
{
	Void A_GunnerAttack()
	{
		A_FaceTarget();
		A_CustomBulletAttack(22.5, 0, 1, random(1,7)*3, "BulletPuff", 0, CBAF_NORANDOM);
	}
}