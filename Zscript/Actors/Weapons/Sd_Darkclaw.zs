
Class Shin_DarkClaw : ShinDoom_Weapon
{
	Default
	{
		//Weapon.SelectionOrder 3700;
		//Weapon.Kickback 100;
		Inventory.PickupMessage "$GOTCLAW";
		Obituary "$OB_MPFIST";
		Tag "$TAG_FIST";
		//+WEAPON.NOAUTOSWITCHTO
	}
	
	States
	{
	Ready:
		DRKC AAAAAAAAAAAA 1 A_WeaponReady;
		DRKC BBBBB 1 A_WeaponReady;
		DRKC AAAAA 1 A_WeaponReady;
		DRKC BBBBB 1 A_WeaponReady;
		Loop;
	Deselect:
		DRKC A 1 A_Lower;
		Loop;
	Select:
		DRKC A 1 A_Raise;
		Loop;
	Fire:
		DRKC C 4 Bright;
		DRKC D 15
		{
			//A_FirePistol();
			//A_FirePistol();
			//A_FirePistol();
			//A_FireShotgun();
			A_FireProjectile("Shin_DarkClaw_Ball");
			A_FireProjectile("Shin_DarkClaw_Ball", 5);
			A_FireProjectile("Shin_DarkClaw_Ball", -5);
		}
		DRKC E 5;
		DRKC F 4;
		DRKC C 3;
		DRKC A 3;
		DRKC G 8;
		DRKC A 1 A_ReFire;
		Goto Ready;
	Spawn:
		DRKC Z -1;
		stop;
	}
}

Class Shin_DarkClaw_Ball : Shin_BaronBall
{
	Default
	{
		Speed 20;
		FastSpeed 20;
	}
}