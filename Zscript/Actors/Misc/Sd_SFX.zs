
Class Shin_TeleportFog : ShinDoom_Actor Replaces TeleportFog
{
	default
	{
		Scale 1.2;
		+NOBLOCKMAP
		+NOTELEPORT
		+NOGRAVITY
		+ZDOOMTRANS
		RenderStyle "Translucent";
	}
	
	override void PostBeginPlay ()
	{
		Super.PostBeginPlay ();
		A_StartSound ("misc/teleport", CHAN_BODY);
	}
	
	States
	{
		Spawn:
			TFOG A 4 Bright;
			TFOG B 4 Bright A_SpawnItemEx("Shin_TeleportFogEffect",0,0,0,0,0,0,0,128);
			TFOG CDEFGHIJIH 4 Bright;
			Stop;
	}
}

Class Shin_TeleportFogEffect : ShinDoom_Actor
{
	default
	{
		Scale 1.2;
		+NOBLOCKMAP
		+NOCLIP;
		+DROPOFF;
		+RANDOMIZE;
		+NOINTERACTION;
		+NOTELEPORT
		Damage 0;
		RenderStyle "Translucent";
		Alpha 0.67;
	}
	States
	{
		Spawn:
			TFOG ABCDEFGHIJIH 4 Bright;
			Stop;
	}
}

Class Shin_TeleportFogRed : Shin_TeleportFog
{
	States
	{
		Spawn:
			TFRD A 4 Bright;
			TFRD B 4 Bright A_SpawnItemEx("Shin_TeleportFogRedEffect",0,0,0,0,0,0,0,128);
			TFRD CDEFGHIJIH 4 Bright;
			Stop;
	}
}

Class Shin_TeleportFogRedEffect : Shin_TeleportFogEffect
{
	States
	{
		Spawn:
			TFRD ABCDEFGHIJIH 4 Bright;
			Stop;
	}
}

Class Shin_BossExplosion : ShinDoom_Actor
{
	Default
	{
		PROJECTILE;
		+RANDOMIZE;
		+ZDOOMTRANS
		+NOCLIP
		SeeSound "boss/explode";
		scale 0.8;
	}
	States
	{
	Spawn:
		MISL B 6 bright;
		MISL C 4 bright;
		MISL D 3 bright;
		Stop;
	}
}

Class Shin_ComicalExplosion : ShinDoom_actor
{
	Default
	{
		+RANDOMIZE
		projectile;
		SeeSound "Explosion/lol";
		DeathSound "Explosion/lol";
	}
	States
	{
		Spawn:
			Goto Death;
		Death:
			CEXP A 3 Bright;
			CEXP B 3 Bright A_Explode();
			CEXP CDEFGHI 3 Bright;
			Stop;
	}
}

class Shin_TameBulletPuff : BulletPuff
{
	Default
	{
		+NOEXTREMEDEATH
	}
}

class Shin_ExtremeBulletPuff : BulletPuff
{
	Default
	{
		+EXTREMEDEATH
	}
}

Class Shin_FlyingBlood : Blood
{
	Default
	{
		+MISSILE
		+BLOODLESSIMPACT
		+THRUACTORS
		+MOVEWITHSECTOR
		//+NOCLIP
		Speed 8;
		Radius 3;
		Height 3;
		gravity 0.5;
	}
	States
	{
		Spawn:
			BLUD CBA 8;
			Stop;
	}
}