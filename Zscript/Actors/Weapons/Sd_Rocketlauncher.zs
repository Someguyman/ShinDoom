
Class Shin_RocketLauncher : ShinDoom_Weapon replaces RocketLauncher
{
	Default
	{
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 2;
		Weapon.AmmoType "RocketAmmo";
		+WEAPON.NOAUTOFIRE
		Weapon.UpSound "weaponUP/RocketLauncher";
		Inventory.PickupSound "misc/w_pkup_RocketLauncher";
		Inventory.PickupMessage "$GOTLAUNCHER";
		Tag "$TAG_ROCKETLAUNCHER";
	}
	
	States
	{
	Ready:
		SDWR A 1 A_WeaponReady;
		Loop;
	Deselect:
		SDWR A 1 A_Lower;
		Loop;
	Select:
		SDWR A 1 A_Raise;
		Loop;
	Fire:
		SDWR A 2 A_FireRLaunch();
		SDWR B 10 Offset(0,38);
		SDWR B 3 Offset(0,34);
		SDWR A 3 Offset(0,34);
		SDWR A 3 Offset(0,32);
		SDWR B 0 A_ReFire;
		Goto Ready;
	Flash:
		SDWR C 3 Bright A_Light2;
		SDWR D 4 Bright A_Light2;
		SDWR E 4 Bright A_Light1;
		SDWR F 2 Bright A_Light1;
		Goto LightDone;
	Spawn:
		LAUN A -1;
		Stop;
	}
}

Class Shin_PlayerRocket : ShinDoom_Actor
{
	Default
	{
		Radius 11;
		Height 8;
		Speed 25;
		Damage 20;
		Projectile;
		+RANDOMIZE
		+DEHEXPLOSION
		+ZDOOMTRANS
		SeeSound "weapons/rocklf";
		DeathSound "weapons/rocklx";
		Obituary "$OB_MPROCKET";
	}
	States
	{
	Spawn:
		MISL A 1 Bright;
		Loop;
	Death:
		MISL B 8 Bright A_Explode;
		MISL C 6 Bright;
		MISL D 4 Bright;
		Stop;
	BrainExplode:
		MISL BC 10 Bright;
		MISL D 10 A_BrainExplode;
		Stop;
	}
}

extend Class Shin_RocketLauncher
{
	Action Void A_FireRLaunch()
	{
		A_GunFlash("Flash");
		A_FireProjectile("Shin_PlayerRocket",0,1); 
		A_Startsound("weapons/rocketlauncher", CHAN_AUTO);
	}
}