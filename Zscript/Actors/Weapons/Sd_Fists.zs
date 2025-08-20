
Class Shin_Fist : ShinDoom_Weapon replaces Fist
{
	Default
	{
		Weapon.SelectionOrder 3700;
		Weapon.Kickback 100;
		Obituary "$OB_MPFIST";
		Tag "$TAG_FIST";
		+WEAPON.WIMPY_WEAPON
		+WEAPON.MELEEWEAPON
		+WEAPON.NOAUTOSWITCHTO
	}
	States
	{
	Ready:
		PUNG A 1 A_WeaponReady;
		Loop;
	Deselect:
		PUNG A 1 A_Lower;
		Loop;
	Select:
		PUNG A 1 A_Raise;
		Loop;
	Fire:
		PUNG D 5 Offset(-1,32) A_Punch();
		PUNG D 3 Offset(-5,38);
		PUNG C 3 Offset(-1,32);
		PUNG B 3 Offset(-1,32);
		PUNG A 2 Offset(10,48);
		PUNG A 2 Offset(1,32) A_WeaponOffset(0,0,WOF_INTERPOLATE|WOF_KEEPY);
		PUNG A 3 Offset(0,32) A_Refire();
		Goto Ready;
	}
}