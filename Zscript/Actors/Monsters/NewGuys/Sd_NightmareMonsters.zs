
Class Shin_NightmareImp : Shin_Doomimp
{
	Default
	{
		Bloodcolor "f707ef";
		RenderStyle "Translucent";
		Alpha 0.666;
		Speed 16;
		Health 80;
		PainChance 128;
		HitObituary "$OB_NITIMPHIT";
		Obituary "$OB_NITIMP";
		SeeSound "imp2/sight";
		ActiveSound "imp2/Active";
		PainSound "Imp2/Pain";
		DeathSound "imp2/Death";
		Species "NightmareImp";
	}
	States
	{
		Spawn:
			IMP2 AB 10 A_Look;
			Loop;
		See:
			IMP2 AABBCCDD 3 A_Chase;
			Loop;
		Melee:
		Missile:
			IMP2 EF 8 A_FaceTarget;
			IMP2 G 6 { A_CustomComboAttack("Shin_NightmareImpBall", 32, 10 * random(1, 6), "imp/melee"); A_FaceTarget(); }
			Goto See;
		Pain:
			IMP2 H 2;
			IMP2 H 2 A_Pain;
			Goto See;
		Death:
			IMP2 I 8;
			IMP2 J 8 A_Scream;
			IMP2 K 6;
			IMP2 L 6 A_NoBlocking;
			IMP2 M -1 A_NormalDeath();
			Stop;
		XDeath:
			IMP2 N 5;
			IMP2 O 5 A_XScream;
			IMP2 P 5;
			IMP2 Q 5 A_NoBlocking;
			IMP2 RST 5;
			IMP2 U -1 A_NormalDeath();
			Stop;
		Raise:
			IMP2 MLKJI 8;
			Goto See;
	}
}

Class Shin_NightmareImpBall : Shin_CacodemonBall 
{
	Default
	{
		SeeSound "imp/attack2";
		DeathSound "imp/shotx2";
		Speed 20;
		FastSpeed 35;
		Damage 3;
	}
	States
	{
		Spawn:
			BALN AB 4 Bright;
			Loop;
		Death:
			BALN CDE 6 Bright;
			Stop;
	}
}

Class Shin_Nightmaredemon : Shin_Pinky
{
	Default
	{
		SeeSound "demon2/sight";
		AttackSound "demon2/melee";
		PainSound "demon2/pain";
		DeathSound "demon2/death";
		ActiveSound "demon2/active";
		Alpha 0.666;
		Speed 12;
		//Alpha 0.4;
		Health 300;
		RenderStyle "Translucent";
		BloodColor "Blue";
		Obituary "%o was devoured by a nightmare demon.";
		Species "NightmareSpectre";
		Tag "Nightmare Demon";
	}
	
	States
	{
		Spawn:
			NMDM AB 10 A_Look;
			Loop;
		See:
			NMDM AABBCCDD 2 Fast A_Chase;
			Loop;
		Melee:
			NMDM EF 8 Fast A_FaceTarget;
			NMDM G 8 Fast A_SargAttack;
			Goto See;
		Pain:
			NMDM H 2 Fast;
			NMDM H 2 Fast A_Pain;
			Goto See;
		Death:
			NMDM I 8;
			NMDM J 8 A_Scream;
			NMDM K 4;
			NMDM L 3 A_NoBlocking;
			Goto Death.Loop;
		Death.End:
			NMDM M 0 A_StartSound("misc/thud", 0);
			NMDM M 4;
			NMDM N -1;
			Stop;
		XDeath:
			NMDX A 4;
			NMDX B 4 A_XScream;
			NMDX C 4 A_NoBlocking();
			NMDX DEFGHI 4;
			NMDX J -1;
			Stop;
		Shin.Raise:
			NMDM N 5;
			NMDM MLKJI 5;
			Goto See;
		XRaise:
			NMDX G 4;
			NMDX FEDCBA 4;
			Goto See;
	}
}

Class Shin_NightmareSpectre : Shin_Nightmaredemon
{
	Default
	{
		SeeSound "spectre2/sight";
		AttackSound "spectre2/melee";
		PainSound "spectre2/pain";
		DeathSound "spectre2/death";
		ActiveSound "spectre2/active";
		+SHADOW
		RenderStyle "Subtract";
		Obituary "%o was devoured by a nightmare spectre.";
		Species "NightmareSpectre";
		Tag "Nightmare Spectre";
	}
	
	States
	{
		Spawn:
			NMSP AB 10 A_Look;
			Loop;
		See:
			NMSP AABBCCDD 2 Fast A_Chase;
			Loop;
		Melee:
			NMSP EF 8 Fast A_FaceTarget;
			NMSP G 8 Fast A_SargAttack;
			Goto See;
		Pain:
			NMSP H 2 Fast;
			NMSP H 2 Fast A_Pain;
			Goto See;
		Death:
			NMSP I 8;
			NMSP J 8 A_Scream;
			NMSP K 4;
			NMSP L 3 A_NoBlocking;
		Death.Loop:
			NMSP L 1 A_CheckFloor("DeathStop");
			Loop;
		Death.End:
			NMSP M 0 A_StartSound("misc/thud", 0);
			NMSP M 4;
			NMSP N -1;
			Stop;
		XDeath:
			NMSX A 4;
			NMSX B 4 A_XScream;
			NMSX C 4 A_NoBlocking();
			NMSX DEFGHI 4;
			NMSX J -1;
			Stop;
		Shin.Raise:
			NMSP N 5;
			NMSP MLKJI 5;
			Goto See;
		XRaise:
			NMSX G 4;
			NMSX FEDCBA 4;
			Goto See;
	}
}

Class Shin_NightmareCacodemon : Shin_Cacodemon
{
	Default
	{
		SeeSound "caco2/sight";
		PainSound "caco2/pain";
		DeathSound "caco2/death";
		ActiveSound "caco2/active";
		Health 700;
		//Speed 12;
		Speed 24;
		PainChance 96;
		//+SHADOW
		//+NOSPRITESHADOW
		MissileChanceMult 1.5;
		//RenderStyle "Add";
		RenderStyle "Translucent";
		BloodColor "Orange";
		Obituary "$OB_NITCACO";
		HitObituary "$OB_NITCACOHIT";
		//Translation "NightmareCaco";
		Species "NightmareCacodemon";
		//Alpha 0.4;
		Alpha 0.666;
	}
	
	States
	{
		Spawn:
			CCBT A 10 A_Look;
			Loop;
		See:
			CCBT A 3 A_Chase;
			Loop;
		Missile:
			CCBT BC 4 A_FaceTarget;
			CCBT D 4 Bright A_NightMareCacoATK();
			CCBT BC 3 A_FaceTarget;
			CCBT D 4 Bright A_NightMareCacoATK();
			CCBT BC 3 A_FaceTarget;
			CCBT D 4 Bright A_NightMareCacoATK();
			Goto See;
		Pain:
			CCBT E 3;
			CCBT E 3 A_Pain;
			CCBT F 6;
			Goto See;
		Death:
			CCBT G 8;
			CCBT H 8 A_Scream;
			CCBT I 8;
			CCBT J 8;
			CCBT K 8 A_NoBlocking;
			CCBT L -1 A_SetFloorClip;
			Stop;
		Raise:
			CCBT L 8 A_UnSetFloorClip;
			CCBT KJIHG 8;
			Goto See;
	}
}

class Shin_NightmareCacodemonBall : Shin_CacodemonBall
{
	Default
	{
		Radius 6;
		Height 8;
		Speed 10;
		FastSpeed 20;
		Damage 5;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.666;
		SeeSound "caco/attack2";
		DeathSound "caco/shotx2";
	}
	States
	{
	Spawn:
		BLN2 AB 4 BRIGHT;
		Loop;
	Death:
		BLN2 CDE 6 BRIGHT;
		Stop;
	}
}

Extend Class Shin_NightmareCacodemon
{
	Void A_NightMareCacoATK()
	{
		A_FaceTarget();
		A_CustomComboAttack("Shin_NightmareCacodemonBall", 32, 10 * random(1, 6), "caco/melee");
	}
}