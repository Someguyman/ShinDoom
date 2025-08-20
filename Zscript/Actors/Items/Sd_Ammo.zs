//
Class Shin_LightAmmo : Ammo replaces Clip
{
	Default
	{
		Inventory.Amount 10;
		Inventory.MaxAmount 100;
		Ammo.BackpackAmount 10;
		Ammo.BackpackMaxAmount 200;
		Inventory.PickupMessage "Picked up a 10 caliber magazine";
		Inventory.Icon "MAGSA0";
		Tag "10 caliber Light Magazine";
	}
	States
	{
		Spawn:
			MAGS A -1;
			Stop;
	}
}

Class Shin_40CalLightAmmo : Shin_LightAmmo Replaces ClipBox
{
	Default
	{
		Inventory.PickupMessage "Picked up a 40 caliber magazine";
		Inventory.Amount 40;
		Tag "40 caliber Light Magazine";
	}
	States
	{
		Spawn:
			MAGL A -1;
			Stop;
	}
}

Class Shin_HeavyAmmo : ammo
{
	Default
	{
		Inventory.PickupMessage "$GOTCLIP";
		Inventory.Amount 8;
		Inventory.MaxAmount 200;
		Ammo.BackpackAmount 8;
		Ammo.BackpackMaxAmount 400;
		Inventory.Icon "CLIPA0";
		Tag "Heavy Ammo Clip";
	}
	States
	{
		Spawn:
			CLIP A -1;
			Stop;
	}
}

Class Shin_HeavyAmmoBox : Shin_HeavyAmmo //Replaces ClipBox
{
	Default
	{
		Inventory.PickupMessage "$GOTCLIP";
		Inventory.Amount 100;
		Inventory.Icon "CLIPA0";
		Tag "Heavy Ammo Box";
	}
	States
	{
		Spawn:
			AMMO A -1;
			Stop;
	}
}

Class Shin_Cell : Cell replaces Cell
{
	Default
	{
		//Inventory.PickupSound "Ammo/CellSup";
		Inventory.Icon "CELLA0";
		//Inventory.PickupMessage "\coPicked up an energy cell";
	}
	States
	{
	Spawn:
		CELL BCDC 7;
		Loop;
	}
}

Class Shin_CellPack : CellPack Replaces Cellpack
{
	Default
	{
		//Inventory.PickupSound "Ammo/CellLup";
		//Inventory.PickupMessage "\coPicked up an energy cell pack!";
	}
	States
	{
	Spawn:
		CELP ABCD 7; 
		Loop;
	}
}

Class Shin_Backpack : BackpackItem Replaces BackpackItem
{
	Default
	{
		Height 26;
		Inventory.PickupMessage "$GOTBACKPACK";
	}
	States
	{
		Spawn:
			BPAK A -1;
			Stop;
	}
}

Class Shin_CombatBackpack : CustomInventory
{
	Default
	{
		Height 26;
		+Inventory.AlwaysPickup
		Inventory.PickupMessage "You got a combat pack";
		Inventory.PickupSound "misc/i_pkup";
	}
	States
	{
		Spawn:
			CBPK A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_GiveInventory("Backpack", 1);
			TNT1 A 0 A_GiveInventory("Shell", 16);
			TNT1 A 0 A_GiveInventory("Clip", 40);
			TNT1 A 0 A_GiveInventory("RocketAmmo", 4);
			TNT1 A 0 A_GiveInventory("Cell", 60);
			Stop;
	}
}