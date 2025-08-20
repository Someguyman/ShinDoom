
Class Shin_Chaingun : ShinDoom_Weapon
{
	Default
	{
		Weapon.SelectionOrder 700;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 60;
		Weapon.AmmoType "Shin_HeavyAmmo";
		Inventory.PickupMessage "$GOTCHAINGUN";
		Weapon.UpSound "weaponUP/Chaingun";
		Inventory.PickupSound "misc/w_pkup_Chaingun";
		Obituary "$OB_MPCHAINGUN";
		Tag "$TAG_CHAINGUN";
	}
	
	Bool IsSpinning;
	
	Action Void A_ChaingunReady()
	{
		 A_WeaponReady(); 
		 if(Invoker.Isspinning == true) 
			SetWeaponState("SpinUp.Part1");
	}
	
	States
	{
	Ready:
		CHGG A 1 A_ChaingunReady();
		Loop;
	Deselect:
		CHGG A 0 A_Stopsound(7);
		CHGG A 0 { Invoker.Isspinning = false; }
	Deselect.Loop:
		CHGG A 1 A_Lower;
		Loop;
	Select:
		CHGG A 0 { Invoker.Isspinning = false; }
	Select.Loop:
		CHGG A 1 A_Raise;
		Loop;
	Fire:
		CHGG A 0 { if(Invoker.Isspinning == true) SetWeaponState("Fire.part4"); }
	Fire.part1:
		CHGG A 0 A_Startsound("Weapon/ChaingunRevUp", 7, CHANF_LOOPING);
		CHGG A 5 A_FireCGun1();
		CHGG B 5;
		CHGG A 4 A_FireCGun2();
		CHGG B 4;
		CHGG B 0 A_ReFire("Fire.part2");
		CHGG A 0 A_Stopsound(7);
		CHGG AAAAAABBBBBB 1 A_ReFire("Fire.part1");
		Goto Ready;
	Fire.part2:
		CHGG A 0 A_Startsound("Weapon/ChaingunRevUp", 7, CHANF_LOOPING);
		CHGG A 4 A_FireCGun3();
		CHGG B 4;
		CHGG B 0 A_ReFire("Fire.part3");
		CHGG A 0 A_Stopsound(7);
		CHGG AAAAAABBBBBB 1 A_ReFire("Fire.part1");
		Goto Ready;
	Fire.part3:
		CHGG A 0 A_Startsound("Weapon/ChaingunRevUp", 7, CHANF_LOOPING);
		CHGG A 3 A_FireCGun3();
		CHGG B 3;
		CHGG A 3 A_FireCGun3();
		CHGG B 3;
		CHGG A 3 A_FireCGun3();
		CHGG B 3;
		CHGG A 3 A_FireCGun3();
		CHGG B 3;
		CHGG B 0 A_ReFire("Fire.part4");
		CHGG A 0 A_Stopsound(7);
		CHGG AAAABBBB 1 A_ReFire("Fire.part1");
		CHGG AAAAAABBBBBB 1 A_ReFire("Fire.part1");
		Goto Ready;
	Fire.part4:
		CHGG A 0 A_Startsound("Weapon/ChaingunRevmid", 7, CHANF_LOOPING);
		CHGG A 2 A_FireCGun4();
		CHGG B 2;
		CHGG B 0 A_ReFire("Fire.part4");
		CHGG A 0 A_CheckSpin();
		Goto SpinDown;
	Altfire:
		CHGG A 0 { if (Invoker.Isspinning == false) { Invoker.Isspinning = true; SetWeaponState("Ready"); } }
	NoSpin:
		CHGG A 0 { if (Invoker.Isspinning == true) { Invoker.Isspinning = false; } }
		Goto Spindown;
	SpinUp.Part1:
		CHGG A 4 A_Startsound("Weapon/ChaingunRevUp", 7);
		CHGG BAB 4;
		CHGG ABABAB 3;
		Goto SpinUp.Part2;
	SpinUp.Part2:
		CHGG A 0 A_Startsound("Weapon/ChaingunRevmid", 7, CHANF_LOOPING);
		CHGG A 2 A_WeaponReady(WRF_NOBOB|WRF_NOSWITCH);
		CHGG B 2;
		CHGG A 0 A_WeaponReady(WRF_NOBOB|WRF_NOSWITCH);
		CHGG A 0 { if(Invoker.Isspinning != true) SetWeaponState("SpinDown"); }
		Goto SpinUp.Part2;
	Spindown:
		CHGG A 0 Offset(1,32) { A_Stopsound(7); A_WeaponOffset(0,0,WOF_INTERPOLATE|WOF_KEEPY); }
		CHGG A 0 Offset(0,32) A_Startsound("Weapon/ChaingunRevDown", 7);
		CHGG AABBBBAAAA 1 Offset(0,32) { if (player.cmd.buttons & BT_ATTACK) { A_ReFire("Fire.part4"); } }
		CHGG BBBBBBAAAAAA 1 Offset(0,32) { if (player.cmd.buttons & BT_ATTACK) { A_ReFire("Fire.part3"); } }
		Goto Ready;
	Flash1:
		CHGF A 5 Bright A_Light1;
		CHGF B 4 Bright A_Light2;
		Goto LightDone;
	Flash2:
		CHGF A 4 Bright A_Light1;
		CHGF B 3 Bright A_Light2;
		Goto LightDone;
	Flash3:
		CHGF A 3 Bright A_Light1;
		CHGF B 2 Bright A_Light2;
		Goto LightDone;
	Flash4:
		CHGF A 2 Bright A_Light1;
		CHGF B 1 Bright A_Light2;
		Goto LightDone;
	Spawn:
		CGUN A -1;
		Stop;
	}
}

Extend Class Shin_Chaingun
{
	Action Void A_FireCGun()
	{
		int ammo = invoker.Ammo1.Amount;
		int rand;
		int ypos;
		// randomize sx
		rand = (((random[GunShot]() & 1) << 1) - 1);
		rand -= 1;
		double sx = rand;

		// randomize sy
		rand = -((((ammo - 1) & 1) << 1) - 1);
		rand -= 1;
		ypos = rand == -2 ? 1 : 2;
		double sy = 32 - ((rand * (ypos)));

		A_WeaponOffset(sx, sy, WOF_INTERPOLATE);
		A_GunFlash("Flash");
		A_Startsound("weapons/chngun", CHAN_WEAPON);
		A_FireBullets(5.6, 0, 2, 5, "BulletPuff", FBF_USEAMMO);
	}
	
	Action Void A_FireCGun1()
	{
		A_FireCGun(); A_GunFlash("Flash1");
	}
	
	Action Void A_FireCGun2()
	{
		A_FireCGun(); A_GunFlash("Flash2");
	}
	
	Action Void A_FireCGun3()
	{
		A_FireCGun(); A_GunFlash("Flash3");
	}
	
	Action Void A_FireCGun4()
	{
		A_FireCGun(); A_GunFlash("Flash4");
	}
	
	Action Void A_CheckSpin()
	{
		if(Invoker.Isspinning == true) 
		SetWeaponState("SpinUp.Part2"); 
	}
}