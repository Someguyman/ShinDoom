
Class Shin_CombatRifle : ShinDoom_Weapon
{
	Default
	{
		Weapon.SelectionOrder 700;
		Weapon.AmmoUse 1;
		Weapon.Ammouse2 1;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Shin_HeavyAmmo";
		Weapon.AmmoType2 "Shin_HeavyAmmo";
		Inventory.PickupMessage "$GOTRIFLE";
		Obituary "$OB_MPCHAINGUN";
		Tag "Combat Rifle";
		+WEAPON.AMMO_CHECKBOTH
	}
	
	States
	{
	Ready:
		RIFL A 1 A_ReloadReady(31);
		Loop;
	Deselect:
		RIFL A 1 A_Lower;
		Loop;
	Select:
		RIFL A 1 A_Raise;
		Loop;
	Fire:
		RIFF A 0 A_JumpIf(invoker.mp_clip >= 31,"Reload");	
		RIFF B 2 Bright Offset(0,36) A_FireRifle();
		RIFF A 2 Bright Offset(0,34);
		RIFL A 2 Offset(0,32) { invoker.mp_clip++; }
		RIFL B 0 A_ReFire();
		Goto Ready;
	AltFire:
		RIFF A 0 A_JumpIf(invoker.mp_clip >= 31,"Reload");	
		RIFF B 1 Bright Offset(0,36) A_FireRifle();
		RIFF A 1 Bright Offset(0,34) { invoker.mp_clip++; }
		RIFF B 1 Bright Offset(0,36) A_FireRifle();
		RIFF A 1 Bright Offset(0,34) { invoker.mp_clip++; }
		RIFF B 1 Bright Offset(0,36) A_FireRifle();
		RIFF A 1 Bright Offset(0,34) { invoker.mp_clip++; }
		RIFL A 2 Offset(0,32);
		RIFL A 0 A_ReFire("Fire.Delay");
		RIFL A 3;
		RIFL C 3;
		RIFL D 5 A_StartSound("Weapons/RifleR");
		RIFL E 6;
		RIFL D 5;
		RIFL C 3;
		RIFL A 2;
		Goto Ready;
	Fire.Delay:
		RIFL A 13;
		Goto AltFire;
	Reload:
		RIFL C 0 { If(invoker.mp_clip == 0){ SetWeaponState("Ready"); } }
		RIFL FG 4;
		RIFL H 4;
		RIFL I 5 A_StartSound("weapons/smgo",CHAN_AUTO);
		RIFL J 5;
		RIFL K 5 A_StartSound("weapons/smgl",CHAN_AUTO);
		RIFL L 6; //Offset(0,32);
		RIFL F 5 { invoker.mp_clip = 0; }
		Goto Ready;
	Flash:
		Stop;
	Spawn:
		BGUN A -1;
		Stop;
	}
}

Extend Class Shin_CombatRifle
{
	Action void A_FireRifle()
	{
		A_FireBullets (2.5, 0, 1, 5, "BulletPuff");
		A_StartSound("weapons/pistol", CHAN_WEAPON);
		A_GunFlash();
	}	
}