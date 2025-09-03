
Class Shin_BFG9000 : ShinDoom_Weapon Replaces BFG9000
{
	Default
	{
		Height 20;
		Weapon.SelectionOrder 2800;
		Weapon.AmmoUse 40;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Cell";
		+WEAPON.NOAUTOFIRE;
		Inventory.PickupMessage "$GOTBFG9000";
		Weapon.UpSound "weaponUP/BFG9000";
		Inventory.PickupSound "misc/w_pkup_BFG9000";
		Tag "$TAG_BFG9000";
	}
	
	States
	{
	Ready:
		BFGG A 1 A_WeaponReady;
		Loop;
	Deselect:
		BFGG A 1 A_Lower;
		Loop;
	Select:
		BFGG A 1 A_Raise;
		Loop;
	Fire:
		BFGG B 2 A_BFGsound;
		BFGG ABAB 2;
		BFGG B 10;
		BFGG B 10 A_Bfgflash();
		BFGG C 4 A_FireBFG;
		BFGG C 4 offset(0, 29);
		BFGG A 4 offset(0, 34);
		BFGG A 20 offset(0, 32) A_ReFire;
		Goto Ready;
	Spawn:
		BFUG A -1;
		Stop;
	Charge:
		BFGC ABABABABABABAB 2 Bright A_Light1;
		Goto LightDone;
	GLOW:
		BFGO A 2 Bright A_Light1;
		TNT1 A 2 Bright A_Light1;
		BFGO A 2 Bright A_Light1;
		TNT1 A 2 Bright A_Light1;
		BFGO A 2 Bright A_Light1;
		BFGO B 20 Bright A_Light1;
		Goto LightDone;
	Gun.Flash:
		BFGF A 6 Bright A_Light1;
		BFGF B 4 Bright A_Light2;
		Goto LightDone;
	Flash:
		TNT1 A 0 Bright;
		Goto LightDone;
	OldFire:
		BFGG A 10 A_BFGsound;
		BFGG BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB 1 A_FireOldBFG;
		BFGG B 0 A_Light0;
		BFGG B 20 A_ReFire;
		Goto Ready;
	}
}

Class Shin_BFGBall : ShinDoom_Actor Replaces BFGBall
{
	Default
	{
		Radius 13;
		Height 8;
		Speed 35;
		Damage 100;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		SeeSound "Weapons/BfgBallFire";
		DeathSound "weapons/bfgx";
		Obituary "$OB_MPBFG_BOOM";
	}
	States
	{
	Spawn:
		BFS1 AB 2 Bright A_Startsound("Weapons/BfgBallFly", CHAN_BODY, CHANF_LOOPING, 1, ATTN_NORM);
		Loop;
	Death:
		BFE1 AB 8 Bright A_Stopsound(CHAN_BODY);
		BFE1 C 8 Bright A_BFGSpray;
		BFE1 DEF 8 Bright;
		Stop;
	}
}

Extend Class Shin_BFG9000
{
	action void A_BFGsound() 
	{ 
		A_Overlay(2, "Charge");
		A_Overlay(3, "Glow");
		A_StartSound("weapons/bfgf", CHAN_WEAPON); 
	}
	
	Action void A_Bfgflash()
	{
		A_Overlay(2, "Gun.Flash");
	}
	
	Action Void A_FireBFG()
	{
		A_FireProjectile("Shin_BFGBall", 0, 1, 0, -8, 0, 0);
	}
}