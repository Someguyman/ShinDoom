
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
		Obituary "%o was riddled with bullets by a burstgunner.";
		Tag "Burstgunner";
		Dropitem "Shin_CombatRifle";
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

Class Shin_DeadMachinegunGuy : Shin_MachinegunGuy
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
			Goto Super::Death+4;
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
		AttackSound "grunt/attack";
		PainSound "MechaZombie/Pain";
		DeathSound "MechaZombie/Death";
		ActiveSound "MechaZombie/Active";
		Obituary "$OB_ZOMBIE";
		Tag "$FN_ZOMBIE";
	}
	States
	{
	Spawn:
		POSM AB 10 A_Look;
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

Class Shin_DeadMechaZombie : Shin_MechaZombie
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
			Goto Super::Death+4;
	}
}

Extend Class Shin_MachineGunGuy
{
	Void A_GunnerAttack()
	{
		A_FaceTarget();
		A_CustomBulletAttack(22.5, 0, 1, random(1,5)*3, "BulletPuff", 0, CBAF_NORANDOM);
	}
}