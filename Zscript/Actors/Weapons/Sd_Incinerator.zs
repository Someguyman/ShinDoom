
Class Shin_Incinerator : ShinDoom_Weapon Replaces ID24Incinerator // Incinerator
{
	Default
	{
		Weapon.SelectionOrder 120;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "ID24Fuel";
		Inventory.PickupMessage "$ID24_GOTINCINERATOR";
		Tag "$TAG_ID24INCINERATOR";
	}
	
	States
	{
	Spawn:
		INCN A -1;
		Stop;
	Ready:
		FLMG DE 4 A_WeaponReady;
		Loop;
	Deselect:
		FLMG A 1 A_Lower;
		Loop;
	Select:
		FLMG A 1 A_Raise;
		Loop;
	Fire:
		FLMF A 1 BRIGHT A_InfneratorFire();
		FLMF B 1 BRIGHT;
		FLMG A 1;
		PFLG A 0 A_ReFire("DoFire2");
		Goto Ready;
	DoFire2:
		FLMF C 1 BRIGHT A_InfneratorFire();
		FLMF D 1 BRIGHT;
		FLMG A 1;
		FLMG A 0 A_ReFire("Fire");
		Goto Ready;
	Flash:
		TNT1 A 2 A_Light2;
		TNT1 A 1 A_Light1;
		Goto LightDone;
	}
}

Class Shin_IncineratorFlame : ShinDoom_Actor Replaces ID24IncineratorFlame// Incinerator Flame 
{
	Default
	{
		Damage 5;
		Speed 40;
		Radius 13;
		Height 8;

		Projectile;
		+ZDOOMTRANS;
		+FORCERADIUSDMG;
		RenderStyle "Add";
	}

	States
	{
	Spawn:
		TNT1 A 1 BRIGHT;
		IFLM A 2 BRIGHT;
		IFLM B 2 BRIGHT A_StartSound("weapons/incinerator/burn", CHAN_BODY);
		IFLM CDEFGH 2 BRIGHT;
		Stop;
	Death:
		IFLM A 0 BRIGHT A_Jump(128, "DeathSoundAlt");
		IFLM A 0 BRIGHT A_StartSound("weapons/incinerator/hot1", CHAN_BODY);
		Goto DeathExplosion;
	DeathSoundAlt:
		IFLM A 0 BRIGHT A_StartSound("weapons/incinerator/hot2", CHAN_BODY);
		Goto DeathExplosion;
	DeathExplosion:
		IFLM I 2 BRIGHT A_RadiusDamage(5, 64);
		IFLM JI 2 BRIGHT;
		IFLM J 2 BRIGHT A_RadiusDamage(5, 64);
		IFLM KJ 2 BRIGHT;
		IFLM K 2 BRIGHT A_RadiusDamage(5, 64);
		IFLM L 2 BRIGHT;
		IFLM K 2 BRIGHT A_StartSound("weapons/incinerator/hot3", CHAN_BODY);
		IFLM L 2 BRIGHT A_RadiusDamage(5, 64);
		IFLM ML 2 BRIGHT;
		IFLM M 2 BRIGHT A_RadiusDamage(5, 64);
		IFLM NM 2 BRIGHT;
		IFLM N 2 BRIGHT A_RadiusDamage(5, 64);
		IFLM ONO 2 BRIGHT;
		IFLM POP 2 BRIGHT;
		Stop;
	}
}

Extend Class Shin_Incinerator
{
	Action void A_InfneratorFire()
	{
		A_GunFlash();
		A_StartSound("Weapons/IncineratorFire", CHAN_AUTO);
		MBF21_ConsumeAmmo(1);
		MBF21_WeaponProjectile("Shin_IncineratorFlame", 0, 0, 0, 0);
	}
}