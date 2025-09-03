
Class Shin_HellHound : ShinDoom_Actor
{
	Default
	{
		Health 300;
		PainChance 128;
		Speed 15;
		Radius 30;
		Height 56;
		Mass 1000;
		Monster;
		Damage 4;
		Scale 1.2;
		+FLOORCLIP
		-RETARGETAFTERSLAM
		+ONLYSLAMSOLID
		+NOINFIGHTSPECIES
		+DONTHARMCLASS
		MeleeRange 60;
		MissileChanceMult 0.0385;
		SeeSound "Hound/sight";
		AttackSound "Hound/Melee";
		PainSound "Hound/pain";
		DeathSound "Hound/death";
		ActiveSound "Hound/active";
		Tag "Hell Hound";
	}
	
	States
	{
	Spawn:
		HELH AB 10 A_Look;
		Loop;
	See:
		HELH AABBCCDD 3 FAST A_HoundChase();
		Loop;
	Melee:
		HELH EF 6 FAST A_FaceTarget;
		HELH G 6 FAST A_CustomMeleeAttack(10*random(1,8));
		Goto See;
	Missile:
		HELH E 4 FAST A_FaceTarget();
		HELH F 10 FAST A_SkullAttack(30);
		HELH G 4 FAST A_Gravity();
		HELH G 1 A_ScaleVelocity(0); 
		Loop;
	Pain:
		HELH H 2;
		HELH H 2 A_Pain;
		Goto See;
	Death:
		HELH I 8;
		HELH J 8 A_Scream;
		HELH K 4;
		HELH L 3 A_NoBlocking;
	DeathLoop:
		HELH L 1 A_CheckFloor("DeathStop");
		Loop;
	DeathStop:
		HELH M 0 A_StartSound("misc/thud", 0);
		HELH M 4;
		HELH N -1;
		Stop;
	Raise:
		HELH N 5;
		HELH MLKJI 5;
		Goto See;
	}
}

Extend Class Shin_Hellhound
{	
	void A_HoundChase()
	{
		statelabel st = null;
		if (CheckIfCloser(target, 290))
			st = "Missile"; 
		if (CheckIfCloser(target, 100))
			st = null;
		A_Chase("Melee", st);
	}
}