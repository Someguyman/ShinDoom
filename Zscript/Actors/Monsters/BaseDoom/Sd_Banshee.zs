
Class Shin_Banshee : ShinDoom_Actor
{
	Default
	{
		Health 100;
		Speed 8;
		Radius 20;
		Height 56;
		ReactionTime 8;
		PainChance 64;
		Mass 500;
		Monster;
		+FLOAT
		+NOGRAVITY
		+ZDOOMTRANS
		+DONTFALL
		PainSound "Banshee/pain";
		DeathSound "Banshee/death";
		Tag "$FN_ID24BANSHEE";
	}
	
	States
	{
		spawn:
			BSHE AB 10 Bright A_Look;
			loop;
		see:
			BSHE A 0 Bright A_Startsound("Banshee/Active", CHAN_BODY, CHANF_LOOPING);
			BSHE AAABBBCCCAAABBBCCC 2 Bright A_Chase;
			Goto see+1;
		melee:
			BSHE D 1 Bright A_Explode(100,8);
			wait;
		pain:
			BSHE D 3 Bright A_Stopsound(CHAN_BODY);
			BSHE D 3 Bright A_Pain;
			goto see;
		death:
			BSHE D 1 bright A_Stopsound(CHAN_BODY);
			BSHE D 3 Bright A_Scream;
			BSHE E 6 Bright A_Explode(128,128);
			BSHE F 8 Bright A_NoBlocking;
			BSHE G 6 Bright;
			BSHE H 4 Bright;
			TNT1 A 20;
			stop;
		XDeath:
			Stop;
	}
}