//

Class Shin_WeaponSlot4Spawner : Inventory
{
	override void PostBeginPlay() 
    {
        super.PostBeginPlay();
        let p = players[consoleplayer].mo;
	}
	
	Void A_SpawnWeapon(Class<Actor> spawntype)
	{
		A_SpawnItemEx(spawntype,0,0,-99999999,0,0,0,0,SXF_TRANSFERPOINTERS|SXF_TRANSFERAMBUSHFLAG|SXF_TRANSFERSPECIAL|SXF_NOCHECKPOSITION, 0, tid);
	}
	
	Default
	{
		+Inventory.QUIET;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_JumpIf(players[consoleplayer].mo.countinv("Shin_Chaingun") == 1, "SpawnSet3");
			TNT1 A 0 A_JumpIf(players[consoleplayer].mo.countinv("Shin_MachinePistol") == 1, "SpawnSet2B");
			TNT1 A 0 A_JumpIf(players[consoleplayer].mo.countinv("Shin_CombatRifle") == 1, "SpawnSet2A");
			Goto SpawnSet1;
			
		Spawn.Chaingun:
			TNT1 A 0 A_SpawnWeapon("Shin_Chaingun");
			Stop;
		Spawn.Rifle:
			TNT1 A 0 A_SpawnWeapon("Shin_Combatrifle");
			Stop;
		Spawn.SMG:
			TNT1 A 0 A_SpawnWeapon("Shin_MachinePistol");
			Stop;

		SpawnSet1:
			TNT1 A 0;
			TNT1 A 0 A_Jump(70, "Spawn.SMG");
			TNT1 A 0 A_Jump(2, "Spawn.Chaingun");
			Goto Spawn.Rifle;
		SpawnSet2A:
			TNT1 A 0 A_JumpIf(players[consoleplayer].mo.countinv("Shin_MachinePistol") == 1, "SpawnSet3");
			TNT1 A 0 A_Jump(100, "Spawn.Rifle");
			TNT1 A 0 A_Jump(30, "Spawn.Chaingun");
			Goto Spawn.SMG;
		SpawnSet2B:
			TNT1 A 0 A_JumpIf(players[consoleplayer].mo.countinv("Shin_CombatRifle") == 1, "SpawnSet3");
			TNT1 A 0 A_Jump(100, "Spawn.SMG");
			TNT1 A 0 A_Jump(30, "Spawn.Chaingun");
			Goto Spawn.Rifle;			
		SpawnSet3:
			TNT1 A 0 A_Jump(128, "Spawn.SMG");
			TNT1 A 0 A_Jump(70, "Spawn.Chaingun");
			Goto Spawn.Rifle;
	}
}