
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
		Tag "$TAG_PISTOL";
	}
	
	States
	{
	Ready:
		PISG A 1 A_ReloadReady(12);
		Loop;
	Deselect:
		PISG A 1 A_Lower;
		Loop;
	Select:
		PISG A 1 A_Raise;
		Loop;
	Fire:
		PISG A 0 A_JumpIf(invoker.mp_clip >= 12,"Reload");
		PISG B 2 A_FireGlock();
		PISG C 1;
		PISG D 1;
		PISG E 5 { invoker.mp_clip++; }
		PISG FF 1 A_WeaponReady(WRF_NOBOB|WRF_NOSWITCH);
		PISG DD 1 A_WeaponReady(WRF_NOBOB|WRF_NOSWITCH);
		PISG AA 1 A_WeaponReady(WRF_NOBOB|WRF_NOSWITCH);
		PISG D 0 A_ReFire("Fire.Hold");
		Goto Ready;
	Fire.Hold:
		PISG A 4 A_JumpIf(invoker.mp_clip >= 12,"Reload");
		PISG B 2 A_FireGlock();
		PISG C 1;
		PISG D 1;
		PISG E 5;
		PISG F 2;
		PISG D 2 { invoker.mp_clip++; }
		PISG D 0 A_ReFire("Fire.Hold");
		Goto Fire;
	Reload:
		SMGG C 0 Offset(0,32){ If(invoker.mp_clip == 0){ SetWeaponState("Ready"); } }
		PISG GH 3 Offset(0,32);
		PISG I 3 Offset(0,32);
		PISG I 2 Offset(0,41) A_StartSound("weapons/smgo",CHAN_AUTO);
		PISG I 8 Offset(15,45);
		PISG I 8 Offset(1,32) A_StartSound("weapons/smgl",CHAN_AUTO);
		PISG HG 3 Offset(0,32);
		PISG D 2 Offset(0,32);
		PISG A 1 Offset(1,36) A_WeaponOffset(0,0,WOF_INTERPOLATE|WOF_KEEPY);
		PISG G 0 Offset(0,32){ invoker.mp_clip = 0; }
		PISG AAAAA 1 Offset(0,32) A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	Flash:
		PISF A 2 Bright A_Light1;
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
			A_Firebullets(0.2, 0, 1, 4, "BulletPuff", FBF_USEAMMO);
		}
}