
Class Shin_Gargoyle : Shin_DoomImp
{
	Default
	{
		Health 60;
		Radius 20;
		Height 56;
		Mass 100;
		Speed 12;
		PainChance 200;
		Monster;
		+FLOORCLIP
		SeeSound "Gargoyle/sight";
		PainSound "Gargoyle/pain";
		DeathSound "Gargoyle/death";
		ActiveSound "Gargoyle/active";
		HitObituary "$OB_IMPHIT";
		Obituary "$OB_IMP";
		Tag "Gargoyle";
	}
	
	States
	{
	Spawn:
		FIMP V 10 A_Look;
		Loop;
	See:
		FIMP AABBCCDD 3 { A_Chase(); bFLOAT = true; bNOGRAVITY = true; }
		Loop;
	Melee:
		Stop;
	Missile:
		FIMP EF 8 A_FaceTarget;
		FIMP G 6 A_FireVolley("Shin_GargoyleProjectile", 2, 7, 50);
		Goto See;
	Pain:
		FIMP H 2;
		FIMP H 2 A_Pain;
		Goto See;
	Death:
		FIMP I 5;
		FIMP J 5 { A_Scream(); A_NoBlocking(); }
		FIMP K 4;
	DeathLoop:
		FIMP K 1 A_CheckFloor("DeathStop");
		Loop;
	DeathStop:
		FIMP LM 4;
		FIMP M -1;
		Stop;
	XDeath:
		FIMP N 5;
		FIMP O 5 A_XScream;
		FIMP P 5;
		FIMP Q 5 A_NoBlocking;
		FIMP RST 5;
		FIMP U -1;
		Stop;	
	Raise:
		FIMP L 8;
		FIMP KJI 6;
		Goto See;
	}
}

Class Shin_DeadGargoyle : Shin_Gargoyle
{
	Default { -COUNTKILL +NEVERRESPAWN -BOSSDEATH }
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Die("spawndeath");
			Stop;
		Idle:
			Goto Super::Spawn;
		Death.Spawndeath:
			TNT1 A 0 A_NoBlocking;
			Goto Super::Death+5;
	}
}

Class Shin_GargoyleProjectile : ShinDoom_Actor
{
	Default
	{
		Radius 6;
		Height 8;
		Speed 10;
		FastSpeed 20;
		Damage 3;
		PoisonDamage 2, 5;
		PoisonDamageType "Acid";
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		+ADDITIVEPOISONDAMAGE
		RenderStyle "Add";
		Alpha 1;
		SeeSound "imp/attack";
		DeathSound "imp/shotx";
	}
	States
	{
		Spawn:
			BAL1 AB 4 BRIGHT;
			Loop;
		Death:
			BAL1 CDE 6 BRIGHT;
			Stop;
	}
}