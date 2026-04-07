
Class Shin_HellGaurd : Shin_BaronOfHell
{
	Default
	{
		Health 600;
		Speed 8;
		Scale 1.2;
		Species "HellKnoble";
		SeeSound "Gaurd/sight";
		ActiveSound "Gaurd/active";
		PainSound "Gaurd/Pain";
		DeathSound "Gaurd/Death";
		Obituary "%o was tagged by the Hell Gaurd's fireball.";
		HitObituary "%o was torn apart by a Hell Gaurd.";
		ShinDoom_Actor.FootstepSound "Gaurd/walk";
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
		HWAR EF 8 A_FaceTarget;
		HWAR G 8 A_GaurdAttack();
		Goto See;
	Pain:
		HWAR J 2;
		HWAR J 2 A_Pain();
		HWAR J 2 A_Jump(125, "Sheild");
		Goto See;
	Sheild:
		HWAR H 0 A_SetInvulnerable();
		HWAR HHHHHH 5 A_FaceTarget();
		HWAR H 1 A_CPosRefire;
		HWAR I 5 Bright A_FireVolley("Shin_Gaurdball2", 4, 35);
		HWAR H 7 A_FaceTarget();
		HWAR HHHH 5 A_FaceTarget();
		HWAR H 3 A_FaceTarget();
		HWAR H 1 A_CPosRefire;
		HWAR I 5 Bright A_FireVolley("Shin_Gaurdball2");
		HWAR H 0 A_UnSetInvulnerable();
		Goto See;
	Death:
		HWAR K 1;
		HWAR K 4 A_SpawnItemEx("Shin_GaurdShield", 0, 0, 25, 6, 0, 0, 60, 128);
		HWAR L 5 A_Scream();
		HWAR M 5;
		HWAR N 5 A_NoBlocking();
		HWAR OPQRS 5;
		HWAR T -1 A_NormalDeath();
		Stop;
	XDeath:
		HWAX A 5 A_SpawnItemEx("Shin_GaurdShield", 0, 0, 25, 6, 0, 0, 60, 128);
		HWAX B 5 A_XScream;
		HWAX C 5;
		HWAX D 5 A_NoBlocking();
		HWAX EFGH 5;
		HWAX I -1 A_NormalDeath();
		Stop;
	Raise:
		HWAR S 5;
		HWAR RQPONMLK 5;
		Goto See;
	}
}

Class Shin_GaurdShield : ShinDoom_Actor
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

Class Shin_Gaurdball : Shin_BaronBall
{
	Default
	{
		Seesound "gaurd/attack";
		Deathsound "gaurd/shotx";
	}
	States
	{
		Spawn:
			HWFB AB 4 BRIGHT;
			Loop;
		Death:
			HWFB CDE 6 BRIGHT;
			Stop;
	}
}


Class Shin_Gaurdball2 : ShinDoom_Projectile
{
  Default
  {
    Radius 6;
    Height 8;
    Speed 8;
    Damage 2;
    RenderStyle "Add";
    Alpha 0.9;
    Scale 0.5;
    +Ripper
  }

  States
  {
  Spawn:
    GRBA ABCDEFGH 2 Bright;
    Loop;
  Death:
    GRBA AIJKLMN 3 Bright;
    Stop;
  }
}

Extend Class Shin_HellGaurd
{
	Void A_GaurdAttack()
	{
		A_FaceTarget();
		A_CustomComboAttack("Shin_Gaurdball", 32, 10 * random(1, 8), "knight/melee");
	}
	
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		

		BaseSprite = GetSpriteIndex("HWAR");	
		sprite = BaseSprite;
		
		Return;
	}
}