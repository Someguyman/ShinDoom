
Class Shin_ShockTrooper : ShinDoom_Actor Replaces deh_actor_153
{
	Default
	{
		Health 100;
		Speed 10;
		Radius 20;
		Height 56;
		ReactionTime 8;
		Painchance 30;
		Monster;
		+FLOORCLIP
		PainSound "ShockTrooper/Pain";
		ActiveSound "ShockTrooper/Active";
		DeathSound "ShockTrooper/Death";
		Obituary "$OB_ID24PLASMAGUY";
		Tag "$FN_ID24PLASMAGUY";
		Translation "Shocktrooper";
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
			PPOS H 6 { A_SpawnItemEx("Shin_ShocktrooperHead", 0, 0, 40, 2.0 , 0, 1.5, 0 ,SXF_ABSOLUTEVELOCITY|SXF_ABSOLUTEPOSITION|SXF_TRANSFERTRANSLATION ); A_FaceTarget(); }
			PPOS I 6 A_Scream;
			PPOS J 6 A_NoBlocking;
			PPOS KL 6;
			PPOS M -1 A_NormalDeath();
			stop;
		xdeath:
			PPOS N 5;      
			PPOS O 5 A_XScream;
			PPOS P 5 A_Fall;
			PPOS P 0 A_ScaleVelocity(0.5); 
			PPOS Q 5 nodelay { A_SpawnItemEx("Shin_ShocktrooperTorso", xofs: -8.0, 0, 32.0 , 4.0, 0 , 2.0 , 0, SXF_ABSOLUTEVELOCITY|SXF_ABSOLUTEPOSITION|SXF_TRANSFERTRANSLATION ); A_FaceTarget(); }
			PPOS RST 5;
			PPOS U -1 A_NormalDeath();
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
		Translation "116:127=[151,168,128]:[17,20,14]";
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

Class Shin_ZapRookie : Shin_Shocktrooper
{
	Default
	{
		Health 50;
		Speed 8;
		Translation "ZapRookie";
	}
	States
	{
		See:
			PPOS AABBCCDD 2 Fast A_Chase;
			loop;
		missile:
			PPOS E 10 A_Facetarget();
			PPOS F 2 bright Fast A_STrooperBlast("Shin_GhoulBall");
			PPOS E 6 Fast;
			PPOS F 2 bright Fast A_STrooperBlast("Shin_GhoulBall");
			PPOS E 6 Fast;
			PPOS F 2 bright Fast A_STrooperBlast("Shin_GhoulBall");
			PPOS E 6 Fast;
			goto see;
	}
}

Extend Class Shin_ShockTrooper
{	
	Void A_STrooperBlast(Class<Actor> spawntype = "PlasmaBall")
	{
		A_SpawnProjectile(spawntype, 28, 5);
		A_FaceTarget();
	}
}