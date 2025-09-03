
Class Shin_ShockTrooper : ShinDoom_Actor
{
	Default
	{
		Health 100;
		Speed 10;
		Radius 20;
		Height 56;
		ReactionTime 8;
		Monster;
		+FLOORCLIP
		PainSound "ShockTrooper/Pain";
		ActiveSound "ShockTrooper/Active";
		DeathSound "ShockTrooper/Death";
		Obituary "$OB_ID24PLASMAGUY";
		Tag "$FN_ID24PLASMAGUY";
	}
		
	States
	{
		spawn:
			PPOS AB 10 A_Look;
			loop;
		see:
			PPOS AABBCCDD 2 Fast A_Chase;
			loop;
		missile:
			PPOS E 10 A_Facetarget();
			PPOS F 2 bright Fast A_STrooperBlast();
			PPOS E 4 Fast;
			PPOS F 2 bright Fast A_STrooperBlast();
			PPOS E 4 Fast;
			PPOS F 2 bright Fast A_STrooperBlast();
			PPOS E 4 Fast;
			goto see;
		pain:
			PPOS G 5 Fast;
			PPOS G 5 Fast A_Pain;
			goto see;
		death:
			PPOS H 5 { A_SpawnItemEx("Shin_ShocktrooperHead", 0, 0, 40, 2.0 , 0, 1.5, 0 ,SXF_ABSOLUTEVELOCITY|SXF_ABSOLUTEPOSITION); A_FaceTarget(); }
			PPOS I 5 A_Scream;
			PPOS J 5 A_NoBlocking;
			PPOS KL 5;
			PPOS M -1;
			stop;
		xdeath:
			PPOS N 5;
			PPOS O 5 A_XScream;
			PPOS P 5 A_Fall;
			PPOS Q 5 { A_SpawnItemEx("Shin_ShocktrooperTorso", -8.0, 0, 32.0 , 4.0, 0 , 2.0 , 0, SXF_ABSOLUTEVELOCITY|SXF_ABSOLUTEPOSITION); A_FaceTarget(); }
			PPOS RST 5;
			PPOS U -1;
			stop;
		raise:
			PPSX FEDCBA 5;
			goto see;
	}
}

Class Shin_ShockTrooperHead : ShinDoom_Actor
{
	Default
	{
		Damage 0;
		Speed 8;
		Radius 6;
		Height 16;
		Projectile;
		Mass 5000;
		Gravity 0.125;
		-NOBLOCKMAP
		-NOGRAVITY		
		DeathSound "ShockTrooper/Head";
	}
	States
	{
		Spawn:
			PHED ABCDEFGHI 3;
			loop;
		Death:
			PHED J -1;
			loop;
	}
}

Class Shin_ShockTrooperTorso : ShinDoom_Actor
{
	Default
	{
		Damage 0;
		Speed 8;
		Radius 6;
		Height 16;
		Mass 5000;
		Projectile;
		-NOGRAVITY
		+NOBLOCKMAP
	}
	States
	{
		Spawn:
			PPOS V -1;
			loop;
		Death:
			PPOS W 5;
			PPOS X -1;
			stop;
	}
}

Extend Class Shin_ShockTrooper
{
	Void A_STrooperBlast()
	{
		A_SpawnProjectile("PlasmaBall", 28, 5);
		A_FaceTarget();
	}
}