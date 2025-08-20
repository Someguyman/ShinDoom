
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
		SHTG A 1 A_WeaponReady;
		Loop;
	Deselect:
		SHTG A 1 A_Lower;
		Loop;
	Select:
		SHTG A 1 A_Raise;
		Loop;
	Fire:
		SHTG A 2 Offset(0,42) A_FireShotgun();
		SHTG A 2 Offset(0,38);
		SHTG ABC 3 Offset(0,32);
		SHTG C 3 Offset(0,34);
		SHTG D 1 Offset(-3,32);
		SHTG D 3 Offset(-5,46);
		SHTG C 6 Offset(-1,32);
		SHTG B 2 Offset(-1,32);
		SHTG B 2 Offset(28,56);
		SHTG A 1 Offset(1,36) A_WeaponOffset(0,0,WOF_INTERPOLATE|WOF_KEEPY);
		SHTG A 1 Offset(0,32);
		SHTG A 7 Offset(0,32) A_ReFire;
		Goto Ready;
	Flash:
		SHTF B 2 Bright A_Light1;
		SHTF A 1 Bright A_Light2;
		Goto LightDone;
	Spawn:
		SHOT A -1;
		Stop;
	}
}