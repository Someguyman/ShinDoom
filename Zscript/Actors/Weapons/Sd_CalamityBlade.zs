
Class Shin_CalamityBlade : ShinDoom_Weapon Replaces ID24CalamityBlade // Heatwave Generator
{
	Default
	{
		Weapon.SelectionOrder 1000;
		Weapon.AmmoUse 10;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "ID24Fuel";
		Inventory.PickupMessage "$ID24_GOTCALAMITYBLADE";
		Tag "$TAG_ID24CALAMITYBLADE";
	}	
	
	States
	{
	Spawn:
		CBLD A -1;
		Stop;
	Ready:
		HETG A 1 A_WeaponReady;
		Loop;
	Deselect:
		HETG A 1 A_Lower;
		Loop;
	Select:
		HETG A 1 A_Raise;
		Loop;
	Fire:
	Hold:
		HETG A 20 A_CalamityCharge();
		HETG A 0 A_CalamityRefire();
	Attack:
		HETF A 3 BRIGHT A_FireCalamity();
		HETF B 4 BRIGHT;
		HETG E 3 BRIGHT;
		HETG D 4;
		HETG C 4;
		HETG B 4;
		HETG A 0 A_ReFire;
		Goto Ready;
	FlashCharge1:
		HETC A 6 BRIGHT;
		HETC BCD 5 BRIGHT;
		Goto LightDone;
	FlashCharge2:
		HETC E 6 BRIGHT;
		HETC FGH 5 BRIGHT;
		Goto LightDone;
	FlashCharge3:
		HETC I 6 BRIGHT;
		HETC JKL 5 BRIGHT;
		Goto LightDone;
	FlashCharge4:
		HETC M 6 BRIGHT;
		HETC NOP 5 BRIGHT;
		Goto LightDone;
	FlashCharge5:
		HETC Q 6 BRIGHT;
		HETC RST 5 BRIGHT;
		Goto LightDone;
	Flash:
		TNT1 A 3 A_Light1;
		TNT1 A 5 A_Light2;
		Goto LightDone;
	}
}

Class Shin_CalamityProjectile : ShinDoom_Actor Replaces ID24IncineratorProjectile // Heatwave Ripper 
{
	Default
	{
		Damage 10;
		Speed 20;
		Radius 16;
		Height 8;

		Projectile;
		+ZDOOMTRANS;
		+RIPPER;
		RenderStyle "Add";

		DeathSound "weapons/calamityblade/explode";
	}

	States
	{
		Spawn:
			HETB ABC 3 Bright;
			Loop;
		Death:
			HETB DEFGHI 3 Bright;
			Stop;
	}
}

Extend Class Shin_CalamityBlade
{
	int chargeCount;
	
	Action Void A_CalamityReady()
	{
		A_WeaponReady();
	}
	
	Action Void A_CalamityCharge()
	{		
		static const statelabel FlashState[] = 
		{
			'FlashCharge1',
			'FlashCharge2',
			'FlashCharge3',
			'FlashCharge4',
			'FlashCharge5'
		};

		if (invoker.DepleteAmmo(false))
		{
			A_GunFlash(FlashState[invoker.chargeCount]);
			A_StartSound("weapons/calamityblade/charge", CHAN_WEAPON);
			invoker.chargeCount++;	
		}			
	}
	
	Action Void A_CalamityRefire()
	{
		if (invoker.chargeCount < 5 && invoker.CheckAmmo(PrimaryFire, false))
		{
			A_ReFire();
		}
	}
	
	Action Void A_FireCalamity()
	{	
		if (player == null)
		{
			return;
		}
		
		Weapon weap = player.ReadyWeapon;
		double maxAngle;
		
		//From JellyIIGrim's Legacy of Rust Weapons:	
		// In Legacy of Rust vertical autoaim is completely disabled for Heatwave,
		// presumably to prevent situations where a part of the "wave" is autoaimed
		// and a part isn't (supposedly ugly?)
		// Here instead we calculate the autoaim-affected slope with BulletSlope()
		// and then just unconditinally apply it to all projectiles, so if they
		// do get autoaimed, they'll be autoaimed together:
		double projPitch = BulletSlope();
			
		//We Start at an angle of 5
		//Each angle afterwards will be increased by 7.5, multiplied by our invoker variable.
		//We offset our invoker variable by 1 for more accurate results.
		maxAngle = ((invoker.chargeCount - 1) * 7.5) + 5;
		for (double pangle = -maxAngle; pangle <= maxAngle; pangle += 5.0)
		{
			// Since autoaim is handled manually, we'll need FPF_NOAUTOAIM:
			A_FireProjectile("Shin_CalamityProjectile", pangle, useammo: false, flags: FPF_NOAUTOAIM, pitch: DeltaAngle(pitch, projPitch));
		}
		
		A_GunFlash("Flash");
		A_StartSound("weapons/calamityblade/shoot", CHAN_WEAPON);
		
		invoker.chargeCount = 0;
		A_ClearRefire();
	}
}