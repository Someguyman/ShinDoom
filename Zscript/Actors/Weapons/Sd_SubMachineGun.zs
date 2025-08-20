
Class Shin_MachinePistol : ShinDoom_Weapon Replaces Chaingun
{
	Default
	{
	   Weapon.SelectionOrder 700;
	   Weapon.AmmoUse 1;
	   Weapon.AmmoGive 25;
	   Weapon.AmmoType "Shin_LightAmmo";
	   Inventory.PickupMessage "$GOTSMG";
	   Obituary "%o was mowed down by %k's Sub Machine Gun.";
	   Tag "Sub Machine Gun";
	}
	
	States
	{
	Ready:
		SMGG A 1 A_ReloadReady(40);
		Loop;
	Deselect:
		SMGG A 1 A_Lower;
		Loop;
	Select:
		SMGG A 1 A_Raise;
		Loop; 
	Fire:
		SMGG A 0 A_JumpIf(invoker.mp_clip >= 40,"Reload");		
		SMGG A 2;
		SMGG B 2 A_StartSound("weapons/click",CHAN_WEAPON,CHANF_DEFAULT,0.25);
		SMGG B 0 A_ReFire;
	Hold:
		SMGG A 0 A_JumpIf(invoker.mp_clip >= 40,"Reload");
		SMGG A 2 A_FirePistol;
		SMGG B 2 { invoker.mp_clip++; }
		SMGG B 0 A_ReFire;
		Goto Ready; 
	AltFire:
	Reload:
		SMGG C 0 { If(invoker.mp_clip == 0){ SetWeaponState("Ready"); } }
		SMGG F 2;
		SMGG C 3 A_StartSound("weapons/smgo",CHAN_AUTO);
		SMGG D 8;
		SMGG C 3 A_StartSound("weapons/smgl",CHAN_AUTO);
		SMGG E 2 { invoker.mp_clip = 0; }
		SMGG F 4;
		Goto Ready;
	Flash:
		SMGF A 2 Bright A_Light1;
		SMGF B 2 Bright A_Light2;
		Goto LightDone;
	Spawn:
		PIST B -1;
		Stop;
	}
}