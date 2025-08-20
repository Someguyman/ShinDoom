
Class Shin_PlasmaRifle : ShinDoom_Weapon Replaces PlasmaRifle
{
	Default
	{
		Weapon.SelectionOrder 100;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Cell";
		Inventory.PickupMessage "$GOTPLASMA";
		Weapon.UpSound "weaponUP/Plasmarifle";
		Inventory.PickupSound "misc/w_pkup_Plasmarifle";
		Tag "$TAG_PLASMARIFLE";
	}
	
		Action Void A_FirePlasma() 
		{
			if (CountInv("Shin_PowerQuadDamage") == 1)
			{
				A_GunFlash("Flash.Onslaught"); 
				A_FireProjectile("Shin_PlasmaBall2",0,1,0);
			}
			else
			{
				A_GunFlash("Flash"); 
				A_FireProjectile("Shin_PlasmaBall",0,1,0);
			}
			invoker.mp_clip++;
		}
	
	States
	{
	Ready:
		PLSG A 1 A_WeaponReady();
		Loop;
	Deselect:
		PLSG A 1 A_Lower;
		Loop;
	Select:
		PLSG A 1 A_Raise;
		Loop;
	Fire:
		TNT1 A 3 A_FirePlasma();
		PLSG A 0 A_ReFire;
		TNT1 A 0 A_JumpIf(invoker.mp_clip > 3, "Cooldown");
		TNT1 A 0 { invoker.mp_clip = 0; }
		PLSG AAA 1 Offset(0,32) A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	Cooldown:
		PLSG B 16 Offset(0,32) A_GunFlash("Flash.Stop");
		PLSG B 3 Offset(6,38);
		TNT1 A 0 Offset(1,36) A_WeaponOffset(0,36,WOF_INTERPOLATE);
		PLSG A 1 Offset(1,36) { A_WeaponOffset(0,36,WOF_INTERPOLATE); invoker.mp_clip = 0; }
		PLSG AAAAAA 1 Offset(0,32) A_WeaponReady(WRF_NOBOB);
		Goto Ready;
	Flash:
		PLSF A 1 Bright A_Light1;
		PLSF B 1 Bright A_Light1;
		PLSF A 1 Bright A_Light1;
		PLGN D 1 Bright A_Light1;
		Goto LightDone;
	Flash.Onslaught:
		PLSF C 1 Offset(0,32) Bright A_Light1;
		PLSF D 1 Offset(0,32) Bright A_Light1;
		PLSF C 1 Offset(0,32) Bright A_Light1;
		PLGN D 1 Offset(0,32) Bright A_Light1;
		Goto LightDone;
	Flash.Stop:
		Goto LightDone;
	Spawn:
		PLAS A -1;
		Stop;
	}
}

Class Shin_PlasmaBall : ShinDoom_Actor
{
	Default
	{
		Radius 13;
		Height 8;
		Speed 30;
		Damage 5;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		SeeSound "weapons/plasmaf";
		DeathSound "weapons/plasmax";
		Obituary "$OB_MPPLASMARIFLE";
	}
	States
	{
	Spawn:
		PLSS AB 6 Bright;
		Loop;
	Death:
		PLSE ABCDE 4 Bright;
		Stop;
	}
}