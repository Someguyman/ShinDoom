//
Class Shin_LightAmmo : Ammo replaces Clip
{
	Default
	{
		Inventory.Amount 10;
		Inventory.MaxAmount 200;
		Ammo.BackpackAmount 10;
		Ammo.BackpackMaxAmount 400;
		Inventory.PickupMessage "Picked up Light Ammo Mag";
		Inventory.Icon "MAGSA0";
		Tag "Light Ammo Magazine";
	}
	States
	{
		Spawn:
			MAGS A -1;
			Stop;
	}
}

Class Shin_LightAmmoStick : Shin_LightAmmo Replaces ClipBox
{
	Default
	{
		Inventory.PickupMessage "Picked up Light Ammo Stick Mag";
		Inventory.Amount 40;
		Tag "Light Ammo Stick Mag";
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
		Inventory.PickupMessage "Picked up a Heavy Ammo Clip";
		Inventory.Amount 10;
		Inventory.MaxAmount 150;
		Ammo.BackpackAmount 8;
		Ammo.BackpackMaxAmount 300;
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
		Inventory.PickupMessage "Picked up a Heavy Ammo Box";
		Inventory.Amount 50;
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

Class Shin_SoulEnergy : Ammo
{
	Default
	{
		Inventory.Amount 5;
		Inventory.MaxAmount 100;
	}
	States
	{
		Spawn:
			CELP A -1; 
			Stop;
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