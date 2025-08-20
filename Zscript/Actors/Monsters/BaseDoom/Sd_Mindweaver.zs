
Class Shin_Mindweaver : ShinDoom_Actor
{
	Default
	{
		Health 500;
		Radius 64;
		Height 64;
		Speed 8;
		PainChance 40;
		ReactionTime 8;
		Mass 600;
		Scale 1.3;
		Monster;
		Species "Mindweaver";
		SeeSound "Mindweaver/sight";
		ActiveSound "Mindweaver/Active";
		PainSound "Mindweaver/pain";
		AttackSound "Mindweaver/attack";
		DeathSound "Mindweaver/death";
		ActiveSound "Mindweaver/active";
		ShinDoom_Actor.FootstepSound "Mindweaver/step";
		Obituary "$OB_ID24MINDWEAVER";
		Tag "$FN_ID24MINDWEAVER";
		Species "Mindweaver";
	}
	
	States
	{
	Spawn:
		CSPI AB 8 A_Look;
		Loop;
	See:
		CSPI A 20;
		CSPI A 2 A_Footstep();
		CSPI B 2 A_MindWalk();
		CSPI BCC 2 A_Chase;
		CSPI D 2 A_Footstep();
		CSPI D 2 A_Chase;
		CSPI E 2 A_MindWalk();
		CSPI EFF 2 A_Chase;
		Goto See+1;
	Missile:
		CSPI A 20 A_FaceTarget;
		CSPI H 2 BRIGHT A_SPosAttackUseAtkSound;
		CSPI G 2 BRIGHT A_FaceTarget;
		CSPI H 1 BRIGHT A_SpidRefire;
		Goto Missile+1;
	Pain:
		CSPI I 3;
		CSPI I 3 A_Pain;
		Goto See+1;
	Death:
		CSPI J 1;
		CSPI J 19 A_Scream;
		CSPI K 7 A_NoBlocking;
		CSPI LMNO 7 bright;
		CSPI P -1;
		Stop;
	XDeath:
		Stop;
    Raise:
		Stop;
	}
}

Class Shin_MindweaverALT : Shin_Mindweaver
{
	Default
	{
		Scale 0.65;
		//Scale 0.53;
	}
	States
	{
	Spawn:
		SPID AB 8 A_Look;
		Loop;
	See:
		SPID A 20;
		SPID A 2 A_Footstep();
		SPID B 2 A_MindWalk();
		SPID BCC 2 A_Chase;
		SPID D 2 A_Footstep();
		SPID D 2 A_Chase;
		SPID E 2 A_MindWalk();
		SPID EFF 2 A_Chase;
		Goto See+1;
	Missile:
		SPID A 20 A_FaceTarget;
		SPID H 2 BRIGHT A_SPosAttackUseAtkSound;
		SPID G 2 BRIGHT A_FaceTarget;
		SPID H 1 BRIGHT A_SpidRefire;
		Goto Missile+1;
	Pain:
		SPID I 3;
		SPID I 3 A_Pain;
		Goto See+1;
	Death:
		SPID J 1;
		SPID J 19 A_Scream;
		SPID K 7 A_NoBlocking;
		SPID MOPR 7 bright;
		SPID S -1;
		Stop;
	XDeath:
		Stop;
    Raise:
		Stop;
	}
}

Class Shin_DeadMindweaver : Shin_Mindweaver
{
	Default { -COUNTKILL +NEVERRESPAWN }
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
			Goto Super::Death+7;
	}
}

extend class Shin_Mindweaver 
{	
	Void A_MindWalk()
	{
		A_Chase();
		A_Startsound("Mindweaver/walk", CHAN_AUTO);
	}
}	