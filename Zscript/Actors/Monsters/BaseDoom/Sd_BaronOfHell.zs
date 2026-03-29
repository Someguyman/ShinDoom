
Class Shin_BaronOfHell : ShinDoom_Actor Replaces Baronofhell
{
	Default
	{
		Health 1000;
		Radius 24;
		Height 64;
		Mass 1000;
		Speed 8;
		PainChance 50;
		Gibhealth 40;
		Monster;
		+FLOORCLIP
		+BOSSDEATH
		+E1M8BOSS
		MissileChanceMult 0.5;
		Species "HellKnoble";
		SeeSound "baron/sight";
		PainSound "baron/pain";
		DeathSound "baron/death";
		ActiveSound "baron/active";
		Obituary "$OB_BARON";
		HitObituary "$OB_BARONHIT";
		ShinDoom_Actor.FootstepSound "Baron/walk";
		//FootstepSound "Baron/walk";
		Tag "$FN_BARON";
		BloodColor "30 67 23";
		+NOINFIGHTSPECIES
		Scale 1.25;
		+NOFEAR
	}
	
	States
	{
	Precache:
		ZBOS A 0;
		BOSS A 0;
		Stop;
	Spawn:
		BOSS AB 10 { A_Look(); A_RestoreSprite(); InitialCount = 2; MissileCount = InitialCount; }
		Loop;
	See:
		"####" A 3 A_Footstep();
		"####" ABB 3 A_Chase;
		"####" C 3 A_Footstep();
		"####" CDD 3 A_Chase;
		Loop;
	Melee:
		Goto Missile+1;
	Missile:
		//"####" A 0 A_JUMP(80, "Missile.SuperAtk");
		"####" A 0 A_JUMPIF(MissileCount == 0, "Missile.SuperAtk");
		"####" A 0 A_JUMPIF(MissileCount == 1, "Missile.RightHand");
		"####" EF 8 A_FaceTarget;
		"####" G 8 A_BaronAttack();
		Goto See;
	Missile.RightHand:
		"####" PQ 8 A_FaceTarget;
		"####" R 8 A_BaronAttack();
		Goto See;
	Missile.SuperAtk:
		"####" ST 8 A_FaceTarget;
		"####" U 8 A_BaronAttack2();
		Goto See;
	Pain:
		"####" H  2;
		"####" H  2 A_Pain;
		Goto See;
	Death:
		"####" I  8;
		"####" J  8 A_Scream;
		"####" K  8;
		"####" L  8 A_NoBlocking;
		"####" MN 8;
		"####" O -1 A_ShinBossDeath();
		Stop;
	XDeath:
		"####" A 0 A_Jumpif((BaseSprite == GetSpriteIndex('ZBOS')), "XDeath.D1");
		BOSX A 5;
		BOSX B 5 A_XScream;
		BOSX C 5;
		BOSX D 5 A_NoBlocking();
		BOSX EFGH 5;
		BOSX I -1 A_ShinBossDeath();
		Stop;
	XDeath.D1:
		ZBSX A 5;
		ZBSX B 5 A_XScream;
		ZBSX C 5;
		ZBSX D 5 A_NoBlocking();
		ZBSX EFGH 5;
		ZBSX I -1 A_ShinBossDeath();
		Stop;
	Shin.Raise:
		"####" M 8;
		"####" LKJI  8;
		"####" A 0 A_RestoreSprite();
		Goto See;
	XRaise:
		"####" A 0 A_Jumpif((BaseSprite == GetSpriteIndex('ZBOS')), "XRaise.D1");
		BOSX H 5;
		BOSX GFEDCBA 5;
		"####" A 0 A_RestoreSprite();
		Goto See;
	XRaise.D1:
		ZBSX H 5;
		ZBSX GFEDCBA 5;
		"####" A 0 A_RestoreSprite();
		Goto See;
	}
}

Class Shin_Baronball : ShinDoom_Projectile Replaces Baronball
{
	Default
	{
		Radius 6;
		Height 16;
		Speed 15;
		FastSpeed 20;
		Damage 8;
		SeeSound "baron/attack";
		DeathSound "baron/shotx";
		Decal "BaronScorch";
	}
	States
	{
	Spawn:
		BAL7 AB 4 BRIGHT;
		Loop;
	Death:
		BAL7 CDE 6 BRIGHT;
		Stop;
	}
}

Class Shin_Baronball_Small : Shin_Baronball
{
	Default
	{
		scale 0.75;
		Damage 2;
		Seesound "knight/attack";
		Deathsound "knight/shotx";
	}
	States
	{
		Spawn:
			BALB AB 4 BRIGHT;
			Loop;
		Death:
			BALB CDE 6 BRIGHT;
			Stop;
	}
}

Class Shin_BaronBall_Big : ShinDoom_Projectile
{
	Default
	{
		Radius 10;
		Height 16;
		Speed 20;
		FastSpeed 25;
		Damage 4;
		SeeSound "baron/attack";
		DeathSound "baron/shotx";
		Decal "BaronScorch";
	}
	States
	{
	Spawn:
		BBL2 AB 4 BRIGHT;
		Loop;
	Death:
		BBL2 C 6 BRIGHT
		{
			A_SpawnProjectile ("Shin_Baronball_Small", 0, 0, 0, CMF_AIMDIRECTION, 0);
			A_SpawnProjectile ("Shin_Baronball_Small", 0, 0, 45, CMF_AIMDIRECTION, 0);
			A_SpawnProjectile ("Shin_Baronball_Small", 0, 0, 90, CMF_AIMDIRECTION, 0);
			A_SpawnProjectile ("Shin_Baronball_Small", 0, 0, 135, CMF_AIMDIRECTION, 0);
			A_SpawnProjectile ("Shin_Baronball_Small", 0, 0, 180, CMF_AIMDIRECTION, 0);
			A_SpawnProjectile ("Shin_Baronball_Small", 0, 0, 225, CMF_AIMDIRECTION, 0);
			A_SpawnProjectile ("Shin_Baronball_Small", 0, 0, 270, CMF_AIMDIRECTION, 0);
			A_SpawnProjectile ("Shin_Baronball_Small", 0, 0, 315, CMF_AIMDIRECTION, 0);
		}
		BBL2 DE 6 BRIGHT;
		Stop;
	}
}

Extend Class Shin_BaronOfHell
{
	int MissileCount;
	int InitialCount;
	
	static const name BaronSprite[] = 
    {
        'BOSS',
        'ZBOS'
    };
	
	override void PostBeginPlay()
	{
		string mapName = Level.MapName.MakeLower();
		super.PostBeginPlay();
		int i = 1;
		
		if (mapName.Left(1) == "e" && mapName.Mid(2, 1) == "m")
		{
			i = 0;
		}
		
		if (mapName == "test")
		{
			i = random(0,1);
		}

		BaseSprite = GetSpriteIndex(BaronSprite[i]);	
		sprite = BaseSprite;
		
		Return;
	}

	void A_BaronAttack()
	{
		MissileCount -= 1;
		let targ = target;
		if (targ)
		{
			if (CheckMeleeRange())
			{
				int damage = random[pr_bruisattack](1, 8) * 20;
				A_StartSound ("baron/melee", CHAN_WEAPON);
				int newdam = target.DamageMobj (self, self, damage, "Melee");
				targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			}
			else
			{
				//A_FireVolley("Baronball");
				//A_FireVolley("Baronball", 6, 50);
				A_FaceTarget();
				A_SpawnProjectile("Shin_BaronBall_Big", 35);
			}
		}
	}
	
	void A_BaronAttack2()
	{
		MissileCount = InitialCount;
		let targ = target;
		if (targ)
		{
			if (CheckMeleeRange())
			{
				int damage = random[pr_bruisattack](1, 10) * 20;
				A_StartSound ("baron/melee", CHAN_WEAPON);
				int newdam = target.DamageMobj (self, self, damage, "Melee");
				targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			}
			else
			{
				//A_FireVolley("Shin_BaronBall_Big");
				A_FireVolley("Baronball", 5, 45);
			}
		}
	}
}