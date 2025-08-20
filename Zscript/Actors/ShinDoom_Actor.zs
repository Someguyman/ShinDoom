Class ShinDoom_Actor : Actor
{
	//private int ICONSPAWN;
	int ActorFlags;
	flagdef ICONSPAWN : ActorFlags, 0;
	
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
	
	override void Tick()
    {
        super.Tick();
 
		if (bSHADOW == true)
		{
		
        if (InStateSequence(CurState, ResolveState("Death")) || 
            InStateSequence(CurState, ResolveState("DeathLoop")) || 
            InStateSequence(CurState, ResolveState("DeathStop")) ||
			InStateSequence(CurState, ResolveState("Death.D1")) ||
			InStateSequence(CurState, ResolveState("XDeath")) ||
			InStateSequence(CurState, ResolveState("XDeath.D1")))
         {
             visgoal = 1.0;	
         }
         else
         {
             visgoal = 0.25;
         }
		 
		 if (InStateSequence(CurState, ResolveState("XDeath")) ||
			 InStateSequence(CurState, ResolveState("XDeath.D1")))
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
		if (alpha > visgoal)
		{
				alpha -= visAddSub;
		}
		else if (alpha < visgoal)
		{
				alpha += visAddSub;
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
			 A_SetTranslation("None");
		 }
		 
		 }
    }
	
	Default
	{
		ShinDoom_Actor.FootstepSoundChannel CHAN_AUTO;
		ShinDoom_Actor.XDeathSound "misc/gibbed";
	}
	
	States
	{
		Crush:
			POL5 A 0;
			POL5 A 0 A_Startsound("Bloody/crush");
			POL5 A -1;
			stop;
		Death.SuperShotgun:
			"####" A 0 A_Jumpifcloser(128, "XDeath");
			"####" A 0 A_Jump(256, "Death");
			Goto Death;
	   XDeath:
			Stop;
		Death:
			TNT1 A 8 A_ScaleVelocity(0); 
			TNT1 A 10 A_Spawnprojectile("Shin_ComicalExplosion", 0);
			Stop;
	}
	
	/*
	override void PostBeginPlay()
	{
		super.PostBeginPlay();
		if (bICONSPAWN && (bIsDead == true))
		{
		
		}
	}
	*/
	
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
	
	void A_MetalHoof()
	{
		A_StartSound("cyber/walk", CHAN_BODY, CHANF_DEFAULT, 1, ATTN_IDLE);
		A_Chase();
	}
	
	private void PlayFootstepSound(sound soundname)
    {
        if (!soundname || !cx_mfs_enabled) return;
		if (Pos.Z > FloorZ || self.bOnMobj || waterlevel > 0) return;
		
        A_StartSound(soundname, FootstepSoundChannel, CHANF_DEFAULT, 1, ATTN_IDLE);
    }
	
	Void A_XScream()
	{
		if (bBOSS == True || bFULLVOLDEATH == True)
			A_StartSound(XDeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_NONE);
		else
			A_StartSound(XDeathSound, CHAN_VOICE, CHANF_DEFAULT, 1, ATTN_IDLE);
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
}