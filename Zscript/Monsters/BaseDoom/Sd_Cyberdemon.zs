//
class Shin_Cyberdemon : ShinDoom_Actor Replaces Cyberdemon
{
	Default
	{
		Health 4000;
		Radius 40;
		Height 110;
		Mass 1000;
		Speed 16;
		PainChance 20;
		Monster;
		MinMissileChance 160;
		MissileChanceMult 0.5;
		+BOSS 
		+FLOORCLIP
		+NORADIUSDMG
		+DONTMORPH
		+BOSSDEATH
		+E2M8BOSS
		+E4M6BOSS
		Scale 1.1;
		SeeSound "cyber/sight";
		PainSound "cyber/pain";
		DeathSound "cyber/death";
		ActiveSound "cyber/active";
		Obituary "$OB_CYBORG";
		Tag "$FN_CYBER";
	}
	States
	{
	Spawn:
		CYBR AB 10 A_Look;
		Loop;
	See:
		CYBR A 3 A_Hoof;
		CYBR ABBCC 3 A_Chase;
		CYBR D 3 A_Metal;
		CYBR D 3 A_Chase;
		Loop;
	Missile:
		CYBR E 6 A_FaceTarget;
		CYBR F 6 Bright A_CyberAttack;
		CYBR E 18 A_FaceTarget;
		CYBR F 6 Bright A_CyberAttack;
		CYBR E 18 A_FaceTarget;
		CYBR F 6 Bright A_CyberAttack;
		Goto See;
	Pain:
		CYBR G 10 A_Pain;
		Goto See;
	Death:
		CYBR H 10 Bright;
		CYBR I 10 Bright A_Scream;
		CYBR JKL 10 Bright;
		CYBR M 10 Bright A_NoBlocking;
		CYBR NO 10 Bright;
		CYBR P 30;
		CYBR P -1 A_BossDeath;
		Stop;
	}
}