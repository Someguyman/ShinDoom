
Class Shin_GrenadeLauncher : ShinDoom_Weapon
{
	Default
	{
		Weapon.SelectionOrder 400;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 2;
		Weapon.AmmoType "RocketAmmo";
		+WEAPON.NOAUTOFIRE
		Inventory.PickupMessage "$GOTGRENADE";
		Obituary "%o was blown up by %k's Grenade Launcher.";
		Tag "$TAG_ROCKETLAUNCHER";
	}
	States
	{
	Ready:
		RGLG A 1 A_WeaponReady;
		Loop;
	Select:
		RGLG A 1 A_Raise;
		Loop;
	Deselect:
		RGLG A 1 A_Lower;
		Loop;
	Fire:
		RGLF A 2 Bright;
		RGLF A 0 A_GunFlash;
		RGLF A 0 A_StartSound("weapons/GrenadeFire", CHAN_WEAPON);
		RGLF B 2 Bright A_FireSTGrenade("Shin_40mmShot");
		RGLF C 2 Bright;
		RGLF D 2 Bright;
		RGLG BCD 3;
		RGLG A 15;
		RGLG A 5 A_ReFire;
		Goto Ready;
	AltFire:
		RGLF A 2 Bright;
		RGLF A 0 A_GunFlash; 
		RGLF A 0 A_StartSound("weapons/GrenadeFire", CHAN_WEAPON);
		RGLF B 2 Bright A_FireSTGrenade("Shin_40mmTimedShot"); 
		RGLF C 2 Bright; 
		RGLF D 2 Bright; 
		RGLG BCD 3;
		RGLG A 15; 
		RGLG A 5 A_ReFire;
		Goto Ready;
	Flash:
		TNT1 A 1 BRIGHT A_Light1;
		TNT1 B 2 BRIGHT A_Light2;
		Goto LightDone;
	Spawn:
		GLMM A -1;
		Stop;
	}
}

Class Shin_40mmShot : ShinDoom_Actor
{
	Default
	{
		Radius 8;
		Height 8;
		Damage 25;
		Speed 50;
		SeeSound "";
		Deathsound "Weapons/RockLX";
		BounceSound "Weapons/GrenadeBounce";
		BounceFactor 0.5;
		BounceCount 4;
		ReactionTime 139;
		ProjectileKickback 100;
		Projectile;
		+DEHEXPLOSION
		BounceType "Doom";
		-NOTELEPORT
		+FOILINVUL
		+EXPLODEONWATER
		-NOGRAVITY
	}
	States
	{
		Spawn:
			SHRP O 0 BRIGHT A_CountDown();
			SHRP O 3 bright;
			Loop;
		Death:
			MISL B 8 Bright { A_NoGravity(); A_Explode(); }
			MISL C 6 Bright;
			MISL D 4 Bright;
			Stop;
	}
}

Class Shin_40mmTimedShot : Shin_40mmShot
{
	Default
	{
		BounceFactor 0.5;
		BounceCount 0;
		ReactionTime 25;
		Speed 30;
		Damage 1;
		ProjectileKickback 0;
		BounceType "Hexen";
		+BOUNCEONACTORS
		+EXTREMEDEATH
		+CANBOUNCEWATER
	}
	States
	{
		Death:
			MISL B 8 Bright { A_NoGravity(); A_Explode(); }
			MISL C 6 Bright;
			MISL D 4 Bright;
			Stop;
	}
}