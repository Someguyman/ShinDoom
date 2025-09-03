
Class Shin_InvulnerabilitySpherePickUp : CustomInventory Replaces InvulnerabilitySphere
{
	Default
	{
		+CASTSPRITESHADOW
		+FLOATBOB
		+ZDOOMTRANS
		+INVENTORY.BIGPOWERUP
		Inventory.PickupSound "misc/p_pkup_v";
		Inventory.PickupMessage "\cfInvulnerability!";
		//Powerup.Colormap 0.243, 0.0, 0.639, 1.5, 0.75, 0.0;
		RenderStyle "Translucent";
		Alpha 0.8;
	}
	States
	{
		Spawn:
			PINV ABCDCB 6 Bright;
			Loop;
		Pickup:
			TNT1 A 0 A_JumpIf(CountInv("Shin_InvulnerabilityTimer") > 0, "PickupFail");
			TNT1 A 0 A_GiveInventory("Shin_InvulnerabilitySphere", 1);
			TNT1 A 0 A_GiveInventory("Shin_InvulnerabilityTimer", 1);
			Stop;
		PickupFail:
			TNT1 A 0;
			Fail;
	}
}

Class Shin_InvulnerabilitySphere : PowerupGiver
{
	Default
	{
		+CASTSPRITESHADOW
		+FLOATBOB
		+ZDOOMTRANS
		+INVENTORY.AUTOACTIVATE
		+INVENTORY.ALWAYSPICKUP
		+INVENTORY.BIGPOWERUP
		Inventory.MaxAmount 0;
		Inventory.PickupSound "misc/p_pkup_v";
		Inventory.PickupMessage "\cfInvulnerability!";
		Powerup.Colormap 0.243, 0.0, 0.639, 1.5, 0.75, 0.0;
		RenderStyle "Translucent";
		Alpha 0.8;
		Powerup.Type "PowerInvulnerable";
		Inventory.PickupMessage "$GOTINVUL";
	}
	States
	{
		Spawn:
			PINV ABCDCB 6 Bright;
			Loop;
	}
}

Class Shin_InvulnerabilityTimer: Powerup
{
	Default
	{
	Powerup.Duration -25;
	}
}

Class Shin_PowerQuadDamage : PowerDamage
{
	Default
	{
		Damagefactor "normal", 4;
		Powerup.Duration -30;
		Powerup.Color "D8 83 ff", 0.5;
	}
}

Class Shin_Onslaught : CustomInventory
{
	Default
	{
		-COUNTITEM
		+FLOATBOB
		+ZDOOMTRANS
		+INVENTORY.AUTOACTIVATE
		+INVENTORY.ALWAYSPICKUP
		+INVENTORY.BIGPOWERUP
		+CASTSPRITESHADOW
		Inventory.MaxAmount 0;
		Inventory.PickupMessage "\ctOnslaught!";
		Inventory.PickupSound "misc/p_pkup_q";
		RenderStyle "Translucent";
		Alpha 0.8;
	}
	States
	{
	Spawn:
		PWR2 ABCD 6 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_GiveInventory("Shin_Powerquaddamage");
		TNT1 A 0 A_GiveInventory("BlueArmorForMegasphere", 1);
		TNT1 A 0 A_GiveInventory("MegasphereHealth", 1);
		Stop;
	}
}

Class Shin_OnslaughtPickup : CustomInventory
{
	Default
	{
		-COUNTITEM
		+FLOATBOB
		+ZDOOMTRANS
		+CASTSPRITESHADOW
		Inventory.PickupMessage "\ctOnslaught!";
		Inventory.PickupSound "misc/p_pkup_q";
		RenderStyle "Translucent";
		Alpha 0.8;
	}
	States
	{
	Spawn:
		PWR2 ABCD 6 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIf(CountInv("Shin_OnslaughtTimer") > 0, "PickupFail");
		goto PickupSuccess;
	PickupSuccess:
		TNT1 A 0 A_GiveInventory("Shin_OnslaughtTimer", 1);
		TNT1 A 0 A_GiveInventory("Shin_Onslaught");
		Stop;
	PickupFail:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_OnslaughtTimer: Powerup
{
	Default
	{
		Powerup.Duration -25;
	}
}	

Class Shin_Soulsphere : CustomInventory Replaces Soulsphere
{
	Default
	{
		Tag "Soulsphere";
		+CASTSPRITESHADOW
		+FLOATBOB
		+ZDOOMTRANS
		-COUNTITEM
		RenderStyle "Translucent";
		Inventory.PickupMessage "\cnSoulsphere!";
		Inventory.PickupSound "misc/p_pkup";
		Alpha 0.8;
	}
	States
	{
	Spawn:
		SOUL ABCDCB 6 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIf(health >= 200, "PickupFail");
		TNT1 A 0 A_GiveInventory("Shin_Soulspherehealth", 1);
		stop;
	PickupFail:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_Soulspherehealth : Health 
{
	Default
	{
		Inventory.Amount 100;
		Inventory.MaxAmount 200;
	}
}

Class Shin_Megasphere : CustomInventory Replaces Megasphere
{
	Default
	{
		+CASTSPRITESHADOW
		+FLOATBOB
		+ZDOOMTRANS
		-COUNTITEM
		RenderStyle "Translucent";
		Inventory.PickupMessage "\cfMegasphere!";
		Inventory.PickupSound "misc/p_pkup_m";
		Alpha 0.8;
	}
	States
	{
	Spawn:
		MEGA ABCDB 6 BRIGHT;
		Loop;
	ArmorCheck:
		TNT1 A 0 A_JumpIfInventory("BasicArmor", 200, "PickupFail");
		Goto PickupSuccess;
	Pickup:
		TNT1 A 0 A_JumpIf(health >= 200, "ArmorCheck");
		goto PickupSuccess;
	PickupSuccess:
		TNT1 A 0 A_GiveInventory("BlueArmorForMegasphere", 1);
		TNT1 A 0 A_GiveInventory("MegasphereHealth", 1);
		Stop;
	PickupFail:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_Supersphere : Shin_Megasphere
{
	Default
	{
		Inventory.PickupMessage "\coSupersphere!";
	}
	States
	{
	Spawn:
		SUPS ABCD 6 BRIGHT;
		Loop;
	ArmorCheck:
		TNT1 A 0 A_JumpIfInventory("BasicArmor", 200, "PickupFail");
		Goto PickupSuccess;
	Pickup:
		TNT1 A 0 A_JumpIf(health >= 200, "ArmorCheck");
		goto PickupSuccess;
	PickupSuccess:
		TNT1 A 0 A_GiveInventory("Shin_SupersphereHealth", 1);
		TNT1 A 0 A_GiveInventory("Shin_BlueArmorForSupersphere", 1);
		Stop;
	PickupFail:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_SupersphereHealth : Health
{
	Default
	{
		Inventory.Amount 100;
		Inventory.MaxAmount 200;
		+INVENTORY.ALWAYSPICKUP
	}
}

Class Shin_BlueArmorForSupersphere : BasicArmorBonus
{
	Default
	{
		Armor.SavePercent 50;
		Armor.Saveamount 100;
		Armor.Maxsaveamount 200;
		+INVENTORY.ALWAYSPICKUP
	}
}

Class Shin_Berserk : Custominventory Replaces Berserk
{
	Default
	{
		+CASTSPRITESHADOW
		+ZDOOMTRANS
		Tag "Berserk";
		Inventory.PickupSound "misc/p_pkup_s";
		Inventory.PickupMessage "\cgBerserk!";
		Alpha 0.8;
		-COUNTITEM
	}
	States
	{
	Spawn:
		PSTR A -1 Bright;
		Loop;
	Healthcheck:
		TNT1 A 0 A_JumpIf(CountInv("PowerStrength") > 0, "PickupFail");
		Goto PickupSuccess;
	Pickup:
		TNT1 A 0 A_JumpIf(health >= 100, "Healthcheck");
		Goto PickupSuccess;
	PickupSuccess:
		TNT1 A 0 A_GiveInventory("PowerStrength");
		TNT1 A 0 HealThing(100, 0);
		TNT1 A 0 A_SelectWeapon("Fist");
		stop;
	PickupFail:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_BlurSphere : BlurSphere
{
	Default
	{
		Powerup.Type "PowerInvisibility";
	}
}

Class Shin_BlurSpherePickup : Custominventory Replaces BlurSphere
{
	Default
	{
		+CASTSPRITESHADOW
		+FLOATBOB
		+ZDOOMTRANS
		-VISIBILITYPULSE
		-COUNTITEM
		RenderStyle "Translucent";
		Inventory.PickupMessage "\cxPartial Invisibility!";
		Inventory.PickupSound "misc/p_pkup_i";
		Alpha 0.8;
	}
	States
	{
		Spawn:
			PINS ABCDCB 6 Bright;
			Loop;
		Pickup:
			TNT1 A 0 A_JumpIf(CountInv("Shin_BlurSphereTimer") > 0, "PickupFail");
			TNT1 A 0 A_GiveInventory("Shin_BlurSphere", 1);
			TNT1 A 0 A_GiveInventory("Shin_BlurSphereTimer", 1);
			Stop;
		PickupFail:
			TNT1 A 0;
			Fail;
	}
}

Class Shin_BlurSphereTimer : Powerup
{
	Default
	{
		Powerup.Duration -55;
	}
}

Class Shin_Lightamp : Custominventory Replaces Infrared
{
	Default
	{
		-COUNTITEM
		+CASTSPRITESHADOW
		Inventory.PickupSound "misc/p_pkup_l";
		Inventory.PickupMessage "\cqLight Amplification";
	}
	States
	{
		Spawn:
			PVIS C 6;
			PVIS B 3 Bright;
			PVIS A 6 Bright;
			PVIS B 3;
			PVIS C 6;
			Loop;
		Pickup:
			TNT1 A 0 A_JumpIf(CountInv("Shin_LightampTimer") > 0, "PickupFail");
			TNT1 A 0 A_GiveInventory("Infrared", 1);
			TNT1 A 0 A_GiveInventory("Shin_LightampTimer", 1);
			Stop;
		PickupFail:
			TNT1 A 0;
			Fail;
	}
}

Class Shin_LightampTimer : Powerup
{
	Default
	{
		Powerup.Duration -115;
	}
}

Class Shin_Computerareamap : CustomInventory replaces Allmap
{
	Default
	{
		+CASTSPRITESHADOW
		-COUNTITEM
		Inventory.PickupSound "misc/p_pkup_a";
		Inventory.PickupMessage "\cdComputer Area Map";
	}
	States
	{
	Spawn:
		ATOM ABCDCB 6 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIf(CountInv("Shin_Allmapchecker") > 0, "PickupFail");
		TNT1 A 0 A_GiveInventory("Allmap", 1);
		TNT1 A 0 A_GiveInventory("Shin_Allmapchecker", 1);	
		Stop;
	PickupFail:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_Allmapchecker: Powerup
{
	Default
	{
		Powerup.Duration 0x7FFFFFFF;
	}
}

Class Shin_RadSuit : Custominventory Replaces Radsuit
{
	Default
	{
		+CASTSPRITESHADOW
		Inventory.PickupSound "misc/p_pkup_r";
		Inventory.PickupMessage "\cpRadiation Protection";
		+ZDOOMTRANS
	}
	States
	{
	Spawn:
		SUIT A -1 Bright;
		Loop;
	Pickup:
		TNT1 A 0 A_JumpIf(CountInv("Shin_RadsuitTimer") > 0, "PickupFail");
		TNT1 A 0 A_GiveInventory("Radsuit", 1);
		TNT1 A 0 A_GiveInventory("Shin_RadsuitTimer", 1);
		Stop;
	PickupFail:
		TNT1 A 0;
		Fail;
	}
}

Class Shin_RadsuitTimer : Powerup
{
	Default
	{
		Powerup.Duration -55;
	}
}