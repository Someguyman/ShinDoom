
Class Shin_LostSoul : ShinDoom_Actor Replaces LostSoul
{
	Default
	{
		Health 60;
		Radius 16;
		Height 56;
		Mass 50;
		Speed 8;
		Damage 3;
		PainChance 256;
		MissileChanceMult 0.5;
		Monster;
		+FLOAT 
		+NOGRAVITY 
		+DONTFALL 
		+NOICEDEATH 
		+ZDOOMTRANS 
		-COUNTKILL
		+BOUNCEONFLOORS 
		+BOUNCEONCEILINGS 
		+ONLYSLAMSOLID
		BounceType "Doom";
		FloatBobStrength 0.5;
		FloatBobFactor 0.8;
		AttackSound "skull/melee";
		PainSound "skull/pain";
		DeathSound "skull/death";
		ActiveSound "skull/active";
		Obituary "$OB_SKULL";
		Tag "$FN_LOST";
	}
	States
	{
	Spawn:
		SKUL AB 10 BRIGHT { A_Look(); bFLOATBOB = True; }
		Loop;
	See:
		SKUL AB 6 BRIGHT A_Chase;
		Loop;
	Missile:
		SKUL C 10 BRIGHT A_FaceTarget;
		SKUL D 4 BRIGHT { A_SkullAttack(); bFLOATBOB = False; }
		SKUL CD 4 BRIGHT;
		Goto Missile+2;
	Pain:
		SKUL E 3 BRIGHT;
		SKUL E 3 BRIGHT A_Pain;
		Goto See;
	Death:
		SKUL F 6 BRIGHT { bFLOATBOB = False; }
		SKUL G 6 BRIGHT A_Scream;
		SKUL H 6 BRIGHT;
		SKUL I 6 BRIGHT A_NoBlocking;
		SKUL J 6 BRIGHT;
		SKUL K 6 BRIGHT;
		Stop;
	XDeath:
		SKUL F 4 BRIGHT {bFLOATBOB = False;}
		SKUL G 4 BRIGHT A_Scream;
		SKUL H 4 BRIGHT;
		SKUL I 4 BRIGHT A_NoBlocking;
		SKUL J 4 BRIGHT;
		SKUL K 4 BRIGHT;
		Stop;
	}
}