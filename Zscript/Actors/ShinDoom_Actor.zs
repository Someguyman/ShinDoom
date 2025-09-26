Class ShinDoom_Actor : Actor Replaces Actor
{
	Default
	{
		ShinDoom_Actor.FootstepSoundChannel CHAN_AUTO;
		ShinDoom_Actor.XDeathSound "misc/gibbed";
		+NOSPLASHALERT
		+NOTELESTOMP
	}
	
	States
	{
	   Crush:
			POL5 A 0;
			POL5 A 0 A_Startsound("Bloody/crush");
			POL5 A -1;
			stop;
	   Death.SuperShotgun:
			"####" A 0 A_Jumpif(Self.SpawnHealth() > 400, "Death");
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
			"####" A 8 A_ScaleVelocity(0); 
			"####" A 10 A_Spawnprojectile("Shin_ComicalExplosion", 0);
			Stop;
		DeathFade:
			"####" "#" 30;
			"####" "#" 10 A_SpawnItemEx("Shin_DeathFire",0,0,0,0,0,0,0,SXF_TRANSFERSCALE,0,0);
		DeathFade.Loop:
			"####" "#" 0 {A_JumpIf(radius<=0,"NULL"); A_JumpIf(height<=0,"NULL"); A_JumpIf(scale.x<=0,"NULL");}
			"####" "#" 3 A_FadeOut(0.05);
			"####" "#" 0 {A_SetSize(radius-1,height-1); A_SetScale(scale.x-0.05,scale.y-0.05);}
			Loop;
		Raise:
			"####" "#" 0
			{
				A_SpectreDisappear();
				STOPFADDING == false;			
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

	Bool ISGIBBED;
	Bool STOPFADDING;
	
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
    bool BecomeInvisible;
	
	SpriteID BaseSprite;
	
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		
		if (bISMONSTER)
		{
			if (bBOSSSPAWNED == true)
			{
				bNEVERRESPAWN = true;
				bNOTELESTOMP = false;
				bTELESTOMP = true;
				bNOFEAR = true;
				bBRIGHT = true;
				bSTAYDEAD = true;
				//bNOBLOOD = true;
				A_SetRenderStyle(0.60, STYLE_Translucent);
				A_SetTranslation("IconSpawn");
			}
		
			if (bSTAYDEAD == true)
			{
				bUNHEALABLE = true;
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
	
	override void Tick()
    {				
        super.Tick();
		
		if(bISMONSTER)
		{
			if (InStateSequence(CurState, ResolveState("Shin.Raise")) || 
				InStateSequence(CurState, ResolveState("XRaise")))
			{
				A_RaiseStart();
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
 
			if (bSHADOW == true)
			{
			
			if (InStateSequence(CurState, ResolveState("Spawn")) || 
				InStateSequence(CurState, ResolveState("Idle")))
			{
				A_SetRenderStyle(0.25, STYLE_OptFuzzy);
			}
		
			if (InStateSequence(CurState, ResolveState("Death")) || 
				InStateSequence(CurState, ResolveState("DeathLoop")) || 
				InStateSequence(CurState, ResolveState("DeathStop")) ||
				InStateSequence(CurState, ResolveState("Death.D1")) ||
				InStateSequence(CurState, ResolveState("XDeath")) ||
				InStateSequence(CurState, ResolveState("XDeath.D1")))
			{
				if (bBOSSSPAWNED == true)
				{
					visgoal = 0.60;
				}
				else
				{
					visgoal = 1.0;	
				}
			}
			else
			{
				if (bBOSSSPAWNED == true)
				{
					visgoal = 0.15;
				}
				else
				{
					visgoal = 0.25;
				}
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
         
			// Smooth fading effect
			if (STOPFADDING != true)
			{
			if (alpha > visgoal)
			{
					alpha -= visAddSub;
			}
			else if (alpha < visgoal)
			{
					alpha += visAddSub;
			}
			}
		 
			if (alpha <= visgoalx1)
			{
				if (bBOSSSPAWNED != true)
					A_SetTranslation("SpectrePal1");
			}		 
		 
			if ((alpha > visgoalx1) && (alpha < visgoalx2))
			{
				if (bBOSSSPAWNED != true)
					A_SetTranslation("SpectrePal2");
			}
			
			if ((alpha > visgoalx2) && (alpha < visgoalx3))
			{
				if (bBOSSSPAWNED != true)
					A_SetTranslation("SpectrePal3");
			}	 
		 
			if ((alpha > visgoalx3) && (alpha <= 1.0))
			{
				if (bBOSSSPAWNED != true)
				{
					A_SetTranslation("None");
				}
				else
				{
					A_SetTranslation("IconSpawn");
				}			
			}		 
		 }		 
	   }
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
	
	void A_DualProjectileAttack(Class<Actor> spawntype = "PlasmaBall", double height = 32, double offset = 25)
	{
		A_FaceTarget();
		A_SpawnProjectile(spawntype, height, offset, 0);
		A_SpawnProjectile(spawntype, height,-offset, 0);
	}
	
	void A_FireVolley(Class<Actor> spawntype = "PlasmaBall", int numMissiles = 3, double coneAngle = 30, double spawnHeight = 32, int flags = 0)
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
		if (bSHADOW == true)
		{
			A_StartSound("spectre/visible", CHAN_AUTO);
		}
	}
	
	void A_SpectreDisappear()
	{
		if (bSHADOW == true)
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
			STOPFADDING = true;
			A_SetRenderStyle(0.60, STYLE_Translucent);
			SetState(FindState("DeathFade"));
		}
	}
	
	Void A_ShinBossDeath()
	{
		A_Bossdeath();
		A_NormalDeath();
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
				A_SpawnItemEx ("Shin_FlyingBlood", 1, 1, random(8,32), random(0,5), random(0,5), random(8,18), random(0,360), SXF_USEBLOODCOLOR, 0);
			}
		}
	}
	
	Void A_Scream()
	{
		if (bBOSS == True || bFULLVOLDEATH == True)
			{ A_StartSound(DeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_NONE); }
		else
			{ A_StartSound(DeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_IDLE); }
			
		A_SpectreAppear();
	}
	
	Void A_XScream()
	{
		if (bBOSS == True || bFULLVOLDEATH == True)
			{ A_StartSound(XDeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_NONE); A_BloodSplat(32); }
		else
			{ A_StartSound(XDeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_IDLE); A_BloodSplat(20); }
			
		A_SpectreAppear();
	}
	
	Void A_RaiseStart()
	{
		bNOPAIN = true;
		DamageFactor = 0.3;
	}
	
	Void A_RaiseEnd()
	{
		bNOPAIN = false;
		DamageFactor = 1.0;
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