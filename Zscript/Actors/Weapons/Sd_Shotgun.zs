
Class Shin_Shotgun : ShinDoom_Weapon Replaces Shotgun
{
	Default
	{
		Weapon.SelectionOrder 1300;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 8;
		Weapon.AmmoType "Shell";
		Weapon.UpSound "weaponUP/Shotgun";
		Inventory.PickupSound "misc/w_pkup_Shotgun";
		Inventory.PickupMessage "$GOTSHOTGUN";
		Obituary "$OB_MPSHOTGUN";
		Tag "$TAG_SHOTGUN";
	}
	States
	{
	Ready:
		SDWS A 1 A_WeaponReady;
		Loop;
	Deselect:
		SDWS A 1 A_Lower;
		Loop;
	Select:
		SDWS A 1 A_Raise;
		Loop;
	Fire:
		SDWS A 2 Offset(0,42) A_FireShotgun();
		SDWS A 2 Offset(0,38);
		SDWS ABC 3 Offset(0,32);
		SDWS C 3 Offset(0,34);
		SDWS D 1 Offset(-3,32);
		SDWS D 3 Offset(-5,46);
		SDWS C 6 Offset(-1,32);
		SDWS B 2 Offset(-1,32);
		SDWS B 2 Offset(28,56);
		SDWS A 1 Offset(1,36) A_WeaponOffset(0,0,WOF_INTERPOLATE|WOF_KEEPY);
		SDWS A 1 Offset(0,32);
		SDWS A 7 Offset(0,32) A_ReFire;
		Goto Ready;
	Flash:
		SDWS E 2 Bright A_Light1;
		SDWS F 1 Bright A_Light2;
		Goto LightDone;
	Spawn:
		SHOT A -1;
		Stop;
	}
}