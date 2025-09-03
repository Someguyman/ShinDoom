
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
		+ZDOOMTRANS
		SeeSound "pain/sight";
		PainSound "pain/pain";
		DeathSound "pain/death";
		ActiveSound "pain/active";
		Tag "$FN_PAIN";
		Scale 1.2;
		FloatBobStrength 0.5;
		FloatBobFactor 0.8;
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
		PAIN F 0 BRIGHT { A_PainAttack("Shin_PainSoul"); A_FaceTarget(); }
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
	/*
	Death:
		PAIN H 8 BRIGHT {bFLOATBOB = False;}
		PAIN I 8 BRIGHT A_Scream;
		PAIN J 8 BRIGHT;
		PAIN K 8 BRIGHT;
		PAIN L 7 BRIGHT { A_PainDie("Shin_PainSoul"); A_FadeOut(0.247059); }
		PAIN M 6 BRIGHT;
		Stop;
	*/
	Death:
		PAIN H 6 BRIGHT {bFLOATBOB = False;}
		PAIN I 9 BRIGHT A_Scream;
		PAIN J 5 BRIGHT;
		PAIN K 8 BRIGHT;
		PAIN L 7 BRIGHT { A_PainDie("Shin_PainSoul"); A_FadeOut(0.247059); }
		PAIN M 6 BRIGHT;
		Stop;
	//XDeath:
		PAIN H 3 BRIGHT {bFLOATBOB = False;}
		PAIN I 12 BRIGHT; //A_Scream;
		PAIN K 6 BRIGHT;
		PAIN L 5 BRIGHT { A_PainDie("Shin_PainSoul"); A_FadeOut(0.247059); }
		PAIN M 4 BRIGHT;
		Stop;
	Crush:
		stop;
	Raise:
		Stop;
	}
}

Class Shin_PainSoul : Shin_Lostsoul
{
	States
	{
		Spawn:
			SKUL CD 4 BRIGHT;
			Loop;
		Idle:
			SKUL AB 10 BRIGHT { A_Look(); bFLOATBOB = True; }
			Loop;
	}
}