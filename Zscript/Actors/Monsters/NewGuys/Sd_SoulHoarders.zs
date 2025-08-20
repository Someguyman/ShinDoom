
Class Shin_SoulHarvester : ShinDoom_Actor
{
  Default
  {
    Health 100;
    Radius 20;
    Height 56;
    Speed 8;
    PainChance 160;
    SeeSound "harvester/sight";
    PainSound "harvester/pain";
    DeathSound "harvester/death";
    ActiveSound "harvester/active";
    Obituary "%o couldn't evade the soul harvester's attack.";
    MONSTER;
    +FLOORCLIP
	Tag "Soul Harvester";
  }

  States
  {
  Spawn:
    SLHV AB 10 A_Look();
    Loop;
  See:
    SLHV AABBCCDD 3 A_Chase();
    Loop;
  Melee:
  Missile:
    SLHV EFG 4 A_FaceTarget();
    SLHV HIJK 5 Bright A_FaceTarget();
    SLHV L 8 Bright { A_FaceTarget(); A_SpawnProjectile("Shin_SoulHarvesterBall", 32, 0, 0, CMF_AIMDIRECTION|CMF_BADPITCH); }
    SLHV M 10;
    Goto See;
  Pain:
    SLHV N 3;
    SLHV N 3 A_Pain();
    Goto See;
  Death:
    SLHV O 7 A_Scream();
    SLHV PQR 7;
    SLHV S 6 A_SpawnItemEx("Shin_SoulHarvesterGhost", 0,0,32, 0,0,0, 0, SXF_CLIENTSIDE);
    SLHV T 5 A_Fall();
    SLHV UV 5;
    SLHV W -1;
    Stop;
  XDeath:
    SLHV X 6 A_Xscream();
    SLHV Y 6 A_SpawnItemEx("Shin_SoulHarvesterGhost", 0,0,32, 0,0,0, 0, SXF_CLIENTSIDE);
    SLHV Z 6;
    SLHV [ 6 A_Fall();
    SLHV ] 6;
    SLHW A -1;
    Stop;
  Raise:
    SLHV WVUTSRQPO 5;
    Goto See;
  }
}

Class Shin_SoulDevourer : Shin_Cacodemon
{
	Default
	{
		Health 250;
		SeeSound "Devourer/Sight";
		ActiveSound "Devourer/Active";
		PainSound "Devourer/Pain";
		DeathSound "Devourer/Death";
		Bloodcolor "Red";
		Species "SoulDevourer";
	}
	States
	{
		Spawn:
			SLDR A 10 { A_Look(); bFLOATBOB = True; }
			Loop;
		See:
			SLDR A 3 A_Chase;
			Loop;
		Melee:
			Stop;
		Missile:
			SLDR B 6 Bright A_FaceTarget;
			SLDR CD 6 Bright A_FaceTarget;
			SLDR E 6 BRIGHT { A_FaceTarget(); A_SpawnProjectile("Shin_BigSoulHarvesterBall",22,0,0,CMF_AIMDIRECTION|CMF_BADPITCH); }
			SLDR DC 6 Bright A_FaceTarget;
			Goto See;
		Pain:
			SLDR F 6;
			SLDR G 6 A_Pain;
			Goto See;
	   XDeath:
		Death:
			SLDR H 6 {bFLOATBOB = False;}
			SLDR I 6 A_Scream;
			SLDR JKL 6;
			SLDR M 5 A_SpawnItemEx("Shin_SoulHarvesterGhost",0,0,48,0,0,0,0,SXF_CLIENTSIDE);
		DeathLoop:
			SLDR M 1 A_CheckFloor("DeathStop");
			Loop;
		DeathStop:
			SLDR N 6 A_StartSound("caco/deathland", 0);
			SLDR O 6; 
			SLDR P 6 A_NoBlocking;
			SLDR Q -1 A_SetFloorClip;
			Stop;
		Raise:
			SLDR Q 7 A_UnSetFloorClip;
			SLDR PONMLKJI 7;
			SLDR A 0 {bFLOATBOB = True;}
			Goto See;
	}
}

Class Shin_SoulReaper : Shin_BaronOfHell
{
  Default
  {
    Health 400;
    Radius 24;
    Height 64;
    Speed 7;
	scale 1.1;
    PainChance 35;
	mass 750;
    SeeSound "reaper/sight";
    PainSound "reaper/pain";
    DeathSound "reaper/death";
    ActiveSound "reaper/active";
	ShinDoom_Actor.FootstepSound "skeleton/walk";
    Obituary "%o couldn't evade the soul Reaper's attack.";
	Bloodcolor "red";
	Tag "Soul Reaper";
    MONSTER;
    +FLOORCLIP
	-BOSSDEATH
	-E1M8BOSS
  }
	
  States
  {
  Spawn:
    SLRP AB 10 A_Look();
    Loop;
  See:
	SLRP A 3 A_Footstep();
	SLRP ABB 3 A_Chase;
	SLRP C 3 A_Footstep();
	SLRP CDD 3 A_Chase;
	Loop;
  Melee:
	SLRP EF 5 A_FaceTarget();
	SLRP G 5 A_CustomMeleeAttack(random(1, 10) * 6, "Knight/melee");
	SLRP HI 5 A_FaceTarget();
	SLRP J 5 A_CustomMeleeAttack(random(1, 10) * 6, "Knight/melee");
	Goto see;
  Missile:
    SLRP KLM 6 Bright A_FaceTarget();
    SLRP N 8 Bright A_FireVolley("Shin_SoulReaperBall", 0, 56, 45, CMF_AIMDIRECTION|CMF_BADPITCH);
    SLRP M 6 bright;
	SLRP O 6 bright;
    Goto See;
  Pain:
    SLRP P 3;
    SLRP P 3 A_Pain();
    Goto See;
  Death:
	SLRP Q 1;
    SLRP Q 6 A_Scream();
    SLRP RST 7;
    SLRP U 7 A_SpawnItemEx("Shin_SoulHarvesterGhost", 0,0,32, 0,0,0, 0, SXF_CLIENTSIDE);
    SLRP V 6;
    SLRP W 6 A_Fall();
	SLRP XY 6;
    SLRP Z -1;
    Stop;
  Death.SSGGIBING:
	Stop;
  XDeath:
    Stop;
  Raise:
    SLRP WVUTSRQPO 5;
    Goto See;
  }
}

Class Shin_SoulHarvesterBall : ShinDoom_Actor
{
  Default
  {
    Radius 8;
    Height 6;
    Scale 0.4;
    Speed 9;
    DamageFunction 14; 
    Renderstyle "Add";
    SeeSound "harvester/scream";
    DeathSound "imp/shotx";
    Decal "DoomImpScorch";
	+ZdoomTrans
    PROJECTILE;
    +SEEKERMISSILE
  }

  States
  {
	Spawn:
		SHBA A 0 Bright A_SpawnItemEx("Shin_SoulBallTrail", 0, 0, 0, 0, 0, 0, 180, SXF_CLIENTSIDE);
		SHBA AB 2 Bright A_SeekerMissile(10,20);
		Loop;
	Death:
		SHBA CDEFGHIJKL 4 Bright;
		Stop;
  }
}

Class Shin_SoulBallTrail : ShinDoom_Actor
{
  Default
  {
    Radius 1;
    Height 1;
    Speed 0;
	+ZdoomTrans
    RENDERSTYLE "ADD";
    ALPHA 0.5;
    PROJECTILE;
    +NOCLIP
  }

  States
  {
	Spawn:
	Death:
		SBTR H 6;
		SBTR ABCDEFG 4 Bright;
		Stop;
  }
}

Class Shin_BigSoulHarvesterBall : Shin_SoulHarvesterBall
{
  Default
  {
    DamageFunction 22;
	Scale 0.6;
  }
  States
  {
	Spawn:
		SHBA A 0 Bright A_SpawnItemEx("Shin_BigSoulBallTrail", 0, 0, 0, 0, 0, 0, 180, SXF_CLIENTSIDE);
		SHBA AB 2 Bright A_SeekerMissile(10,20);
		Loop;
  }
}

Class Shin_BigSoulBallTrail : Shin_SoulBallTrail
{
  Default
  {
    Scale 1.3;
  }
}

Class Shin_SoulReaperBall : Shin_BigSoulHarvesterBall
{ 
  	void A_ReaperTracer()
    {
		if (threshold < 0)
		{
			A_SeekerMissile(10,20);
		}
		else
		{
			threshold--;
		}
    }
  States
  {
	Spawn:
		SHBA A 0 Bright A_SpawnItemEx("Shin_BigSoulBallTrail", 0, 0, 0, 0, 0, 0, 180, SXF_CLIENTSIDE);
		SHBA AB 2 Bright A_ReaperTracer();
		Loop;
  }
}

Class Shin_SoulHarvesterGhost : ShinDoom_Actor
{
  Default
  {
    Radius 1;
    Height 1;
    Speed 0;
	+ZdoomTrans
    RENDERSTYLE "ADD";
    ALPHA 0.7;
    SeeSound "harvester/ghost";
    PROJECTILE;
    +NOCLIP
  }

  States
  {
	Spawn:
	Death:
		SHGH A 0 NoDelay A_Startsound("Harvester/Ghost");
		SHGH ABCDEFG 4 Bright;
		Stop;
  }
}