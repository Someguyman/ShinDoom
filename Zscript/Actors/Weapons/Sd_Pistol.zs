
Class Shin_Pistol : ShinDoom_Weapon Replaces Pistol
{
	Default
	{
		Weapon.SelectionOrder 1900;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 8;
		Weapon.AmmoType "Shin_LightAmmo";
		Obituary "$OB_MPPISTOL";
		+WEAPON.WIMPY_WEAPON
		+WEAPON.NOAUTOFIRE
		Inventory.Pickupmessage "$PICKUP_PISTOL_DROPPED";
		Weapon.UpSound "weaponUP/Pistol";
		Inventory.PickupSound "misc/w_pkup_Pistol";
		Tag "$TAG_PISTOL";
	}
	
	States
	{
	Ready:
		SDWP A 1 A_ReloadReady(12);
		Loop;
	Deselect:
		SDWP A 1 A_Lower;
		Loop;
	Select:
		SDWP A 1 A_Raise;
		Loop;
	Fire:
		SDWP A 0 A_JumpIf(invoker.mp_clip >= 12,"Reload");
		SDWP B 2 A_FireGlock();
		SDWP C 1;
		SDWP D 1;
		SDWP E 5 { invoker.mp_clip++; }
		SDWP FF 1 A_WeaponReady(WRF_NOBOB|WRF_NOSWITCH);
		SDWP DD 1 A_WeaponReady(WRF_NOBOB|WRF_NOSWITCH);
		SDWP AA 1 A_WeaponReady(WRF_NOBOB|WRF_NOSWITCH);
		SDWP D 0 A_ReFire("Fire.Hold");
		Goto Ready;
	Fire.Hold:
		SDWP A 4 A_JumpIf(invoker.mp_clip >= 12,"Reload");
		SDWP B 2 A_FireGlock();
		SDWP C 1;
		SDWP D 1;
		SDWP E 5;
		SDWP F 2;
		SDWP D 2 { invoker.mp_clip++; }
		SDWP D 0 A_ReFire("Fire.Hold");
		Goto Fire;
	Reload:
		SDWP C 0 Offset(0,32){ If(invoker.mp_clip == 0){ SetWeaponState("Ready"); } }
		SDWP GH 3 Offset(0,32);
		SDWP I 3 Offset(0,32);
		SDWP I 2 Offset(0,41) A_StartSound("weapons/smgo",CHAN_AUTO);
		SDWP I 8 Offset(15,45);
		SDWP I 8 Offset(1,32) A_StartSound("weapons/smgl",CHAN_AUTO);
		SDWP HG 3 Offset(0,32);
		SDWP D 2 Offset(0,32);
		SDWP A 1 Offset(1,36) A_WeaponOffset(0,0,WOF_INTERPOLATE|WOF_KEEPY);
		SDWP G 0 Offset(0,32){ invoker.mp_clip = 0; }
		SDWP AAAAA 1 Offset(0,32) A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	Flash:
		SDWP J 2 Bright A_Light1;
		Goto LightDone;
 	Spawn:
		PIST A -1;
		Stop;
	}
}

Extend Class Shin_Pistol
{
		Action Void A_FireGlock()
		{
			A_gunflash("Flash");
			A_Startsound("weapons/pistol", CHAN_AUTO);
			A_Firebullets(0.2, 0, 1, 5, "BulletPuff", FBF_USEAMMO);
		}
}