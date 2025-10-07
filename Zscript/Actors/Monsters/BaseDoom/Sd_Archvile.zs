
Class Shin_Archvile : ShinDoom_Actor Replaces Archvile
{
	Default
	{
		Health 700;
		Radius 20;
		Height 64;
		Mass 500;
		Speed 15;
		PainChance 10;
		Monster;
		MaxTargetRange 896;
		Gibhealth 40;
		+QUICKTORETALIATE 
		+FLOORCLIP 
		+NOTARGET
		+SEEINVISIBLE
		+DONTHARMCLASS
		+ShinDoom_Actor.UNHEALABLE;
		Scale 1.15;
		SeeSound "vile/sight";
		PainSound "vile/pain";
		DeathSound "vile/death";
		ActiveSound "vile/active";
		MeleeSound "vile/stop";
		ShinDoom_Actor.FootstepSound "vile/walk";
		Obituary "$OB_VILE";
		Tag "$FN_ARCH";
	}
	
	States
	{
	Spawn:
		VILE AB 10 A_Look;
		Loop;
	See:
		VILE A 2 A_Footstep;
		VILE ABBCC 2 A_VileChase;
		VILE D 2 A_Footstep;
		VILE DEEFF 2 A_VileChase;
		Goto see;
	Missile:
		VILE G 0 BRIGHT A_JumpIfCloser(120,"Meleefire");
		VILE G 0 BRIGHT A_VileStart();
	Normalattack:		
		VILE G 10 BRIGHT A_FaceTarget;
		VILE H 8 BRIGHT A_VileTarget("Shin_ArchvileFire");
		VILE IJKLMN 8 BRIGHT A_FaceTarget;
		VILE O 8 BRIGHT A_VileAttack;
		VILE P 20 BRIGHT;
		Goto See+1;
	Meleefire:
		VILE G 0 BRIGHT A_VileStart2();
		VILE LM 5 Bright A_FaceTarget();
		VILE M 5 Bright A_FaceTarget();
		VILE KJ 3 Bright A_FaceTarget();
		VILE I 3 A_SpawnProjectile("Shin_VileHellFire", 32, 0, 0);
		VILE HGHIHGHIHGHIGHI 3 Bright A_FaceTarget();
		VILE G 1 A_CPosRefire;
		VILE G 0 BRIGHT A_VileStart();
		Goto Normalattack;
	Heal:
		VILR ABCABC 5 BRIGHT;
		Goto See;
	Pain:
		VILE Q 5;
		VILE Q 5 A_Pain;
		Goto See+1;
	Death.Ice:
		VILE Q 5 A_GenericFreezeDeath;
		TNT1 A 1 A_Freezedeathchunks;
		WAIT;
	Death:
		VILE Q 7;
		VILE R 7 { A_Scream(); A_KillTracer("Missilekiller1", KILS_KILLMISSILES, "Shin_VileHellFire"); }
		VILE S 7 A_NoBlocking;
		VILE TUVWXY 7;
		VILE Z -1 A_NormalDeath();
		Stop;
	XDeath:
		VILX A 1;
		VILX A 4;
		VILX B 5 A_XScream;
		VILX C 5;
		VILX D 5 A_NoBlocking;
		VILX EFGH 5;
		VILX I -1 A_NormalDeath;
		Stop;
	raise:
		VILE Y 6;
		VILE XWVUTSR 6;
		Goto See;
	}
}

class Shin_ArchvileFire : ArchvileFire
{
	void A_StartFire()
	{
		A_Fire();
		A_Startsound("vile/firestrt", CHAN_AUTO);
	}
	States
	{
	Spawn:
		FIRE A 1 BRIGHT;
		FIRE A 1 BRIGHT  A_StartFire();
		FIRE BAB 2 BRIGHT  A_Fire;
		FIRE C 2 BRIGHT  A_FireCrackle;
		FIRE BCBCDCDCDEDED 2 BRIGHT  A_Fire;
		FIRE E 2 BRIGHT  A_FireCrackle;
		FIRE FEFEFGHGHGH 2 BRIGHT  A_Fire;
		Stop;
	}
}

Class Shin_ArchvileXD : Shin_Archvile
{
	Default
	{
		+ShinDoom_Actor.ALWAYSHEAL;
		Tag "Archvile XD";
	}
}

Class Shin_Test_Healer : Shin_Archvile
{
	Default
	{
		-QUICKTORETALIATE
		+NODAMAGE
		+ShinDoom_Actor.ALWAYSHEAL;
	}
	States
	{
		Missile:
			Stop;
		Melee:
			Stop;
	}
}

Class Shin_VileHellFire : Actor
{
  Default
  {
    Obituary "%o was set ablaze by an Archvile.";
    Radius 0;
    Height 1;
    Speed 0;
    //RenderStyle "Add";
    DamageType "Fire";
    Alpha 1.00;
    +NoGravity
    +SeekerMissile
    +NoTarget
    +NoDamageThrust
  }

  States
  {
  Spawn:
    HLFR A 2 Bright A_StartFire;
    HLFR BAB 2 Bright DiabolistFire(2);
    HLFR C 2 Bright DiabolistCrackle(2);
    HLFR B 2 Bright DiabolistFire(2);
    HLFR CBCDCDCDEDED 2 Bright DiabolistFire(3);
    HLFR E 2 Bright DiabolistCrackle(2);
    HLFR F 2 Bright DiabolistFire(2);
    HLFR EFE 2 Bright DiabolistFire(1);
    HLFR FGH 2 Bright DiabolistFire(1);
    HLFR GHGH 2 Bright DiabolistFire(1);
    Stop;
  Death.Missilekiller1:
  Death:
	Stop;
  }
	
  Void A_StartFire2()
  {
	A_StartSound ("vile/start2", CHAN_AUTO);
	A_Fire;
  }

  void DiabolistFire(int damage)
  {
    A_Explode(damage, 25);
    A_Fire();
  }

  void DiabolistCrackle(int damage)
  {
    A_Explode(damage, 25);
	A_Startsound("vile/firecrkl2", CHAN_BODY);
    A_Fire();
  }
}

Class Shin_Archvile_Standie : Shin_MonsterStandie
{
	Default
	{
		Scale 1.15;
	}
	States
	{
		Spawn:
			VILE G -1;
			Stop;
	}
}