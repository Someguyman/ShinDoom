
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
		Alpha 0.61;
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
		damagetype "lol";
		SeeSound "Explosion/lol";
		DeathSound "Explosion/lol";
	}
	States
	{
		Spawn:
			Goto Death;
		Death:
			CEXP A 1 Bright;
			CEXP A 2 Bright;
			CEXP B 3 Bright A_Explode(-1, -1.0, XF_HURTSOURCE, true, 0.0, 0, 10, "BulletPuff", "lol");
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
		Bouncetype "Doom";
		BounceCount 1;
		Speed 8;
		Radius 3;
		Height 3;
		gravity 1.2;
	}
	States
	{
		Spawn:
			TNT1 A 0 ThrustThingZ (0, random(16,29), 0, 1);
			BLUD CBA 8;
			Stop;
	}
}

Class Shin_DeathFire : ShinDoom_Actor
{
	Default
	{
		+THRUACTORS
		+MOVEWITHSECTOR
		+NOBLOCKMAP
		+NOCLIP
		+DROPOFF
		+RANDOMIZE
		+NOINTERACTION
		+NOTELEPORT
		+ZDOOMTRANS
		Damage 0;
		scale 1.2;
	}
	States
	{
		spawn:
			DTHF C 1 bright;
			DTHF C 3 bright A_DeathFireExp();
			DTHF D 4 bright;
			DTHF E 4 bright;
		spawn.loop:	
			DTHF F 4 bright A_DeathBurn(); //1
			DTHF G 4 bright;
			DTHF H 4 bright;
			DTHF H 0 bright A_DeathRepeat();
			Loop;
		Death:			
			DTHF F 4 bright A_DeathBurn(); //8			
			DTHF J 4 bright;
			DTHF K 4 bright;
			DTHF L 4 bright;
			DTHF MNOPQ 4 bright;
			stop;
	}
}

Class Shin_DeathFire_Large : Shin_DeathFire
{
	Default
	{
		scale 1.4;
	}
}

Class Shin_DeathFire_Extra_Large : Shin_DeathFire
{
	Default
	{
		scale 2.0;
	}
}

Class Shin_DeathFire_Small : Shin_DeathFire
{
	Default
	{
		scale 0.8;
	}
}

extend class Shin_DeathFire
{
	int i;
	
	Void A_DeathFireExp()
	{
		A_StartSound("Vassago/fire");
		i = 1;
	}
	
	Void A_DeathBurn()
	{
		A_StartSound("Vassago/fire");
	}
	
	Void A_DeathRepeat()
	{
		if (i == 0) SetStateLabel("Death");
        i--;
	}
}