
Class Shin_BloodyMeatyEdibles : CustomInventory Replaces Gibs
{
	Default
	{
		Radius 20;
		Height 4;
		+MOVEWITHSECTOR
		-COUNTITEM
		Inventory.PickupMessage "Drank Blood From Floor";
		Inventory.PickupSound "gore/drink";
	}
	States
	{
		Spawn:
			POL5 A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_JumpIf(health > 11, "PickupFail");
			TNT1 A 0 A_GiveInventory("health", 1);
			stop;
		PickupFail:
			TNT1 A 0;
			Fail;
	}
}

Class Shin_ColonGibs_Edibles : Shin_BloodyMeatyEdibles Replaces ColonGibs
{
	States
	{
		Spawn:
			POB1 A -1;
			Stop;
	}
}

Class Shin_SmallBloodPool_Edibles : Shin_BloodyMeatyEdibles Replaces SmallBloodPool
{
	States
	{
		Spawn:
			POB2 A -1;
			Stop;
	}
}

Class Shin_BrainStem_Edibles : Shin_BloodyMeatyEdibles Replaces BrainStem
{
	States
	{
		Spawn:
			BRS1 A -1;
			Stop;
	}
}
