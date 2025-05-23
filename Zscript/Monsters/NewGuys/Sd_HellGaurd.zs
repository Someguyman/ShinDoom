
class Shin_HellGaurd : Shin_BaronOfHell
{
	Default
	{
		Health 700;
		Speed 8;
		Scale 1.2;
		SeeSound "Hellwarrior/sight";
		ActiveSound "Hellwarrior/active";
		PainSound "Hellwarrior/Pain";
		DeathSound "Hellwarrior/Death";
		Obituary "%o was tagged by the Hell Gaurd's fireball.";
		HitObituary "%o was torn apart by a Hell Gaurd.";
		MissileChanceMult 1.0;
		BloodColor "red";
		Tag "Hell Gaurd";
	}
	
	States
	{
	Spawn:
		HWAR AB 10 A_Look;
		Loop;
	See:
		HWAR A 0 A_UnSetInvulnerable();
		HWAR A 3 A_Footstep();
		HWAR ABB 3 A_Chase;
		HWAR C 3 A_Footstep();
		HWAR CDD 3 A_Chase;
		Loop;
	Melee:
	Missile:
		HWAR EF 5 A_FaceTarget;
		HWAR G 5 A_GaurdAttack();
		Goto See;
	Pain:
		HWAR J 2 A_Pain();
		HWAR H 0 A_SetInvulnerable();
		HWAR HHHHHH 5 A_FaceTarget();
		HWAR H 1 A_CPosRefire;
		HWAR I 5 Bright A_FireVolley("Baronball");
		HWAR H 7 A_FaceTarget();
		HWAR HHHH 5 A_FaceTarget();
		HWAR H 3 A_FaceTarget();
		HWAR H 1 A_CPosRefire;
		HWAR I 5 Bright A_FireVolley("Baronball");
		HWAR H 0 A_UnSetInvulnerable();
		Goto See;
	Death:
		HWAR K 1;
		HWAR K 4 A_SpawnItemEx("Shin_HellWarriorShield", 0, 0, 25, 6, 0, 0, 60, 128);
		HWAR L 5 A_Scream();
		HWAR M 5;
		HWAR N 5 A_NoBlocking();
		HWAR OPQRS 5;
		HWAR T -1;
		Stop;
	XDeath:
		HWAX A 5 A_SpawnItemEx("Shin_HellWarriorShield", 0, 0, 25, 6, 0, 0, 60, 128);
		HWAX B 5 A_XScream;
		HWAX C 5;
		HWAX D 5 A_NoBlocking();
		HWAX EFGH 5;
		HWAX I -1;
		Stop;
	Raise:
		HWAR S 5;
		HWAR RQPONMLK 5;
		Goto See;
	}
}

Class Shin_HellWarriorShield : Actor
{
	Default
	{
		Radius 8;
		Height 8;
		Speed 6;
		Scale 1.2;
		BounceType "Doom";
		+DropOff;
		+Missile;
	}

  States
  {
	Spawn:
		HWSH ABCDEFGH 3;
		Loop;
	Death:
		HWSH I -1;
		Loop;
  }
}

class Shin_Gaurdball : BaronBall
{
	States
	{
		Spawn:
			HWB2 AB 4 BRIGHT;
			Loop;
		Death:
			HWFB CDE 6 BRIGHT;
			Stop;
	}
}