
Class Shin_Chainsaw : ShinDoom_Weapon Replaces Chainsaw
{
	Default
	{
		Weapon.Kickback 0;
		Weapon.SelectionOrder 2200;
		Inventory.PickupSound "misc/w_pkup_Saw";
		Inventory.PickupMessage "$GOTCHAINSAW";
		Weapon.AmmoGive 80;
		Weapon.AmmoUse 1;
		Weapon.AmmoType "ID24Fuel";
		Obituary "$OB_MPCHAINSAW";
		Tag "$TAG_CHAINSAW";
		+WEAPON.MELEEWEAPON		
		+WEAPON.NOAUTOSWITCHTO
		+WEAPON.AMMO_OPTIONAL
	}
	
	States
	{
	Ready:
		SAWG C 0 A_JumpIfInventory("ID24Fuel",1,"Ready.Full");
	Ready.Nofuel:
		SAWG C 4 { A_WeaponReady(); A_Startsound("weapons/sawidlelow", CHAN_WEAPON, 0, 1, ATTN_NORM); }
		SAWG C 0 A_JumpIfInventory("ID24Fuel",1,"Ready.Full");
		SAWG D 4 A_WeaponReady;
		SAWG C 0 A_JumpIfInventory("ID24Fuel",1,"Ready.Full");
		SAWG E 4 A_WeaponReady;
		SAWG C 0 A_JumpIfInventory("ID24Fuel",1,"Ready.Full");
		SAWG F 4 A_WeaponReady;
		Goto Ready;
	Ready.Full:
		SAWG C 2 { A_WeaponReady(); A_Startsound("weapons/sawidle", CHAN_WEAPON, 0, 1, ATTN_NORM); }
		SAWG D 2 A_WeaponReady;
		SAWG E 2 A_WeaponReady;
		SAWG F 2 A_WeaponReady;
		Goto Ready;
	Deselect:
		SAWG C 0 A_StopSound(7);
		SAWG C 1 A_Lower;
		Loop;
	Select:
		SAWG C 0 A_JumpIfInventory("ID24Fuel",1,"Select.Full");
	Select.NoFuel:
		DBSW A 0 A_Startsound("weapons/sawuplow", CHAN_WEAPON);
		goto Select.Loop;
	Select.Full:
		DBSW A 0 A_Startsound("weapons/sawup", CHAN_WEAPON);
		goto Select.Loop;
	Select.Loop:
		SAWG C 1 A_Raise;
		Loop;
	Fire:
		TNT1 A 0 A_stopsound(CHAN_WEAPON);
		TNT1 A 0 A_startsound("weapons/sawfull", 7, CHANF_LOOPING);
	Hold:
		SAWG C 0 A_JumpIfInventory("ID24Fuel",1,"Hold.Standard");
	Hold.NoFuel:
		TNT1 A 0 A_StopSound(7);
		SAWG A 3 Offset(0,33) A_Saw("weapons/sawfulllow","weapons/sawhitlow",2);
		SAWG B 3 Offset(0,32);
		SAWG C 2 A_ReFire("Hold");
		Goto Ready;
	Hold.Standard:
		SAWG A 1 offset(0,36) A_Saw("","weapons/sawhit",3,"Shin_SawPuff");
		SAWG A 1 offset(-1,34);
		SAWG B 1 offset(0,35);
		SAWG B 1 offset(1,33);
		SAWG A 1 offset(0,36) A_Saw("","weapons/sawhit",3,"Shin_SawPuff");
		SAWG A 1 offset(-1,34);
		SAWG B 1 offset(0,37);
		SAWG B 1 offset(1,34);
		SAWG C 2 A_ReFire("Hold");
		TNT1 A 0 A_StopSound(7);
    	Goto Ready;
	
	Spawn:
		CSAW A -1;
		Stop;
	}
}
	
class Shin_SawPuff : Shin_ExtremeBulletPuff
{
	Default
	{
		DamageType "Cutting";
		//+EXTREMEDEATH
	}
}