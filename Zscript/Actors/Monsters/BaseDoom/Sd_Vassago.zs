
Class Shin_Vassago : ShinDoom_Actor
{
	Default
	{
		Health 1000;
		Speed 8;
		ReactionTime 8;
		PainChance 100;
		Radius 24;
		Height 64;
		Mass 1000;
		+BOSSDEATH
		+DONTHARMCLASS
		Monster;
		Scale 1.2;
		SeeSound "Vassago/sight";
		PainSound "Vassago/pain";
		DeathSound "Vassago/death";
		ActiveSound "Vassago/active";
		ShinDoom_Actor.FootstepSound "Baron/walk";
		Obituary "$OB_ID24VASSAGO";
		Tag "$FN_ID24VASSAGO";
	}
	
	States
	{
		spawn:
			VASS AB 10 A_Look;
			loop;
		See:
			VASS A 3 A_Footstep();
			VASS ABB 3 A_Chase;
			VASS C 3 A_Footstep();
			VASS CDD 3 A_Chase;
			Loop;
		melee:
		missile:
			VASS E 8 Bright { A_FaceTarget(); A_StartSound("Vassago/attack", CHAN_BODY); }
			VASS FG 4 Bright A_FaceTarget;
			VASS H 8 Bright { A_SpawnProjectile("Shin_VassagoFlame", 32); A_FaceTarget(); }
			goto see;
		pain:
			VASS I 2;
			VASS I 2 A_Pain;
			goto see;
		death:
			VASS J 8 Bright;
			VASS K 8 Bright A_Scream;
			VASS L 7 Bright;
			VASS M 6 Bright A_NoBlocking;
			VASS NO 6 Bright;
			VASS P 7 Bright;
			VASS Q -1 A_BossDeath;
			stop;
		raise:
			VASS P 8;
			VASS ONMLKJ 8;
			goto see;
	}
}

Class Shin_VassagoFlame : ShinDoom_Actor
{
	Default
	{
		Radius 6;
		Height 16;
		Speed 15;
		FastSpeed 20;
		Damage 5;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 1;
		Projectile;
		SeeSound "Vassago/Shot";
		DeathSound "Vassago/ShotX";
	}
	
	States
	{
		spawn:
			VFLM AB 4 Bright;
			loop;
		death:
			VFLM C 4 bright A_VassagoExplode();
			VFLM D 4 bright;
			VFLM E 4 bright;
		death.loop:	
			VFLM F 4 bright A_VassagoBurn(); //1
			VFLM G 4 bright;
			VFLM H 4 bright;
			VFLM H 0 bright A_VassagoRepeat();
			Loop;
		Death.Continued:			
			VFLM F 4 bright A_VassagoBurn(); //8			
			VFLM J 4 bright;
			VFLM K 4 bright;
			VFLM L 4 bright A_Explode(10,130);
			VFLM MNOPQ 4 bright;
			stop;
	}
}

extend class Shin_VassagoFlame
{
	int i;
	
	Void A_VassagoExplode()
	{
		bNOGRAVITY = False;
		A_ChangeLinkFlags(false);
		A_StartSound("Vassago/fire");
		A_Explode(10,130);
		i = 8;
	}
	
	Void A_VassagoBurn()
	{
		A_StartSound("Vassago/fire");
		A_Explode(10,130);	
	}
	
	Void A_VassagoRepeat()
	{
		if (i == 0) SetStateLabel("Death.Continued");
        i--;
	}
}