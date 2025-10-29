
Class Shin_DoomImp : ShinDoom_Actor Replaces Doomimp
{
	Default
	{
		Health 60;
		Radius 20;
		Height 56;
		Mass 100;
		Speed 8;
		Gibhealth 20;
		PainChance 200;
		Monster;
		+FLOORCLIP
		SeeSound "imp/sight";
		PainSound "imp/pain";
		DeathSound "imp/death";
		ActiveSound "imp/active";
		HitObituary "$OB_IMPHIT";
		Obituary "$OB_IMP";
		Tag "$FN_IMP";
	}
	States
	{
	Spawn:
		TROO AB 10 A_Look;
		Loop;
	See:
		TROO AABBCCDD 3 A_Chase;
		Loop;
	Melee:
	Missile:
		TROO EF 8 A_FaceTarget;
		TROO G 6 A_TroopAttack;
		Goto See;
	Pain:
		TROO H 2;
		TROO H 2 A_Pain;
		Goto See;
	Death:
		TROO I 8;
		TROO J 8 A_Scream;
		TROO K 6;
		TROO L 6 A_NoBlocking;
		TROO M -1 A_NormalDeath();
		Stop;
	XDeath:
		TROO N 5;
		TROO O 5 A_XScream;
		TROO P 5;
		TROO Q 5 A_NoBlocking;
		TROO RST 5;
		TROO U -1 A_NormalDeath();
		Stop;
	Shin.Raise:
		TROO M 8;
		TROO L 8;
		TROO KJI 6;
		Goto See;
	XRaise:
		TROO R 5;
		TROO QPON 5;
		Goto See;
	}
}

Class Shin_Prowler : Shin_Doomimp
{
	Default
	{
		+ShinDoom_Actor.SHINSHADOW	
		Obituary "$OB_STEALTHIMP";
		HitObituary "$OB_STEALTHIMP";
		tag "Prowler";
	}
	States
	{
		Spawn:
			STRO AB 10 A_Look;
			Loop;
		See:
			STRO AABBCCDD 3 A_Chase;
			Loop;
		Melee:
		Missile:
			STRO EF 8 A_FaceTarget;
			STRO G 8 A_TroopAttack;
			Goto See;
		Pain:
			STRO H 2;
			STRO H 2 A_Pain;
			Goto See;
		Death:
			STRO I 8;
			STRO J 8 A_Scream;
			STRO K 6;
			STRO L 6 A_NoBlocking;
			STRO M -1 A_NormalDeath();
			Stop;
		XDeath:
			STRO N 5;
			STRO O 5 A_XScream;
			STRO P 5;
			STRO Q 5 A_NoBlocking;
			STRO RST 5;
			STRO U -1 A_NormalDeath();
			Stop;
		Shin.Raise:
			STRO M 8;
			STRO L 8;
			STRO KJI 6;
			Goto See;
		XRaise:
			STRO R 5;
			STRO QPON 5;
			Goto See;		
	}
}