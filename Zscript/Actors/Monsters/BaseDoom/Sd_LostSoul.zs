
Class Shin_LostSoul : ShinDoom_Actor Replaces LostSoul
{
	Default
	{
		Health 100;
		Radius 16;
		Height 56;
		Mass 50;
		Speed 4;
		Damage 3;
		PainChance 256;
		MissileChanceMult 1.5;
		Monster;
		+FLOAT 
		+NOGRAVITY 
		+DONTFALL 
		+NOICEDEATH 
		+BOUNCEONFLOORS 
		+BOUNCEONCEILINGS 
		+ONLYSLAMSOLID
		+NOINFIGHTSPECIES
		+DONTHARMSPECIES
		BounceType "Doom";
		//scale 1.1;
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
		SKUL AABB 3 BRIGHT A_Skullchase();
		Loop;
	Missile:
		SKUL C 10 BRIGHT A_FaceTarget;
		SKUL D 4 BRIGHT { A_SkullAttack(); bFLOATBOB = False; }
		SKUL CD 4 BRIGHT;
		Goto Missile+2;
	Pain:
		SKUL E 3 BRIGHT { A_Chase; bFLOATBOB = True; }
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
		SKUL F 4 BRIGHT { bFLOATBOB = False; }
		SKUL G 4 BRIGHT A_Scream;
		SKUL H 4 BRIGHT;
		SKUL I 4 BRIGHT A_NoBlocking;
		SKUL J 4 BRIGHT;
		SKUL K 4 BRIGHT;
		Stop;
	}
	
	Void A_Skullchase()
	{
		A_Chase(); bFLOATBOB = True;
	}
}