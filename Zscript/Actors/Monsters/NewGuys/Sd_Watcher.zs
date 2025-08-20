	
Class Shin_Watcher : ShinDoom_Actor
{
  Default
  {
		Health 120;
		Radius 24;
		Height 40;
		Mass 150;
		Speed 10;
		PainChance 160;
		MeleeRange 40;
		Scale 1.1;
		FloatBobStrength 0.5;
		FloatBobFactor 0.8;
		DamageType "normal";
		SeeSound "watcher/sight";
		PainSound "watcher/pain";
		DeathSound "watcher/death";
		ActiveSound "watcher/active";
		Species "Cacodemon";
		MONSTER;
		+NOGRAVITY
		+FLOAT
  }

  States
  {
	Spawn:
		WATC A 10 { A_Look(); bFLOATBOB = True; }
		Loop;
	See:
		WATC A 3 A_Chase();
		Loop;
	Missile:
		WATC EF 5 A_FaceTarget();
		WATC G 5 BRIGHT { A_SpawnProjectile("Shin_WatcherShot",12,0,0); A_FaceTarget(); }
		Goto See;
	Melee:
		WATC BCD 5 A_FaceTarget();
		WATC A 5 A_CustomMeleeAttack(4*Random(1,8), "watcher/bite");
		Goto See;
	Pain:
		WATC H 3;
		WATC H 3 A_Pain();
		Goto See;
	Death:
		WATC I 8 { A_Scream(); bFLOATBOB = False; }
		WATC JKLM 6;
		WATC N 6 A_NoBlocking();
		WATC N 0 A_SetFloorClip();
		WATC O -1;
		stop;
	Raise:
		WATC ONMLKJI 8;
		WATC I 0 { bFLOATBOB = True; }
		Goto See;
  }
}

Class Shin_WatcherShot : ShinDoom_Actor
{
  Default
  {
    Radius 4;
    Height 8;
    Speed 20;
    Damage 3;
    RENDERSTYLE "ADD";
    DamageType "lightning";
    ALPHA 0.67;
    SeeSound "watcher/attack";
    DeathSound "watcher/shotx";
    PROJECTILE;
	+Zdoomtrans
    +THRUGHOST
    +FORCEXYBILLBOARD
  }

  States
  {
  Spawn:
    FWAT AB 4 Bright;
    loop;
  Death:
    FWAT CDE 4 Bright;
    stop;
  }
}