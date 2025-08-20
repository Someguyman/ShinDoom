
Class Shin_Demonkey1 : CustomInventory 
{
Default
{
	+DONTGIB;
	Inventory.Amount 1;
	Inventory.MaxAmount 1;
	Inventory.InterHubAmount 1;
	Inventory.PickupMessage "";
	Inventory.PickupSound "Demonkey/Get";
}
	States
	{
	Spawn:
		DKEY O -1 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIfInventory("Shin_Orangekeyicon", 1, "Taken");
		TNT1 A 0 A_GiveInventory("Shin_Demonkeycount", 1);
		TNT1 A 0 A_GiveInventory("Shin_Orangekeyicon", 1);
		TNT1 A 0 A_Print("You have the feeling that it wasn't to be touched...");
		Stop;
	Taken:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_Orangekeyicon : Inventory
{
	Default
	{
	  +INVENTORY.UNDROPPABLE;
	}	
}

Class Shin_Demonkey2 : CustomInventory 
{
Default
{
	+DONTGIB;
	Inventory.Amount 1;
	Inventory.MaxAmount 1;
	Inventory.InterHubAmount 1;
	Inventory.PickupMessage "";
	Inventory.PickupSound "Demonkey/Get";
}
	States
	{
	Spawn:
		DKEY P -1 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIfInventory("Shin_Purplekeyicon", 1, "Taken");
		TNT1 A 0 A_GiveInventory("Shin_Demonkeycount", 1);
		TNT1 A 0 A_GiveInventory("Shin_Purplekeyicon", 1);
		TNT1 A 0 A_Print("Whatever it is, it doesn't belong in this world...");
		Stop;
	Taken:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_Purplekeyicon : Inventory
{
	Default
	{
	  +INVENTORY.UNDROPPABLE;
	}	
}

Class Shin_Demonkey3 : CustomInventory 
{
Default
{
	+DONTGIB;
	Inventory.Amount 1;
	Inventory.MaxAmount 1;
	Inventory.InterHubAmount 1;
	Inventory.PickupMessage "";
	Inventory.PickupSound "Demonkey/Get";
}
	States
	{
	Spawn:
		DKEY C -1 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIfInventory("Shin_Cyankeyicon", 1, "Taken");
		TNT1 A 0 A_GiveInventory("Shin_Demonkeycount", 1);
		TNT1 A 0 A_GiveInventory("Shin_Cyankeyicon", 1);
		TNT1 A 0 A_Print("It must do something...");
		Stop;
	Taken:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_Cyankeyicon : Inventory
{
	Default
	{
	  +INVENTORY.UNDROPPABLE;
	}	
}