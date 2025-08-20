
Class Shin_Summoner : ShinDoom_Actor
{
	Default
	{
		Health 450;
		Radius 20;
		Height 56;
		Mass 400;
		Speed 34;
		PainChance 50;
		Monster;
		+FLOORCLIP 
		+NOTARGET
		+NOINFIGHTING
		+SEEINVISIBLE
		+AVOIDHAZARDS
		+ALWAYSFAST
		scale 1.1;
		ReactionTime 55;
		FloatBobStrength 0.5;
		SeeSound "summoner/sight";
		PainSound "summoner/pain";
		DeathSound "summoner/death";
		ActiveSound "summoner/active";
		Obituary "$o was zapped by a Summoner";
		Tag "Summoner";
	}
			
	bool SummonedOnce;
	
	States
	{
	Spawn:
		SUMM A 10 { A_Look(); A_SummonerStop(); SummonedOnce = false; } 
		Loop;
	See:
		SUMT A 2 bright A_SummonerGo();
		SUMT BC 2 bright;
	Teleport.Loop:
		SUMT EFGHIEFGHIEFGHIEFGHIEFGHIEFGHI 1 Bright A_SummonerChase();
		SUMM A 0 { bFRIGHTENED = False; }
		SUMM A 0 A_MonsterRefire(0, "Teleport.Loop");
		Goto Missile;
	Missile:
		SUMT C 2 bright { A_Facetarget(); A_StartSound("summoner/teleport"); }
		SUMT BA 2 bright A_Facetarget;
		SUMM A 4 A_SummonerStop();
		SUMM AA 7 A_Facetarget();
		TNT1 A 0 A_Jumpif(SummonedOnce == true, "Attack");
		TNT1 A 0 A_Jump(70,"Summon");
		SUMM A 0 A_MonsterRefire(0, "See");
		Goto Attack;
	Attack:
		SUMM BC 8 Bright { A_Facetarget(); SummonedOnce = false; }
		SUMM DDDD 6 Bright A_SummonAttack();
		SUMM A 12 A_Facetarget;
		goto see;
	Summon:
		SUMM E 20 Bright A_SummonStart();
		SUMM E 5 Bright { A_SummonDudes(); SummonedOnce = true; }
		SUMM A 12 A_Facetarget;
		Goto See;
	Pain:
		SUMM F 5 { bFRIGHTENED = True; A_SetRenderStyle(1.0, STYLE_Normal); SummonedOnce = false; } //When hurt, Run away like a bitch
		SUMM F 5 A_Pain;
		Goto See;
	Death:
		SUMM G 7 { bFLOATBOB = False; }
		SUMM H 7 A_Scream;
		SUMM I 7 A_NoBlocking;
		SUMM JKL 7;
		SUMM M 38;
		SUMM M 2 A_KillChildren;
		SUMM M -1;
		Stop;
	}
}

Class Shin_Summonerball : RevenantTracer
{
	int homingTimer;
	
	override void PostBeginPlay()
	{
		homingTimer = 100;
		super.PostBeginPlay();
	}
	
	Void A_SummonerBall()
	{
		if (homingTimer == 0)SetStateLabel("NotHoming");
		A_Tracer2(16.875); 
		A_Weave(6, 0, 1.8, 0.0);
		homingTimer--;
	}
	
	States
	{
		Spawn:
			FATB AB 2 BRIGHT A_SummonerBall();
			Loop;
		NotHoming:
			FATB AB 2 BRIGHT A_Weave(6, 0, 1.8, 0.0);
			Loop;
	}
}

Class Shin_SummonerPentagram : ShinDoom_Actor
{
	Default
	{
		Radius 20;
		Height 14;
		ProjectilePassHeight -16;
	}
	States
	{
		Spawn:
			PENT A 100 BRIGHT;
		Fade.Loop:
			PENT A 1 BRIGHT A_Fadeout(0.2);
			Loop;
	}
}

//How the logic of the Summoner works is that it has a countdown while chasing.
//If the timer reaches zero, we stop moving and then enter a thinking state.
//This thinking state decides if it should attack or summon based on it's current position in relation to the player and it's current health.
//

Extend Class SHin_Summoner
{
	
	void A_SummonAttack()
	{
		if (target == null) return;
		A_FaceTarget();
		Actor missile = SpawnMissile(target, "Shin_Summonerball");
		missile.tracer = target;
	}
	
	void A_SummonerGo()
	{
		A_StartSound("summoner/teleport");
		A_UnSetShootable();
		A_ScaleVelocity(0); 
		A_SetRenderStyle(0.6, STYLE_Translucent); 
		bFLOATBOB = False; 
	}
	
	void A_SummonerStop()
	{	
		A_Facetarget(); 
		A_SetShootable(); 
		A_SetRenderStyle(1.0, STYLE_Normal);
		bFLOATBOB = True; 
		bFRIGHTENED = False;
	}
	
	void A_SummonerChase()
	{
		A_Chase(null,null, CHF_NOPLAYACTIVE);
		If (Target == null)
		{
			SetState(SpawnState);
		}
	}
	
	void A_SummonStart()
	{
		A_Facetarget();
		A_SpawnItemEX("Shin_SummonerPentagram",0,0,-999);
	}
}