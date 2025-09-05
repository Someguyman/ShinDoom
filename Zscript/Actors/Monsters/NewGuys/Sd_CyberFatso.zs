
Class Shin_CyberFatso : Shin_mancubus
{
	Default
	{
		Health 800;
		Radius 48;
		Height 64;
		Mass 1000;
		Speed 8;
		PainChance 80;
		Monster;
		+NORADIUSDMG
		+SEEINVISIBLE
		Scale 1.2;
		SeeSound "fatso/sight";
		PainSound "fatso/pain";
		DeathSound "fatso/death";
		ActiveSound "fatso/active";
		Obituary "$OB_FATSO";
		Tag "Cyber Mancubus";
	}
	States
	{
	Spawn:
		CFAT AB 15 { A_Look(); A_RestoreSprite(); }
		Loop;
	See:
		CFAT A 4 A_Footstep();
		CFAT ABBCC 4 A_Chase;
		CFAT D 4 A_Footstep();
		CFAT DEEFF 4 A_Chase;
		Loop;
	Missile:
		CFAT G 12 A_BattleCry("fatso/raiseguns");
		CFAT A 0 Bright A_JumpIfCloser(260,"Missile.Flamethrower");
		CFAT G 4 A_FaceTarget;
		CFAT H 10 BRIGHT A_ManAttack1();
		CFAT IG 5 A_FaceTarget;
		CFAT H 10 BRIGHT A_ManAttack2();
		CFAT IG 5 A_FaceTarget;
		CFAT H 10 BRIGHT A_ManAttack3();
		CFAT IG 5 A_FaceTarget;
		Goto See;
	Melee:
		CFAT G 12 A_BattleCry("fatso/raiseguns");
		Goto Missile.Flamethrower;
	Missile.Flamethrower:
		CFAT HHHHHH 3 BRIGHT A_ManAttack4();
		CFAT IG 5 A_FaceTarget;
		Goto See;
	Pain:
		CFAT J 3;
		CFAT J 3 A_Pain;
		Goto See;
	XDeath:
	Death:
		CFAT K 6 Bright;
		CFAT L 6 Bright A_Scream;
		CFAT M 6 Bright A_NoBlocking;
		CFAT NOPQ 6 Bright;
		CFAT RS 6;
		CFAT T -1 A_BossDeath;
		Stop;
	Death.Ice:
		CFAT J 5 A_GenericFreezeDeath;
		TNT1 J 1 A_Freezedeathchunks;
		WAIT;
	Crush:
		MANG A 0;
		MANG A 0 A_Startsound("Bloody/crush");
		MANG A -1;
		stop;
	Raise:
		stop;
	}
}

Extend Class Shin_CyberFatso
{
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		

		BaseSprite = GetSpriteIndex("CFAT");	
		sprite = BaseSprite;
		
		SeeSound = "Fatso/Sight";
		PainSound = "Fatso/Pain";
		DeathSound = "Fatso/Death";
		ActiveSound = "Fatso/Active";
		SetTag("Cyber Mancubus");
		
		Return;
	}
}