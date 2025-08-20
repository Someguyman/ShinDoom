
Class Shin_ExplosiveBarrel : ShinDoom_Actor Replaces ExplosiveBarrel
{
	Default
	{	
		Health 20;
		Radius 10;
		Height 42;
		+SOLID
		+SHOOTABLE
		+NOBLOOD
		+ACTIVATEMCROSS
		+DONTGIB
		+NOICEDEATH
		+OLDRADIUSDMG
		+NOBLOODDECALS
		DamageType "Barrelexplosion";
		DeathSound "world/barrelx";
		Obituary "$OB_BARREL";
	}
	States
	{
	Spawn:
		BAR1 AB 6;
		Loop;
	Death:
		//BEXP A 3 BRIGHT;
		BEXP B 5 BRIGHT;
		BEXP C 5 BRIGHT;
		BEXP D 8 BRIGHT { A_Scream(); A_Explode(); }
		BEXP E 7 BRIGHT; 
		BEXP F 6 BRIGHT;
		TNT1 A 1050 BRIGHT A_BarrelDestroy;
		TNT1 A 5 A_Respawn;
		Wait;
	}
}