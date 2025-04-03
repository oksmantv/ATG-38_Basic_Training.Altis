	MISSION_ROOT = call { private "_arr"; _arr = toArray __FILE__; _arr resize (count _arr - 8); toString _arr};

	/* Set GOL Mission Settings */
	OKS_MissionSettings = Compile PreProcessFileLineNumbers "MissionSettings.sqf";
	if(isServer) then {
		[] remoteExec ["OKS_MissionSettings",0]
	};
	Sleep 5;

	execVM "Scripts\GOL_PlayerSetup\init.sqf";
	execVM "Scripts\OKS_Vehicles\Init.sqf";	
	if(GOL_NEKY_SERVICESTATION isEqualTo 1) then { execVM "Scripts\NEKY_ServiceStation\Init.sqf"};
	if(GOL_NEKY_AIRDROP isEqualTo 1) then {	execVM "Scripts\NEKY_AirDrop\Init.sqf"};
	if(GOL_NEKY_HUNT isEqualTo 1) then { execVM "Scripts\NEKY_Hunt\Init.sqf"};
	if(GOL_OKS_AMBIENCE isEqualTo 1) then { execVM "Scripts\OKS_Ambience\Init.sqf"};
	if(GOL_OKS_SPAWN isEqualTo 1) then { execVM "Scripts\OKS_Spawn\Init.sqf"};
	if(GOL_OKS_DYNAMIC isEqualTo 1) then { execVM "Scripts\OKS_Dynamic\Init.sqf"};
	if(GOL_NEKY_TASK isEqualTo 1) then { execVM "Scripts\NEKY_Tasks\Init.sqf"};	
	if(GOL_OKS_TASK isEqualTo 1) then { execVM "Scripts\OKS_TASK\Init.sqf"};

	execVM "Training\FAC_Teleport.sqf";
	execVM "Training\Init.sqf";
	execVM "Training\Medical\Init.sqf";

	
	if(isServer) then {	
		OKS_Landing_Array_Server = [];
		OKS_Target_Array_Server = [];
		//MainScreen setObjectTextureGlobal [0,"Images\mission.jpg"];
	};

	OKS_Landing_Array = [h_2,h_3,h_4,h_5,h_6,h_7,h_8,h_9,h_10,h_11,h_12,h_13,h_14,h_15,h_16,h_17,h_18,h_19,h_20,h_21,h_22,h_23,h_24,h_25,h_26,h_27,h_28,h_29,h_30,h_31,h_32,h_33,h_34,h_35,h_1,h_36,h_37,h_38,h_39,h_40,h_41,h_42,h_43,h_44,h_45,h_46,h_47,h_48,h_49,h_50,h_51];
	OKS_Target_Array = [t_35,t_1,t_2,t_3,t_4,t_5,t_6,t_7,t_8,t_9,t_10,t_11,t_12,t_13,t_14,t_15,t_16,t_17,t_18,t_19,t_20,t_21,t_22,t_23,t_24,t_25,t_26,t_27,t_28,t_29,t_30,t_31,t_32,t_33,t_34,t_36,t_37,t_38,t_39];

	CreateHLSPanels = compile preprocessFileLineNumbers "Training\CreateHLSPanels.sqf";
	OKS_TransportTask = compile preprocessFileLineNumbers "Training\AddLandingTask.sqf";
	OKS_TargetTask = compile preprocessFileLineNumbers "Training\AddTargetTask.sqf";
	OKS_FacTask = compile preprocessFileLineNumbers "Training\AddFacTask.sqf";
	//execVM "Scripts\AddFacTeleport.sqf";

	MainScreen addAction ["<t color='#FEB000'>Request Transport Tasks</t>",{ [(_this select 1),OKS_Landing_Array,2000] remoteExec ["OKS_TransportTask",2]}, nil, 1,false, true, "","!(_this getVariable ['OKS_Transport_Task_Deactivated',false])",15];
	MainScreen addAction ["<t color='#FF0000'>Request CAS Tasks</t>",{ [(_this select 1),OKS_Target_Array,2500] remoteExec ["OKS_TargetTask",2]}, nil, 1,false, true, "","!(_this getVariable ['OKS_Target_Task_Deactivated',false])",15];
	MainScreen addAction ["<t color='#26B2E4'>Request FAC Tasks</t>",{ [(_this select 1),OKS_Landing_Array] remoteExec ["OKS_FacTask",2]}, nil, 1,false, true, "","!(_this getVariable ['OKS_FAC_Task_Deactivated',false])",15];
	SecondaryScreen addAction ["<t color='#FEB000'>Request Transport Tasks</t>",{ [(_this select 1),OKS_Landing_Array,2000] remoteExec ["OKS_TransportTask",2]}, nil, 1,false, true, "","!(_this getVariable ['OKS_Transport_Task_Deactivated',false])",15];
	SecondaryScreen addAction ["<t color='#FF0000'>Request CAS Tasks</t>",{ [(_this select 1),OKS_Target_Array,2500] remoteExec ["OKS_TargetTask",2]}, nil, 1,false, true, "","!(_this getVariable ['OKS_Target_Task_Deactivated',false])",15];
	SecondaryScreen addAction ["<t color='#26B2E4'>Request FAC Tasks</t>",{ [(_this select 1),OKS_Landing_Array] remoteExec ["OKS_FacTask",2]}, nil, 1,false, true, "","!(_this getVariable ['OKS_FAC_Task_Deactivated',false])",15];

	[helo_1, getpos helospawn_1, getDir helospawn_1, ["helicopter"]] execVM "Training\VehicleRequest.sqf";
	[helo_2, getpos helospawn_2, getDir helospawn_2, ["helicopter"]] execVM "Training\VehicleRequest.sqf";
	[helo_3, getpos helospawn_3, getDir helospawn_3, ["helicopter"]] execVM "Training\VehicleRequest.sqf";
	[plane_1, getpos planespawn_1, getDir planespawn_1, ["plane"]] execVM "Training\VehicleRequest.sqf";
	[plane_2, getpos planespawn_2, getDir planespawn_2, ["plane"]] execVM "Training\VehicleRequest.sqf";
	[plane_3, getpos planespawn_3, getDir planespawn_3, ["plane"]] execVM "Training\VehicleRequest.sqf";