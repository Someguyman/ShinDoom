Class ShinDoom_Actor : Actor Replaces Actor
{
	Default
	{
		PainSound "demon/pain";
		ActiveSound "demon/active";
		ShinDoom_Actor.FootstepSoundChannel CHAN_AUTO;
		ShinDoom_Actor.XDeathSound "misc/gibbed";
		+NOSPLASHALERT
	}
	
	States
	{
	   Crush:
			POL5 A 0;
			POL5 A 0 A_Startsound("Bloody/crush");
			"####" A 0 A_Jump(256, "Crush.Loop");
			Goto Crush.Loop;
		Crush.Loop:
			POL5 A -1;
			stop;
	   Death.SuperShotgun:
			"####" A 0 A_Jumpif(Self.SpawnHealth() > 400, "Death"); //Any enemy with 400 + health will not gib to the super shotgun
	   Death.BFGSplash:
			"####" A 0 A_Jumpif(Self.SpawnHealth() > 1000, "Death");
			"####" A 0 A_Jumpifcloser(128, "XDeath");
			"####" A 0 A_Jump(256, "Death");
			Stop;
	   Death.WeakAttack:
			"####" A 0 A_Jump(256, "Death");
			Stop;
	   Death.BarrelExplosion:
			"####" A 0 A_Jump(128, "XDeath");
			"####" A 0 A_Jump(256, "Death");
			Goto Death;
	   Death.lol:
			Goto Death;
	   XDeath:
			Stop;
		Death:
			"####" "#" 8 Bright A_ScaleVelocity(0); 
			"####" "#" 10 Bright A_Spawnprojectile("Shin_ComicalExplosion", 0);
			Stop;
		DeathFade:
			"####" "#" 24;
			"####" "#" 0 A_ShrinkingFade();
			"####" "#" 3 A_SetTranslation("IconSpawn");
			"####" "#" 0 A_ShrinkingFade();
			"####" "#" 3 Bright { A_DeathFireSpawn(); A_SetTranslation("IconSpawn2"); }
			"####" "#" 0 A_ShrinkingFade();
		DeathFade.Loop:
			"####" "#" 0 {A_JumpIf(radius<=0,"NULL"); A_JumpIf(height<=0,"NULL"); A_JumpIf(scale.x<=0,"NULL");}
			"####" "#" 3 Bright A_FadeOut(0.05);
			"####" "#" 0 A_ShrinkingFade;
			Loop;
		Goner:
			Stop;
		Raise:
			"####" "#" 0
			{
				//A_RaiseStart();
				A_SpectreDisappear();		
				A_RestoreSprite();
				return isgibbed? ResolveState("XRaise") : ResolveState("Shin.Raise");
			}
			stop;	
		XRaise:
			"####" A 0 A_Jump(256, "Shin.Raise");
			Goto Shin.Raise;
		Shin.Raise:
			"####" "#" 0;
			Stop;
	}
}

Extend Class ShinDoom_Actor
{
	int ActorFlags;
	
	flagdef UNHEALABLE : ActorFlags, 0;
	flagdef ALWAYSHEAL : ActorFlags, 1;
	flagdef STAYDEAD : ActorFlags, 2;
	flagdef SHINSHADOW : ActorFlags, 3;
	flagdef STARTINVIS : ActorFlags, 4;

	Bool ISGIBBED;
	Bool ISINVISABLE;
	
	int FootstepSoundChannel;
	sound FootstepSound;
	
	sound XDeathSound;
	
	property FootstepSound : FootstepSound;
	property FootstepSoundChannel : FootstepSoundChannel;
	
	property XDeathSound : XDeathSound;
	
	double visgoal;
	double visgoalx1;
	double visgoalx2;
	double visgoalx3;
	double visAddSub;
	Vector3 spawnheight;
    bool BecomeInvisible;
	
	SpriteID BaseSprite;
	
	override void BeginPlay()
	{
		Vector3 CurrentPos;
		//Vector3 NewPos = Vec3Offset(0,0,32);
		super.BeginPlay();
				
		if (bISMONSTER)
		{	
			if ((Self.SpawnHealth() >= 400) && (XDeathSound == "misc/gibbed"))
			{
				XDeathSound = "misc/biggibbed";
			}
			
			if (bSTAYDEAD == true)
			{
				bUNHEALABLE = true;
			}
			
			if(bSHINSHADOW == true)
			{
				A_SetRenderStyle(1.0, STYLE_OptFuzzy);
			}
			
			if (bFLOAT == true)
			{
				FloatBobStrength = 0.35;
				FloatBobFactor = 0.8;
				bFLOATBOB = true;
				
				if (( Target != null && (self.pos.Z <= target.pos.Z)) && self.height >= 56)
					self.SetOrigin(self.pos + (0, 0, 11.5), true);
			}
		}
	}
	
	
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		
		if (bISMONSTER)
		{
			if (bBOSSSPAWNED == true)
			{
				bNEVERRESPAWN = true;
				bTELESTOMP = true;
				bSTAYDEAD = true;
				bBOSSDEATH = false;
			}
		}
	}
	
	override bool CanResurrect (actor other, bool passive)
    {
		if (!passive && other is "ShinDoom_Actor")
        {
			return (!ShinDoom_Actor(other).bUNHEALABLE || (bALWAYSHEAL && !ShinDoom_Actor(other).bSTAYDEAD));
        }
		
		return true;
    }
	
	override void Die(Actor source, Actor inflictor, int dmgflags, Name MeansOfDeath)
	{
		if (bISMONSTER)
		{	
			A_SpectreAppear();
		}
		super.Die(source, inflictor, dmgflags, MeansOfDeath);
	}
	
	override void Tick()
    {				
        super.Tick();
		
		if(bISMONSTER)
		{
			if (InStateSequence(CurState, ResolveState("Shin.Raise")) || 
				InStateSequence(CurState, ResolveState("XRaise")))
			{
				A_RaiseStart(); //When in the raise state, call this function
			}	
			else
			{
				A_RaiseEnd();
			}
		
			if (InStateSequence(CurState, ResolveState("XDeath")) || 
				InStateSequence(CurState, ResolveState("XDeath.D1")))
			{
				ISGIBBED = true;
			}
			else if (!(InStateSequence(CurState, ResolveState("Shin.Raise")) || (InStateSequence(CurState, ResolveState("Raise")))))
			{
				ISGIBBED = false;
			}
 
			if (bSHINSHADOW == true)
			{
		
				if (InStateSequence(CurState, ResolveState("Death")) || 
					InStateSequence(CurState, ResolveState("DeathLoop")) || 
					InStateSequence(CurState, ResolveState("DeathStop")) ||
					InStateSequence(CurState, ResolveState("Death.D1")) ||
					InStateSequence(CurState, ResolveState("XDeath")) ||
					InStateSequence(CurState, ResolveState("XDeath.D1")) ||
					InStateSequence(CurState, ResolveState("DeathFade.Loop")) ||
					InStateSequence(CurState, ResolveState("DeathFade")) ||
					(InStateSequence(CurState, ResolveState("Spawn")) && bSTARTINVIS != true) || 
					(InStateSequence(CurState, ResolveState("Idle")) && bSTARTINVIS != true))
				{
					visgoal = 1.0;	
					bSHADOW = false;
					ISINVISABLE = false;
				}
				else
				{
					visgoal = 0.25;
					bSHADOW = true;
					ISINVISABLE = true;
				}
		 
				if (InStateSequence(CurState, ResolveState("XDeath")) ||
					InStateSequence(CurState, ResolveState("XRaise")) ||
					InStateSequence(CurState, ResolveState("XDeath.D1")) ||
				  ((InStateSequence(CurState, ResolveState("Shin.Raise")) || 
					InStateSequence(CurState, ResolveState("Raise"))) && ISGIBBED == true))
				{
					visAddSub = 0.035;
					visgoalx1 = 0.15;
					visgoalx2 = 0.35;
					visgoalx3 = 0.45;
				}
				else
				{
					visAddSub = 0.025;
					visgoalx1 = 0.25;
					visgoalx2 = 0.45;
					visgoalx3 = 0.75;
				}
			
				if ((ISINVISABLE == true) && (alpha > visgoal))
				{
					if ( (alpha < visgoal) || bSTARTINVIS == true)
					{
						alpha = 0.25;
					}
					else
					{
						alpha -= visAddSub;
					}
				}
			
				if ((ISINVISABLE != true) && (alpha < visgoal))
				{
					if(!InStateSequence(CurState, ResolveState("DeathFade.Loop")))
					{
						if (alpha > visgoal)
						{
							alpha = 1.0;
						}
						else
						{
							alpha += visAddSub;
						}
					}
				}
		 
				if (alpha <= visgoalx1)
				{
					A_SetTranslation("SpectrePal1");
				}		 
		 
				if ((alpha > visgoalx1) && (alpha < visgoalx2))
				{
					A_SetTranslation("SpectrePal2");
				}
			
				if ((alpha > visgoalx2) && (alpha < visgoalx3))
				{
					A_SetTranslation("SpectrePal3");
				}	 
		 
				if ((alpha > visgoalx3) && (alpha <= 1.0))
				{
					if(!InStateSequence(CurState, ResolveState("DeathFade")))
					{
						A_SetTranslation("None");	
					}
				}		 
			}		 
	   }
    }
	
	void A_FlyLook()
	{
		A_Look();
		if (bFLOAT == true && bNOGRAVITY == true)
			bFLOATBOB = true;
	}
	
	void A_FlyChase()
	{
		A_Chase();
		if (bFLOAT == true && bNOGRAVITY == true)
			bFLOATBOB = true;
	}
	
	void A_BruisAttack()
	{
		let targ = target;
		if (targ)
		{
			if (CheckMeleeRange())
			{
				int damage = random[pr_bruisattack](1, 8) * 10;
				A_StartSound ("baron/melee", CHAN_WEAPON);
				int newdam = target.DamageMobj (self, self, damage, "Melee");
				targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			}
			else
			{
				A_FaceTarget();
				SpawnMissile (target, "BaronBall");
			}
		}
	}
	
	action void A_RestoreSprite()
	{
		invoker.sprite = invoker.BaseSprite;
	}
	
	void A_DualProjectileAttack(Class<Actor> spawntype = "PlasmaBall1", double height = 32, double offset = 25)
	{
		A_FaceTarget();
		A_SpawnProjectile(spawntype, height, offset, 0);
		A_SpawnProjectile(spawntype, height,-offset, 0);
	}
	
	void A_FireVolley(Class<Actor> spawntype = "PlasmaBall1", int numMissiles = 3, double coneAngle = 30, double spawnHeight = 32, int flags = 0)
	{
		if (NumMissiles == 0) numMissiles = 3;
		if (NumMissiles == 1) numMissiles = 2;
		if (ConeAngle == 0) coneAngle = 30;
		if (spawnHeight == 0) spawnHeight = 32;
		
		A_FaceTarget();
		double angStep = coneAngle / (numMissiles - 1);
		for (double pAngle = coneAngle * -0.5; pangle <= coneAngle * 0.5; pAngle += angStep)
		{
			A_SpawnProjectile(spawntype, spawnHeight, angle: pAngle, flags: flags);
		}
	}
	
	void A_SpectreAppear()
	{
		if (bSHINSHADOW == true)
		{
			A_StartSound("spectre/visible", CHAN_AUTO);
		}
	}
	
	void A_SpectreDisappear()
	{
		if (bSHINSHADOW == true)
		{
			A_StartSound("spectre/invisible", CHAN_AUTO);
		}
	}
	
	void A_Footstep()
	{
		PlayFootstepSound(FootstepSound);
		A_Chase();
	}
	
	Void A_BattleCry(sound soundname)
	{
		A_StartSound(soundname, CHAN_VOICE);
		A_FaceTarget();
	}
	
	void A_VileStart()
	{
		A_StartSound ("vile/start", CHAN_AUTO);
	}
	
	void A_VileStart2()
	{
		A_StartSound ("vile/start2", CHAN_AUTO);
	}
	
	void A_MetalHoof()
	{
		A_StartSound("cyber/walk", CHAN_BODY, CHANF_DEFAULT, 1, ATTN_IDLE);
		A_Chase();
	}
	
		
	Void A_NormalDeath()
	{	
		if (bBOSSSPAWNED == true)
		{
			SetState(FindState("DeathFade"));
		}
	}
	
	Void A_ShinBossDeath()
	{
		A_Bossdeath();
		A_NormalDeath();
	}
	
	Void A_DeathFireSpawn()
	{
		if (Radius >= 77)
			A_SpawnItemEx("Shin_DeathFire_Extra_Large");
		else if (Radius > 30)
			A_SpawnItemEx("Shin_DeathFire_Large");
		else if (Radius <= 20)
			A_SpawnItemEx("Shin_DeathFire_Small");
		else
			A_SpawnItemEx("Shin_DeathFire");
	}
	
	private void PlayFootstepSound(sound soundname)
    {
        if (!soundname) return;
		if (Pos.Z > FloorZ || self.bOnMobj || waterlevel > 0) return;
		
        A_StartSound(soundname, FootstepSoundChannel, CHANF_DEFAULT, 1, ATTN_IDLE);
    }
	
	void A_BloodSplat(Int Bloodcount = 5)
	{
		if (Bloodcount == 0) { Bloodcount = 5; }
		
		if (bNOBLOOD != true)
		{
			For (Int I; I <= Bloodcount; I++)
			{
				A_SpawnItemEx("Shin_FlyingBlood", random(0,1), random(0,1), random(8,32), random(0,5), random(0,5), random(8,18), random(0,360), SXF_USEBLOODCOLOR, 0);
			}
		}
	}
	
	Void A_Scream()
	{
		if (bFLOAT == true && bNOGRAVITY == true)
			bFLOATBOB = FALSE;
		
		if (bBOSS == True || bFULLVOLDEATH == True)
			{ A_StartSound(DeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_NONE); }
		else
			{ A_StartSound(DeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_IDLE); }
	}
	
	Void A_XScream()
	{
		if (bFLOAT == true && bNOGRAVITY == true)
			bFLOATBOB = FALSE;
		
		if (bBOSS == True || bFULLVOLDEATH == True)
			{ A_StartSound(XDeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_NONE); A_BloodSplat(35); }
		else
			{ A_StartSound(XDeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_IDLE); A_BloodSplat(22); }
	}
	
	Void A_RaiseStart()
	{
		bNOPAIN = true;
		DamageFactor = 0.3;
		if (bFLOAT)
		{
			bFLOATBOB = FALSE;
		}
	}
	
	Void A_RaiseEnd()
	{
		bNOPAIN = false;
		DamageFactor = 1.0;
		if (bFLOAT)
		{
			bFLOATBOB = TRUE;
		}
	}
	
	Void A_ShrinkingFade()
	{
		A_SetSize(radius-1,height-1); 
		A_SetScale(scale.x-0.07,scale.y-0.07);
	}
	
	void A_SummonDudes()
	{
		static const Class<Actor> BaseSpawn[] =
		{
			'Doomimp',
			'Demon',
			'Spectre',
			'Lostsoul',
			'Shin_Gargoyle',
			'Shin_Watcher',
			'HellKnight'
		};
		
		if (DamageType == 'Massacre') return;
		
		A_Facetarget();
		//class<Actor> cls;
		Actor Spawned;
		Vector3 FinalPos;
		int limit = 21;
		
		A_StartSound ("misc/teleport",CHAN_VOICE);
 				
		//Repeat this code 3 times, to spawn 3 clones.
		For (Int I; I <= 3; I++)
		{
			//Randomly offsets the position of the actor that will be spawned, relative to the Archviles' position.
 			FinalPos = Vec3Offset (FRandom(160,-160),FRandom (160,-160),0); 
			Spawned = Spawn (BaseSpawn[Random(0,6)],FinalPos,ALLOW_REPLACE);
 			Spawn ("Shin_TeleportFogRed",FinalPos); //Spawn effect.
					
			Spawned.CopyFriendliness (Self,True); //Make the clone of the Archviles' target share its' allegience.
			//Remove the clone if it's out of bounds.
			If (!Level.IsPointInLevel(FinalPos))
			Spawned.Destroy();
		}
	}
}

Class ShinDoom_Projectile : Actor
{
	Default
	{
		Projectile;
		+RANDOMIZE
		//+ZDOOMTRANS
		//+ShinDoom_Projectile.EXPLOSIVE
		RenderStyle "Translucent";
		Alpha 0.75;
		SeeSound "imp/attack";
		DeathSound "imp/shotx";
		ShinDoom_Projectile.ExplosionSound "weapons/rocklx";
	}
	States
	{
	Spawn:
		BAL2 AB 4 BRIGHT;
		Loop;
	Death:
		"####" "#" 0
		{
			return bEXPLOSIVE? ResolveState("Death.Explosion") : ResolveState("Death.Normal");
		}
		Stop;
	Death.Normal:
		BAL2 CDE 6 BRIGHT;
		Stop;
	Death.Explosion:
		MISL B 0 Bright { A_StopSound(CHAN_VOICE); A_StartSound(ExplosionSound, Chan_Auto); A_SetRenderStyle(0.7, STYLE_Translucent); A_NoGravity(); }
		MISL B 8 Bright A_Explode(-1, -1.0, 0, 0, 0, 0, 10, "BulletPuff", "ExplosionDM");
		MISL C 6 Bright;
		MISL D 4 Bright;
		Stop;
	}
}

Extend Class ShinDoom_Projectile
{
	int ProjFlags;
	sound ExplosionSound;
	
	property ExplosionSound : ExplosionSound;

	flagdef EXPLOSIVE : ProjFlags, 1;
	
	override void BeginPlay()
	{
		super.BeginPlay();
				
		if (bMISSILE)
		{	
			if (bEXPLOSIVE)
			{
				A_SetRenderStyle(1.0, STYLE_NORMAL);
				bFOILINVUL = true;
			}
		}
	}
	
	void A_Tracer()
	{
		// killough 1/18/98: this is why some missiles do not have smoke
		// and some do. Also, internal demos start at random gametics, thus
		// the bug in which revenants cause internal demos to go out of sync.

		//if (level.maptime & 3)	return;
	
		// spawn a puff of smoke behind the rocket
		SpawnPuff ("BulletPuff", pos, angle, angle, 3);
		Actor smoke = Spawn ("RevenantTracerSmoke", Vec3Offset(-Vel.X, -Vel.Y, 0.), ALLOW_REPLACE);
	
		if (smoke != null)
		{
			smoke.Vel.Z = 1.;
			smoke.tics -= random[Tracer](0, 3);
			if (smoke.tics < 1)
				smoke.tics = 1;
		}

		// The rest of this function was identical with Strife's version, except for the angle being used.
		A_Tracer2(16.875);
	}
}

Class ShinDoom_Weapon : DoomWeapon
{

	Int mp_clip;

	action void SetWeaponState(statelabel st,int layer=PSP_WEAPON)
	{
		if(player) player.setpsprite(layer,invoker.findstate(st));
	}
	
	Action Void A_ReloadReady(Int mp_maxClip)
	{
		A_Weaponready(WRF_ALLOWRELOAD);
		If(invoker.mp_clip >= mp_maxClip)
		{
			SetWeaponState("Reload");
		}
		else
		{
			Return;
		}
	}
	
	action void A_FireShotgun()
	{
		if (player == null)
		{
			return;
		}

		A_StartSound ("weapons/shotgf", CHAN_WEAPON);
		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (!weap.DepleteAmmo (weap.bAltFire, true))
				return;
			
			player.SetPsprite(PSP_FLASH, weap.FindState('Flash'), true);
		}
		player.mo.PlayAttacking2 ();

		double pitch = BulletSlope ();

		for (int i = 0; i < 8; i++)
		{
			GunShot (false, "BulletPuff", pitch);
		}
	}
	
	action void A_FireShotgun2()
	{
		if (player == null)
		{
			return;
		}

		A_StartSound ("weapons/sshotf", CHAN_WEAPON);
		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (!weap.DepleteAmmo (weap.bAltFire, true))
				return;
			
			player.SetPsprite(PSP_FLASH, weap.FindState('Flash'), true);
		}
		player.mo.PlayAttacking2 ();

		double pitch = BulletSlope ();
			
		for (int i = 0 ; i < 21 ; i++)
		{
			int damage = 5 * random[FireSG2](1, 3);
			double ang = angle + Random2[FireSG2]() * (11.25 / 256);

			// Doom adjusts the bullet slope by shifting a random number [-255,255]
			// left 5 places. At 2048 units away, this means the vertical position
			// of the shot can deviate as much as 255 units from nominal. So using
			// some simple trigonometry, that means the vertical angle of the shot
			// can deviate by as many as ~7.097 degrees.

			LineAttack (ang, PLAYERMISSILERANGE, pitch + Random2[FireSG2]() * (7.097 / 256), damage, 'Hitscan', "BulletPuff");
		}
	}
	
	action void A_CloseShotgun2()
	{
		 A_StartSound ("weapons/sshotc", CHAN_WEAPON);
	}
	
	action void A_FireBFG()
	{
		if (player == null)
		{
			return;
		}
		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (!weap.DepleteAmmo (weap.bAltFire, true, deh.BFGCells))
				return;
		}

		A_GunFlash();
		SpawnPlayerMissile("BFGBall", angle, nofreeaim:sv_nobfgaim);
	}
	
	States
	{
		
	}
}

Class Shin_MonsterStandie : ShinDoom_Actor
{
	Default
	{
		Radius 16;
		Height 52;
		ProjectilePassHeight -16;
		+SOLID
		Translation "MonoChrome";
	}
	States
	{
		Spawn:
			TNT1 A -1 Bright;
			Stop;
	}
}