
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
		SDWF A 1 A_WeaponReady;
		Loop;
	Deselect:
		SDWF A 1 A_Lower;
		Loop;
	Select:
		SDWF A 1 A_Raise;
		Loop;
	Fire:
		SDWF D 5 Offset(-1,32) { A_Punch(); A_Startsound("weapons/FistSwing", CHAN_AUTO); }
		SDWF D 3 Offset(-5,38);
		SDWF C 3 Offset(-1,32);
		SDWF B 3 Offset(-1,32);
		SDWF A 2 Offset(10,48);
		SDWF A 2 Offset(1,32) A_WeaponOffset(0,0,WOF_INTERPOLATE|WOF_KEEPY);
		SDWF A 3 Offset(0,32) A_Refire();
		Goto Ready;
	Altfire:
		TNT1 B 2;
		TNT1 A 0 A_Refire();
		Goto Fire;
	}
}