
Class Shin_Reaper : ShinDoom_Weapon
{
	Default
	{
		Inventory.PickupMessage "$GOTREAPER";
		//Weapon.SelectionOrder 1300;
		Obituary "$OB_MPSHOTGUN";
		Tag "Reaper";
	}
	States
	{
	Ready:
		UNMK ABCD 4 A_WeaponReady;
		Loop;
	Deselect:
		UNMK A 1 A_Lower;
		Loop;
	Select:
		UNMK A 1 A_Raise;
		Loop;
	Fire:
		UNMK A 1 Bright;
		UNMK E 1 Bright A_FireShotgun;
		UNMK A 1 Bright;
		UNMK E 1 Bright; 
		UNMK E 1 Bright A_FireShotgun;
		UNMK F 6 Bright; 
		UNMK E 1 Bright A_FireShotgun;
		UNMK FGHIFGHI 4 Bright; 
		UNMK E 3;
		UNMK E 0 A_Refire();
		goto Ready;
	Flash:
		//SHTF A 4 Bright A_Light1;
		//SHTF B 3 Bright A_Light2;
		Goto LightDone;
	Spawn:
		UNMK Z -1;
		Stop;
	}
}