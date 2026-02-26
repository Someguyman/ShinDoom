
Class Shin_GaussCannon : ShinDoom_Weapon
{
	Default
	{
		Weapon.SelectionOrder 2900;
		Weapon.AmmoUse 20;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Cell";
		//WeaponUP/GaussCannon
		Weapon.UpSound "WeaponUP/GaussCannon";
		Inventory.PickupMessage "$GOTGAUSS";
		Tag "$TAG_PLASMARIFLE";
	}
	
	States
	{
	Ready:
		GAUS BCD 3 Bright A_WeaponReady;
		Loop;
	Deselect:
		GAUS A 1 A_Lower;
		Loop;
	Select:
		GAUS A 1 A_Raise;
		Loop;
	Fire:
		GAUS E 2 Bright Offset(0,50) A_RailAttack(450, 0, true, "", "", RGF_CENTERZ | RGF_EXPLICITANGLE, 0, "Shin_GaussExplosion", 0, BulletSlope()-pitch, 0, 0, 0, 0, "Shin_GaussLaserTrail");
		GAUS F 4 Offset(0,50);
		GAUS G 3 Offset(0,48);
		GAUS H 3 Offset(0,45);
		GAUS I 3 Offset(0,39);
		GAUS A 27 Offset(0,32);
		GAUS D 3;
		GAUS I 0 A_ReFire;
		Goto Ready;
	Flash:
		Goto LightDone;
	Spawn:
		GCAN A -1;
		Stop;
	}
}

Extend Class Shin_GaussCannon
{

}