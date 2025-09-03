
Class Shin_Ghoul : ShinDoom_Actor
{
	Default
	{
		Health 50;
		Radius 16;
		Height 40;
		Speed 12;
		PainChance 128;
		Mass 50;
		Monster;
		+FLOAT
		+NOGRAVITY
		FloatBobStrength 0.5;
		FloatBobFactor 0.8;
		BloodColor "30 67 23";
		SeeSound "Ghoul/Sight";
		PainSound "Ghoul/pain";
		DeathSound "Ghoul/death";
		ActiveSound "Ghoul/active";
		Obituary "$OB_ID24GHOUL";
		Tag "$FN_ID24GHOUL";
	}
	States
	{
		spawn:
			GHUL AB 10 { A_Look(); bFLOATBOB = True; }
			loop;
		see:
			GHUL AABBCCBB 3 A_Chase;
			loop;
		missile:
			GHUL DE 4 Bright A_FaceTarget;
			GHUL F 0 Bright A_FaceTarget;
			GHUL F 4 Bright { A_SpawnProjectile("Shin_GhoulBall", 23); A_FaceTarget(); }
			GHUL G 4 Bright;
			goto see;
		pain:
			GHUL I 3 Bright;
			GHUL K 3 Bright A_Pain;
			goto see;
		death:
			GHUL L 5 Bright {bFLOATBOB = False;}
			GHUL M 5 Bright A_Scream;
			GHUL NO 5 Bright;
			GHUL P 5 Bright A_NoBlocking;
			GHUL QR 5 Bright;
			GHUL S -1;
			stop;
		XDeath:
		    Stop;
	}
}

Class Shin_GhoulBall : ShinDoom_Actor
{
	Default
	{
		Radius 8;
		Height 6;
		Speed 15;
		FastSpeed 20;
		Damage 3;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		SeeSound "Ghoul/Shot";
		DeathSound "Ghoul/ShotX";
	}
	States
	{
		spawn:
			GBAL AB 4 Bright;
			loop;
		death:
			GBAL C 5 Bright;
			APBX BCDE 5 Bright;
			stop;
	}
}