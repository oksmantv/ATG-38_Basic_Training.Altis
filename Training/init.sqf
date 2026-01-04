// [] execVM "Training\init.sqf";

// Global Commands
execVM "Training\CompoundBreach\init.sqf";

// Marksman Course
OKS_Marksman_Debug = false;
publicVariable "OKS_Marksman_Debug";

OKS_Marksman_Qualification_Action = compile preprocessFileLineNumbers "Training\MarksmanQualification\OKS_Marksman_Qualification_Action.sqf";
OKS_Marksman_Qualification_Function = compile preprocessFileLineNumbers "Training\MarksmanQualification\OKS_Marksman_Qualification_Function.sqf";
OKS_Marksman_Qualification_Target = compile preprocessFileLineNumbers "Training\MarksmanQualification\OKS_Marksman_Qualification_Target.sqf";
OKS_Marksman_Qualification_WeaponSelect = compile preprocessFileLineNumbers "Training\MarksmanQualification\OKS_Marksman_Qualification_WeaponSelect.sqf";

MGSpawner = compile preprocessFileLineNumbers "Training\MGSpawner.sqf";
LauncherGear = compile preprocessFileLineNumbers "Training\LauncherGear.sqf";
AA_Spawner = compile preprocessFileLineNumbers "Training\AA_Spawner.sqf";
AT_Spawner = compile preprocessFileLineNumbers "Training\AT_Spawner.sqf";
AT_Static_Spawner = compile preprocessFileLineNumbers "Training\AT_Static_Spawner.sqf";
AI_Death = compile preprocessFileLineNumbers "Training\AI_Death.sqf";
CQB_Garrison = compile preprocessFileLineNumbers "Training\CQB_Garrison.sqf";
OKS_PlaySound = compile preprocessFileLineNumbers "Training\OKS_PlaySound.sqf";
DryRunCode = compile preprocessFileLineNumbers "Training\DryRunCode.sqf";
LiveRunCode = compile preprocessFileLineNumbers "Training\LiveRunCode.sqf";
3DReportSpawner = compile preprocessFileLineNumbers "Training\3DReportSpawner.sqf";
3DReportAction = compile preprocessFileLineNumbers "Training\3DReportAction.sqf";
OKS_Peeling = compile preprocessFileLineNumbers "Training\OKS_Peeling.sqf";
MedicalQualificationPatients = compile preprocessFileLineNumbers "Training\Medical\MedicalQualificationPatients.sqf";

// Global disable for Pop-Up Targets.
boundPopup = [];
nopop = true;

// Live Targets
OKS_LiveTargets = {
	Params ["_TargetArray"];
	{
		_Pos = [getPosATL _X select 0,getPosATL _X select 1,(getPosATL _X select 2 + 0.5)];		
		_Dir = ((getDir _X) - 180);
		_Group = createGroup east;
		_Group setVariable ["hc_blacklist",true];
		_Group setVariable ["lambs_danger_disableAI", true];
		_Unit = _Group createUnit ["O_Soldier_F", [0,0,0], [], 0, "CAN_COLLIDE"];
		_Unit setPosATL _Pos;
		_Unit setDir _Dir;
		_Unit disableAI "PATH";
		_Unit setUnitPos "UP";
		_X hideObjectGlobal true
	} foreach _TargetArray;
};

OKS_CourseReset = {
	Params ["_Input"];
	//SystemChat str _Input;
	_Input Params ["_TargetArray","_Trigger"];
	
	{_X hideObject false} foreach _TargetArray;
	{_x animate ["Terc",0];} forEach _TargetArray;
	{_x addEventHandler ["HIT",
		{
			(_this select 0) animate ["Terc",1];
			(_this select 0) RemoveEventHandler ["HIT",0]
		}
	]} forEach _TargetArray;

	{ if(!isPlayer _X) then { deleteVehicle _X} } foreach list _Trigger;
	{ if(_X inArea _Trigger) then { deleteVehicle _X} } foreach allDeadMen;
};

// CQB Exercise
// [Dense_1] execVM "Training\Dense_CQB_Action.sqf";
// execVM "Training\DryRun_Action.sqf";
// execVM "Training\CQB_Actions.sqf";

object_1 addAction ["<t color='#eb4034'>Initiate Targets</t>",
	{
		[_this select 0,_this select 1,Target_1,
			[
				MGSPAWN_Course1_Target1, MGSPAWN_Course1_Target10,
				MGSPAWN_Course1_Target11, MGSPAWN_Course1_Target12,
				MGSPAWN_Course1_Target13, MGSPAWN_Course1_Target14,
				MGSPAWN_Course1_Target15, MGSPAWN_Course1_Target16, 
				MGSPAWN_Course1_Target17, MGSPAWN_Course1_Target18, 
				MGSPAWN_Course1_Target19, MGSPAWN_Course1_Target2, 
				MGSPAWN_Course1_Target20, MGSPAWN_Course1_Target21, 
				MGSPAWN_Course1_Target22, MGSPAWN_Course1_Target3, 
				MGSPAWN_Course1_Target4, MGSPAWN_Course1_Target5, 
				MGSPAWN_Course1_Target6, MGSPAWN_Course1_Target7, 
				MGSPAWN_Course1_Target8, MGSPAWN_Course1_Target9
			],
			3,
			true
		] remoteExec ["MGSpawner",2];
	},nil,1.5,true,true,"","_this distance _target < 10", 15,false,"",""
];
object_2 addAction ["<t color='#eb4034'>Initiate Targets</t>",
	{
		[_this select 0,_this select 1,Target_2,
			[
				MGSPAWN_Course2_Target1, 
				MGSPAWN_Course2_Target10, 
				MGSPAWN_Course2_Target11, 
				MGSPAWN_Course2_Target12, 
				MGSPAWN_Course2_Target13, 
				MGSPAWN_Course2_Target14, 
				MGSPAWN_Course2_Target15, 
				MGSPAWN_Course2_Target16, 
				MGSPAWN_Course2_Target17, 
				MGSPAWN_Course2_Target18, 
				MGSPAWN_Course2_Target19, 
				MGSPAWN_Course2_Target2, 
				MGSPAWN_Course2_Target20, 
				MGSPAWN_Course2_Target21, 
				MGSPAWN_Course2_Target22, 
				MGSPAWN_Course2_Target23, 
				MGSPAWN_Course2_Target24, 
				MGSPAWN_Course2_Target25, 
				MGSPAWN_Course2_Target26, 
				MGSPAWN_Course2_Target3, 
				MGSPAWN_Course2_Target4, 
				MGSPAWN_Course2_Target5, 
				MGSPAWN_Course2_Target6, 
				MGSPAWN_Course2_Target7, 
				MGSPAWN_Course2_Target8, 
				MGSPAWN_Course2_Target9
			],
			3,
			true
		] remoteExec ["MGSpawner",2];
	},nil,1.5,true,true,"","_this distance _target < 10", 15,false,"",""
];	
object_3 addAction ["<t color='#eb4034'>Initiate Targets</t>",
	{
		[_this select 0,_this select 1,Target_3,
			[
				MGSPAWN_Course3_Target1, 
				MGSPAWN_Course3_Target10, 
				MGSPAWN_Course3_Target11, 
				MGSPAWN_Course3_Target12, 
				MGSPAWN_Course3_Target13, 
				MGSPAWN_Course3_Target14, 
				MGSPAWN_Course3_Target15, 
				MGSPAWN_Course3_Target16, 
				MGSPAWN_Course3_Target17, 
				MGSPAWN_Course3_Target18, 
				MGSPAWN_Course3_Target18_1, 
				MGSPAWN_Course3_Target18_2, 
				MGSPAWN_Course3_Target18_3, 
				MGSPAWN_Course3_Target18_4, 
				MGSPAWN_Course3_Target18_5, 
				MGSPAWN_Course3_Target18_6, 
				MGSPAWN_Course3_Target18_7, 
				MGSPAWN_Course3_Target2, 
				MGSPAWN_Course3_Target3, 
				MGSPAWN_Course3_Target4, 
				MGSPAWN_Course3_Target5, 
				MGSPAWN_Course3_Target6, 
				MGSPAWN_Course3_Target7, 
				MGSPAWN_Course3_Target8, 
				MGSPAWN_Course3_Target9
			],
			3,
			true
		] remoteExec ["MGSpawner",2];
	},nil,1.5,true,true,"","_this distance _target < 10", 15,false,"",""
];	
object_4 addAction ["<t color='#eb4034'>Initiate Targets</t>",
	{
		[_this select 0,_this select 1,Target_4,
			[
				MGSPAWN_Course4_Target1, 
				MGSPAWN_Course4_Target10, 
				MGSPAWN_Course4_Target11, 
				MGSPAWN_Course4_Target12, 
				MGSPAWN_Course4_Target13, 
				MGSPAWN_Course4_Target14, 
				MGSPAWN_Course4_Target15, 
				MGSPAWN_Course4_Target16, 
				MGSPAWN_Course4_Target17, 
				MGSPAWN_Course4_Target18, 
				MGSPAWN_Course4_Target2, 
				MGSPAWN_Course4_Target3, 
				MGSPAWN_Course4_Target4, 
				MGSPAWN_Course4_Target5, 
				MGSPAWN_Course4_Target6, 
				MGSPAWN_Course4_Target7, 
				MGSPAWN_Course4_Target8, 
				MGSPAWN_Course4_Target9
			],
			3,
			true
		] remoteExec ["MGSpawner",2];
	},nil,1.5,true,true,"","_this distance _target < 10", 15,false,"",""
];	
object_5 addAction ["<t color='#eb4034'>Initiate Targets</t>",
	{
		[_this select 0,_this select 1,Target_5,
			[
				MGSPAWN_Course5_Target1, 
				MGSPAWN_Course5_Target10, 
				MGSPAWN_Course5_Target11, 
				MGSPAWN_Course5_Target12, 
				MGSPAWN_Course5_Target13, 
				MGSPAWN_Course5_Target14, 
				MGSPAWN_Course5_Target15, 
				MGSPAWN_Course5_Target16, 
				MGSPAWN_Course5_Target17, 
				MGSPAWN_Course5_Target18, 
				MGSPAWN_Course5_Target2, 
				MGSPAWN_Course5_Target3, 
				MGSPAWN_Course5_Target4, 
				MGSPAWN_Course5_Target5, 
				MGSPAWN_Course5_Target6, 
				MGSPAWN_Course5_Target7, 
				MGSPAWN_Course5_Target8, 
				MGSPAWN_Course5_Target9
			],
			3,
			true
		] remoteExec ["MGSpawner",2];
	},nil,1.5,true,true,"","_this distance _target < 10", 15,false,"",""
];	
object_6 addAction ["<t color='#eb4034'>Initiate Targets</t>",
	{
		[_this select 0,_this select 1,Target_6,
			[
				MGSPAWN_Course6_Target1, 
				MGSPAWN_Course6_Target10, 
				MGSPAWN_Course6_Target11, 
				MGSPAWN_Course6_Target12, 
				MGSPAWN_Course6_Target13, 
				MGSPAWN_Course6_Target14, 
				MGSPAWN_Course6_Target15, 
				MGSPAWN_Course6_Target16, 
				MGSPAWN_Course6_Target17, 
				MGSPAWN_Course6_Target18, 
				MGSPAWN_Course6_Target19, 
				MGSPAWN_Course6_Target2, 
				MGSPAWN_Course6_Target20, 
				MGSPAWN_Course6_Target3, 
				MGSPAWN_Course6_Target4, 
				MGSPAWN_Course6_Target5, 
				MGSPAWN_Course6_Target6, 
				MGSPAWN_Course6_Target7, 
				MGSPAWN_Course6_Target8, 
				MGSPAWN_Course6_Target9
			],
			3,
			true
		] remoteExec ["MGSpawner",2];
	},nil,1.5,true,true,"","_this distance _target < 10", 15,false,"",""
];	

object_7 addAction ["<t color='#eb4034'>Initiate Targets</t>",
	{
		[_this select 0,_this select 1,Target_7,
			[
				MGSPAWN_Course7_Target1, 
				MGSPAWN_Course7_Target10, 
				MGSPAWN_Course7_Target11, 
				MGSPAWN_Course7_Target12, 
				MGSPAWN_Course7_Target13, 
				MGSPAWN_Course7_Target14, 
				MGSPAWN_Course7_Target15, 
				MGSPAWN_Course7_Target16, 
				MGSPAWN_Course7_Target17, 
				MGSPAWN_Course7_Target18, 
				MGSPAWN_Course7_Target19, 
				MGSPAWN_Course7_Target2, 
				MGSPAWN_Course7_Target20, 
				MGSPAWN_Course7_Target21, 
				MGSPAWN_Course7_Target22, 
				MGSPAWN_Course7_Target3, 
				MGSPAWN_Course7_Target4, 
				MGSPAWN_Course7_Target5, 
				MGSPAWN_Course7_Target6, 
				MGSPAWN_Course7_Target7, 
				MGSPAWN_Course7_Target8, 
				MGSPAWN_Course7_Target9
			],
			3,
			true
		] remoteExec ["MGSpawner",2];
	},nil,1.5,true,true,"","_this distance _target < 10", 15,false,"",""
];	

// AT Range
OKS_AT_Spawn_Active = false; sleep 1;
[AT_Range_PC,"<t color='#2acb1f'>Activate Range</t>","OKS_AT_Spawn_Active",false,false,true,"OKS_AT_Spawn_Active == false"] execVM "Scripts\OKS_Task\NEKY_AddAction.sqf"; sleep 1;
[AT_Range_PC,"<t color='#2acb1f'>Deactivate Range</t>","OKS_AT_Spawn_Active",false,false,false,"OKS_AT_Spawn_Active == true"] execVM "Scripts\OKS_Task\NEKY_AddAction.sqf"; sleep 1;

// AA Range
OKS_AA_Spawn_Active = false; sleep 1;
[AT_Range_PC,"<t color='#1A98FD'>Activate Range (Air)</t>","OKS_AA_Spawn_Active",false,false,true,"OKS_AA_Spawn_Active == false"] execVM "Scripts\OKS_Task\NEKY_AddAction.sqf"; sleep 1; 
[AT_Range_PC,"<t color='#1A98FD'>Deactivate Range (Air)</t>","OKS_AA_Spawn_Active",false,false,false,"OKS_AA_Spawn_Active == true"] execVM "Scripts\OKS_Task\NEKY_AddAction.sqf";


sleep 20;

[
	[basicpeelterminal_1,basicpeelterminal_2],
	[basicpeelflag_1, basicpeelflag_2],
	[
		basicpeeltarget_1, basicpeeltarget_2, basicpeeltarget_3, basicpeeltarget_4, 
		basicpeeltarget_5, basicpeeltarget_6, basicpeeltarget_7
	]
] spawn OKS_Peeling;

if(isServer) then {
	[ATSpawn_1,ATWP_1,ATEnd_1,east,[6,90]] spawn AT_Spawner;
	[ATSpawn_2,ATWP_2,ATEnd_2,east,[6,90]] spawn AT_Spawner;
	[ATSpawn_3,ATWP_3,ATEnd_3,east,[6,90]] spawn AT_Spawner;
	[AirStart_1,AirEnd_1,east] spawn AA_Spawner;
	[AirStart_2,AirEnd_2,east] spawn AA_Spawner;	
	[AirStart_3,AirEnd_3,east] spawn AA_Spawner;

	{
		[_X,east,15] spawn AT_Static_Spawner;
	} foreach [
		static_1, static_10, static_11, static_12, static_13, static_14, static_15,
		static_16, static_17, static_18, static_19, static_2, static_20, static_21,
		static_22, static_23, static_24, static_25, static_26, static_3, static_4,
		static_5, static_6, static_7, static_8, static_9
	];
};