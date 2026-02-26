
Class Shin_SuperShotgun : ShinDoom_Weapon Replaces SuperShotgun
{
	Default
	{
		Weapon.SelectionOrder 400;
		Weapon.AmmoUse 2;
		Weapon.AmmoGive 8;
		Weapon.AmmoType "Shell";
		Inventory.PickupMessage "$GOTSHOTGUN2";
		Weapon.UpSound "weaponUP/SuperShotgun";
		Inventory.PickupSound "misc/w_pkup_SuperShotgun";
		Obituary "$OB_MPSSHOTGUN";
		Tag "$TAG_SUPERSHOTGUN";
	}
	States
	{
	Ready:
		SDW2 A 1 A_WeaponReady;
		Loop;
	Deselect:
		SDW2 A 1 A_Lower;
		Loop;
	Select:
		SDW2 A 1 A_Raise;
		Loop;
	Fire:
		SDW2 A 2 Offset(0,50) A_FireShotgun2;
		SDW2 A 2 Offset(0,48);
		SDW2 A 5 Offset(0,32);
		SDW2 A 0 Offset(0,32) A_CheckReload;
		SDW2 B 1 Offset(10,46);
		SDW2 B 2 Offset(-10,32);
		SDW2 C 3 Offset(4,34);
		SDW2 C 4 Offset(-1,32);
		SDW2 C 3 Offset(4,34);
		SDW2 C 3 Offset(40,50);
		SDW2 D 3 Offset(1,32) A_OpenShotgun2;
		SDW2 D 3 Offset(40,70);
		SDW2 E 2 Offset(-20,42);
		SDW2 E 4 Offset(1,32);
		SDW2 F 3 Offset(0,32) A_LoadShotgun2;
		SDW2 F 2 Offset(20,45);
		SDW2 F 2 Offset(50,65);
		//TNT1 A 1;
		SDW2 G 3 Offset(40,70);
		SDW2 G 3 Offset(10,32);
		SDW2 H 3 Offset(3,32) A_CloseShotgun2;
		SDW2 H 2 Offset(1,44) { A_ReFire(); A_WeaponOffset(0,0,WOF_INTERPOLATE|WOF_KEEPY); }
		SDW2 A 1 Offset(0,36) A_ReFire;
		SDW2 A 4 Offset(0,32) A_ReFire;
		Goto Ready;
	Flash:
		SDW2 J 2 Bright A_Light1;
		SDW2 I 1 Bright A_Light2;
		Goto LightDone;
	Spawn:
		SGN2 A -1;
		Stop;
	}
}

Class Shin_SSGPuff : BulletPuff
{
	Default
	{
		DamageType "SuperShotgun";
	}
}

extend class Shin_supershotgun
{
	Action Void A_FireShotgun2()
	{
		A_Startsound("weapons/sshotf", CHAN_AUTO);
		A_gunflash("Flash");
		A_Firebullets(11.2, 7.1, 20, 5, "Shin_SSGPuff");
	}
}