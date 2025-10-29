
Class Shin_PainElemental : ShinDoom_Actor Replaces PainElemental
{
	Default
	{
		Health 400;
		Radius 31;
		Height 56;
		Mass 400;
		Speed 8;
		PainChance 128;
		Monster;
		+FLOAT 
		+NOGRAVITY
		+NEVERRESPAWN
		+DONTGIB
		+NOINFIGHTSPECIES
		SeeSound "pain/sight";
		PainSound "pain/pain";
		DeathSound "pain/death";
		ActiveSound "pain/active";
		Tag "$FN_PAIN";
		Scale 1.2;
		FloatBobStrength 0.5;
		FloatBobFactor 0.8;
		Species "PainElemental";
		DamageFactor "PainSkull", 0;
	}
	States
	{
	Spawn:
		PAIN AB 10 { A_Look(); bFLOATBOB = True; }
		Loop;
	See:
		PAIN AABBCC 3 A_Chase;
		Loop;
	Missile:
		PAIN D 5 A_FaceTarget;
		PAIN E 5 { A_FaceTarget(); A_StartSound("pain/attack", CHAN_VOICE); }
		PAIN F 5 BRIGHT A_FaceTarget;
		PAIN F 0 BRIGHT 
		{ 
			if (bSHINSHADOW == true)
				A_PainAttack("Shin_Spectre_PainSoul"); 
			else
				A_PainAttack("Shin_PainSoul"); 
				
			A_FaceTarget(); 
		}
		Goto See;
	Pain:
		PAIN G 6;
		PAIN G 6 A_Pain;
		Goto See;
	Death.Ice:
		PAIN G 0 {bFLOATBOB = False;}
		PAIN G 5 A_GenericFreezeDeath;
		TNT1 A 1
		{
			A_PainDie("Shin_PainSoul");			
			A_Freezedeathchunks();
		}
		WAIT;
	Death:
		PAIN H 6 BRIGHT {bFLOATBOB = False;}
		PAIN I 9 BRIGHT A_Scream;
		PAIN J 5 BRIGHT;
		PAIN K 8 BRIGHT;
		PAIN L 7 BRIGHT 
		{ 
			A_PainDie("Shin_PainSoul");	 	
			A_BloodSplat(20); 
		}
		PAIN M 6 BRIGHT;
		Stop;
	Crush:
		stop;
	Raise:
		Stop;
	}
}

Class Shin_PainSoul : Shin_Lostsoul
{
	Default
	{
		AttackSound "PainSkull/melee";
		PainSound "PainSkull/pain";
		DeathSound "PainSkull/death";
		ActiveSound "PainSkull/active";
		scale 0.9;
		Health 50;
		-COUNTKILL;
		+DONTHARMSPECIES
		Tag "Blood Soul";
		Species "PainElemental";
		DamageType "PainSkull";
		DamageFactor "PainSkull", 0;
	}
	States
	{
	Spawn:
		PSKL CD 4 BRIGHT;
		Loop;
	Idle:
		PSKL AB 10 BRIGHT { A_Look(); bFLOATBOB = True; }
		Loop;
	See:
		PSKL AB 6 BRIGHT A_Chase;
		Loop;
	Missile:
		PSKL C 10 BRIGHT A_FaceTarget;
		PSKL D 4 BRIGHT { A_SkullAttack(); bFLOATBOB = False; }
		PSKL CD 4 BRIGHT;
		Goto Missile+2;
	Pain:
		PSKL E 3 BRIGHT;
		PSKL E 3 BRIGHT A_Pain;
		Goto See;
	XDeath:
	Death:
		PSKL F 4 BRIGHT {bFLOATBOB = False;}
		PSKL G 4 BRIGHT A_Scream;
		PSKL H 4 BRIGHT;
		PSKL I 4 BRIGHT A_NoBlocking;
		PSKL J 4 BRIGHT;
		PSKL K 4 BRIGHT;
		Stop;
	}
}