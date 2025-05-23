//
class Shin_Mancubus: ShinDoom_Actor Replaces Fatso
{
	Default
	{
		Health 600;
		Radius 48;
		Height 64;
		Mass 1000;
		Speed 8;
		Gibhealth 40;
		Scale 1.1;
		PainChance 80;
		Monster;
		+FLOORCLIP
		+BOSSDEATH
		+MAP07BOSS1
		+NOINFIGHTSPECIES
		+DONTHARMSPECIES
		SeeSound "fatso/sight";
		PainSound "fatso/pain";
		DeathSound "fatso/death";
		ActiveSound "fatso/active";
		Obituary "$OB_FATSO";
		Tag "$FN_MANCU";
	}
	
	Void A_Manraise()
	{
		A_Startsound("fatso/raiseguns", CHAN_VOICE);
		A_FaceTarget();
	}
	
	void A_ManAttack1()
	{
		A_FaceTarget();
		A_SpawnProjectile("FatShot",18,-34,20);
		A_SpawnProjectile("FatShot",18,34,0);
	}
	
	void A_ManAttack2()
	{
		A_FaceTarget();
		A_SpawnProjectile("FatShot",18,-34,0);
		A_SpawnProjectile("FatShot",18,34,-20);
	}
	
	void A_ManAttack3()
	{
		A_FaceTarget();
		A_SpawnProjectile("FatShot",18,-34,8);
		A_SpawnProjectile("FatShot",18,34,-8);
	}
	
	void A_ManAttack4()
	{
		A_FaceTarget();
		A_SpawnProjectile("Shin_FireTrail",18,-34,8);
		A_SpawnProjectile("Shin_FireTrail",18,34,-8);
	}

	States
	{
	Spawn:
		FATT AB 15 A_Look;
		Loop;
	See:
		FATT AABBC 4 A_Chase;
		FATT C 4 A_Chase;
		FATT DDEEF 4 A_Chase;
		FATT F 4 A_Chase;
		Loop;
	Missile:
		FATT G 12 A_Manraise();
		FATT A 0 Bright A_JumpIfCloser(260,"Missile.Flamethrower");
		FATT G 8 A_FaceTarget;
		FATT H 10 BRIGHT A_ManAttack1();
		FATT IG 5 A_FaceTarget;
		FATT H 10 BRIGHT A_ManAttack2();
		FATT IG 5 A_FaceTarget;
		FATT H 10 BRIGHT A_ManAttack3();
		FATT IG 5 A_FaceTarget;
		Goto See;
	Melee:
		FATT G 12 A_Manraise();
		Goto Missile.Flamethrower;
	Missile.Flamethrower:
		FATT HHHHHH 3 BRIGHT A_ManAttack4();
		FATT IG 5 A_FaceTarget;
		Goto See;
	Pain:
		FATT J 3;
		FATT J 3 A_Pain;
		Goto See;
	 Death:
		FATT K 6;
		FATT L 6 A_Scream;
		FATT M 6 A_NoBlocking;
		FATT NOPQRS 6;
		FATT T -1 A_BossDeath;
	    Stop;
	Death.Ice:
		FATT J 5 A_GenericFreezeDeath;
		TNT1 J 1 A_Freezedeathchunks;
		WAIT;
	XDeath:
		FATX A 5;
		FATX B 5 A_XScream;
		FATX C 5 A_NoBlocking();
		FATX DEF 5;
		FATX G -1 A_BossDeath;
		Stop;
	Crush:
		MANG A 0;
		MANG A 0 A_Startsound("Bloody/crush");
		MANG A -1;
		stop;
	Raise:
		FATT R 5;
		FATT QPONMLK 5;
		Goto See;
	}
}

class Shin_FireTrail : ShinDoom_Actor
{
	Default
	{
		Radius 6;
		Height 8;
		Speed 16;
		FastSpeed 20;
		DamageFunction 2;
		Mass 100;
		Scale 0.8;
		Projectile;
		BounceType "Doom";
		+ZDOOMTRANS
		+Ripper
		RenderStyle "Add";
		Seesound "vile/firecrkl";
		Alpha 1;
	}
	
	void A_Fireburn()
	{
		A_Explode(5, 8, 0);
		A_Fire();
	}
	
	void A_Vilefirestart()
	{
		A_Fire();
		A_Startsound("vile/Firestart");
	}
	
	States
	{
	Spawn:
		FLAM A 0 BRIGHT { A_Vilefirestart(); A_FireCrackle(); }
		FLAM B 3 BRIGHT 
		{
		A_Fireburn();
		A_LowGravity();
		}
		FLAM C 4 BRIGHT A_Fireburn();
		FLAM DE 2 BRIGHT A_Fireburn();
	Death:
		FLAM F 3 BRIGHT A_Fireburn();
		FLAM GH 1 BRIGHT A_Fireburn();
		Stop;
	}
}