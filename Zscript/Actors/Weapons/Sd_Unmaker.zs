
Class Shin_Unmaker : DoomWeapon
{
	
	Default
	{
		Height 20;
		Weapon.SelectionOrder 3000;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 50;
		+WEAPON.BFG;
		Weapon.AmmoType "Cell";
		Inventory.PickupMessage "$GOTUNMAKER";
		Obituary "%o wad pulverised by an unkown source";
		Tag "The Unmaker";
	}
	
	States
	{
		Ready:
			LASR A 1 A_WeaponReady;
			Loop;
		Deselect:
			LASR A 1 A_Lower;
			Loop;
		Select:
			LASR A 1 A_Raise;
			Loop;
		Fire:
            LASR B 3 Offset(0,34) A_FireLaser;
			LASR B 2 Offset(0,33);
			LASR B 4 Offset(0,32);
            LASR A 3 A_Refire;
            Goto Ready;
        FireUpgrade1:
            LASR B 2 Offset(0,34) A_FireLaser;
			LASR B 1 Offset(0,33);
			LASR B 2 Offset(0,32);
            LASR A 3 A_Refire;
            Goto Ready;
        FireUpgrade2:
            LASR B 1 Offset(0,34)
            {
                A_FireLaser(0.966797, "");
                A_FireLaser(358.989258);
            }
			LASR B 1 Offset(0,33);
			LASR B 2 Offset(0,32);
            LASR A 3 A_Refire;
            Goto Ready;
        FireUpgrade3:
            LASR B 1 Offset(0,34)
            {
                A_FireLaser(2.988281, "");
		        A_FireLaser();
		        A_FireLaser(-2.988281, "");
            }
			LASR B 1 Offset(0,33);
			LASR B 2 Offset(0,32);
			LASR A 3 A_ReFire("HoldUpgrade31");
            Goto Ready;
        HoldUpgrade31:
            LASR B 1 Offset(0,34)
            {
                A_FireLaser(5.976563, "");
		        A_FireLaser();
		        A_FireLaser(-5.976563, "");
            }
			LASR B 1 Offset(0,33);
			LASR B 2 Offset(0,32);
			LASR A 3 A_ReFire("HoldUpgrade32");
			Goto Ready;
        HoldUpgrade32:
            LASR B 1 Offset(0,34)
            {
                A_FireLaser(8.964844, "");
		        A_FireLaser();
		        A_FireLaser(-8.964844, "");
            }
			LASR B 1 Offset(0,33);
			LASR B 2 Offset(0,32);
			LASR A 3 A_ReFire("HoldUpgrade33");
			Goto Ready;
        HoldUpgrade33:
            LASR B 1 Offset(0,34)
            {
                A_FireLaser(11.997070, "");
		        A_FireLaser();
		        A_FireLaser(-11.997070, "");
            }
			LASR B 1 Offset(0,33);
			LASR B 2 Offset(0,32);
			LASR A 3 A_ReFire("FireUpgrade3");
			Goto Ready;
		Flash:
			LASR CD 2 Bright A_Light1;
			Goto LightDone;
		Spawn:
			LSRP A -1;
			Stop;
	}
}

Class Shin_Demonkeycount : Inventory 
{
	Default
	{
		Inventory.MaxAmount 3;
	}
}

Class Shin_LaserPuff : Actor
{
	int timer;
	int elapsed;
	
	Default
	{
		RenderStyle "Translucent";
		+ZDOOMTRANS
		//RenderStyle "Add";
		+NOGRAVITY;
		+ALLOWPARTICLES;
		+PUFFONACTORS
		+ALWAYSPUFF
		+FORCEXYBILLBOARD
		+NOINTERACTION
        +SKYEXPLODE;
	}
	
	States
	{
		Spawn:
        Crash:
			LSRT B 11 Bright;
			stop;
		Melee:
        Death.Sky:
            TNT1 A 1;
			Stop;
	}
}

Class Shin_UnmakerLaser : FastProjectile
{
	
	Actor pufftarget;
	
	Default
	{
		-ACTIVATEIMPACT
		-ACTIVATEPCROSS
        -BLOODSPLATTER
		+BLOODLESSIMPACT
        +NOBLOODDECALS
        +HITTRACER
        +DONTSPLASH
        +FORCEXYBILLBOARD
        +PAINLESS
		+NOINTERACTION
		+NOGRAVITY
        +NOTONAUTOMAP
		+NOBLOCKMAP
		+ZDOOMTRANS
		Radius 1;
		Height 1;
		MissileType "Shin_UnmakerTrail";
		RenderStyle "Translucent";
		Alpha 0.5;
		Damage 0;
		Speed 200;
	}
	States
	{
	Spawn:
		TNT1 A 1 BRIGHT;
		Loop;
	}
	
	override void Tick()
	{
		super.Tick();
		if (pufftarget && pufftarget.health <= 0) Destroy();
	}
}

Class Shin_UnmakerTrail : actor
{
	Default
	{
		PROJECTILE;
		RenderStyle "Translucent";
		+NOCLIP
		-ACTIVATEIMPACT
		-ACTIVATEPCROSS
        -BLOODSPLATTER
		+BLOODLESSIMPACT
        +NOBLOODDECALS
        +HITTRACER
        +DONTSPLASH
        +FORCEXYBILLBOARD
        +PAINLESS
		+NOINTERACTION
		+NOGRAVITY
        +NOTONAUTOMAP
		+NOBLOCKMAP
		+ZDOOMTRANS
		Alpha 0.5;
		Scale 0.5;
		Speed 0;
	}
	States
	{
	Spawn:
		LSRT A 6 Bright;
		Stop;
	}
}

Extend Class Shin_Unmaker
{
	Actor pufftarget;
	
	action void A_FireLaser(double ang = 0, Sound soundid = "weapons/unmaker", double spawnheight = 40, double range = 4096)
    {
        if (invoker.owner == null || player == null || player.mo == null) return;
		invoker.bNOAUTOFIRE = invoker.default.bNOAUTOFIRE;
		Weapon weap = player.ReadyWeapon;
		if (weap != null && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
		{
			if (!weap.DepleteAmmo (weap.bAltFire, true, 1)) return;
			
		}
		if (soundid != "")
		{
			A_GunFlash();
        	A_StartSound(soundid, CHAN_AUTO, 0, 1.0, ATTN_NORM);
		}

		double angleoffs = invoker.owner.angle+ang;
		FTranslatedLineTarget t;
		double slope = invoker.owner.AimLineAttack(angleoffs, range, t);

		int damage = (random[Laser](0, 7) * 10) + 10; //((P_Random() & 7) * 10) + 10;

		if (t.linetarget)
		{
			angleoffs -= ang;
		}
			
		let puff = Shin_LaserPuff(LineAttack(angleoffs, range, slope, damage, "Hitscan", "Shin_LaserPuff", LAF_NORANDOMPUFFZ, t));
		if (puff)
		{
			double laserDistance = 30;
			Vector2 ofs;
			if (invoker.owner.pitch <= 0)
			{
				ofs = AngleToVector(invoker.owner.angle, laserDistance);
			}
			else
			{
				double offset = invoker.owner.pitch*2 / 3;
				ofs = AngleToVector(invoker.owner.angle, abs(laserDistance-offset));
				if (offset > laserDistance) ofs *= -1;
			}
			double laserAimHeight = spawnheight + (GetBobOffset() + (player ? player.crouchoffset : 0)) - 40;

			let proj = Shin_UnmakerLaser(SpawnPlayerMissile("Shin_UnmakerLaser", angleoffs, ofs.X, ofs.Y, laserAimHeight));
			if (proj)
			{
				AimBulletMissile(proj, puff, 0, false, false);
				if (t.unlinked)
				{
					proj.Angle = angleoffs;
					proj.Pitch = slope;
					proj.Vel3DFromAngle(proj.Speed, proj.Angle, proj.Pitch);
				}
				Vector3 diff = level.vec3diff(proj.pos, puff.pos);
				double length = diff.length();
				Vector3 u = diff.unit();
				double a = atan2(u.y, u.x);
				double p = asin(-u.z);
				proj.A_SetAngle(a, SPF_INTERPOLATE);
				proj.A_SetPitch(p-90, SPF_INTERPOLATE);
				proj.scale.x = 2.0;
				proj.scale.y = length;
				proj.pufftarget = t.linetarget;
				puff.timer = int(length * 0.0334);
			}
		}
    }
	
	override State GetAtkState(bool hold)
    {
        if (owner == null) return super.GetAtkState(hold);
        switch (owner.CountInv("Shin_Demonkeycount"))
        {
            case 1:
                return FindState('FireUpgrade1');
            case 2:
				return (ammo1.amount >= 2) ? FindState('FireUpgrade2') : FindState('FireUpgrade1');
            case 3:
				if (ammo1.amount >= 3)
				{
					return FindState('FireUpgrade3');
				}
				else if (ammo1.amount == 2)
				{
					return FindState('FireUpgrade2');
				}
				else
				{
					return FindState('FireUpgrade1');
				}
            default:
                return FindState('Fire');
        }
    }
}