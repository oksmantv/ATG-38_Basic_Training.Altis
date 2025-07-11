params ["_Terminal", "_Qualifier", "_SpawnPos","_Barrier","_Level"];
private ["_TimeLimit"];

	[_Barrier,false] remoteExec ["hideObjectGlobal",2];
    if(!isNull _Terminal) then {
        [_Terminal,3] call BIS_fnc_dataTerminalAnimate;
        playSound3D [MISSION_ROOT + "activated.wav", _Terminal];
        sleep 3.5;
    };
    _previousUnits = _Terminal getVariable ["AttachedUnits",[]];
    {deleteVehicle _X} foreach _previousUnits;
    sleep 0.5;
    _Group = createGroup west;
	_Group setVariable ["GW_Gear_BlackList",true,true];
    _Group setVariable ["acex_headless_blacklist",true,true];

	if(_Level > 0) then {
   		_Unit1 = _Group createUnit ["B_Soldier_F",_SpawnPos, [], 3, "CAN_COLLIDE"];
		_Unit1 setDir (Random 360);
		_Unit1 setVariable ["GW_Gear_BlackList",true,true];
		_TimeLimit = 120;
	};
	if(_Level > 1) then {
   		_Unit2 = _Group createUnit ["B_Soldier_F",_SpawnPos, [], 3, "CAN_COLLIDE"];
		_Unit2 setDir (Random 360);
	    _Unit2 setVariable ["GW_Gear_BlackList",true,true];
		_TimeLimit = 180;
	};
	if(_Level > 2) then {
   		_Unit3 = _Group createUnit ["B_Soldier_F",_SpawnPos, [], 3, "CAN_COLLIDE"];
		_Unit3 setDir (Random 360);
	    _Unit3 setVariable ["GW_Gear_BlackList",true,true];
		_TimeLimit = 360;
	};		

	_Terminal setVariable ["AttachedUnits",units _Group, true];

	// GOL PATIENT SETUP

	GOL_PatientSetup = {

		Params ["_Unit","_SpawnPos","_Terminal","_Direction"];

		For "_i" from 0 to 30 do {
			_Unit addItemToUniform "ACE_ElasticBandage"
		};

		//[_Unit,true] remoteExec ["hideObjectGlobal",2];
		[_Unit,"CARELESS"] remoteExec ["setBehaviour",0];
		[_Unit,"MOVE"]remoteExec ["disableAI",0];
		_Unit remoteExec ["DoStop",0];

		if(!isNull _Terminal) then {
			_Unit setDir (_Unit getDir _Terminal);
		} else {
			_Unit setDir (random 360);
		};	
		[_Unit,"qualification"] execVM "Training\Medical\MedicalDamage.sqf";
		waitUntil{_Unit getVariable ["GOL_Qualification_Ready",false]};
		[_Unit, "unarmed"] call GW_Gear_Fnc_Handler
	};

	// END GOL PATIENT SETUP

	private _Dir = (random 360);
	{
		[_X,_SpawnPos,_Terminal,_Dir] spawn GOL_PatientSetup;
		_Dir = _Dir + 120;
	} forEach units _Group;

    if(!isNull _Terminal) then {
        [_Terminal,0] call BIS_fnc_dataTerminalAnimate;
    };
	sleep 3;
	//{} foreach units _Group;
	waitUntil { {_X getVariable ["GOL_Qualification_Ready",false]} count units _Group == count units _Group};
	
	// Timer
	[_Qualifier,_Group] spawn {
		Params ["_Qualifier","_Group"];
		_Time = 0;
		waitUntil {
			sleep 1;
			_Time = _Time + 1;
			_Qualifier setVariable ["GOL_Qualification_Time",_Time,true];
			{	
				_Casualty = _X;
				(([_Casualty] call ace_medical_status_fnc_getCardiacOutput > 0.07) &&
				[_Casualty] call ace_medical_status_fnc_getBloodLoss < 0.001 &&
				{
					[_Casualty, _X] call ace_medical_treatment_fnc_hasTourniquetAppliedTo
				} count ["LeftLeg","RightLeg","LeftArm","RightArm"] == 0)
				|| !Alive _Casualty
			} count units _Group == count units _Group
		};
	};

	//
	{
		[_X,false] remoteExec ["hideObjectGlobal",2];
		_X spawn {	
			_Casualty = _this;		 
			waitUntil{
				
				(([_Casualty] call ace_medical_status_fnc_getCardiacOutput > 0.07) &&
				[_Casualty] call ace_medical_status_fnc_getBloodLoss < 0.001 &&
				{
					[_Casualty, _X] call ace_medical_treatment_fnc_hasTourniquetAppliedTo
				} count ["LeftLeg","RightLeg","LeftArm","RightArm"] == 0)
				|| !Alive _Casualty
			};
			_Casualty setVariable ["GOL_Qualification_Complete",true,true];
		}		
	} forEach units _Group;
	[_Barrier,true] remoteExec ["hideObjectGlobal",2];
	playSound3D [MISSION_ROOT + "tier1.wav", _Terminal];
	["HQ","side",format["%2: Started Qualification Level %3 - Time Limit: %1",_TimeLimit,name _Qualifier,_Level]] remoteExec ["OKS_fnc_Chat",0];
	waitUntil{sleep 0.1; {_X getVariable ["GOL_Qualification_Complete",false]} count units _Group == count units _Group || {!Alive _X} count units _Group > 0};
	if({!Alive _X} count units _Group > 0) then {
		["HQ","side",format["%2: Failed Qualification - Casualty Died",(_Qualifier getVariable ["GOL_Qualification_Time",0]),name _Qualifier]] remoteExec ["OKS_fnc_Chat",0];
		playSound3D [MISSION_ROOT + "failure.wav", _Terminal];
	} else {
		_Time = (_Qualifier getVariable ["GOL_Qualification_Time",0]);
		if(_Time > _TimeLimit) then {
			["HQ","side",format["%2: Failed Qualification by %1 seconds",(_Time - _TimeLimit),name _Qualifier]] remoteExec ["OKS_fnc_Chat",0];
			playSound3D [MISSION_ROOT + "failure.wav", _Terminal];
		} else {
			// if({(_X getVariable ["GOL_CPR_COMPLETED",0]) < 2} count units _Group == count units _Group) then {
			// 	["HQ","side",format["%2: Failed Qualification in %1 seconds - Did not apply CPR at least 2 times per casualty",_Time,name _Qualifier]] remoteExec ["OKS_fnc_Chat",0];	
			// } else {
				["HQ","side",format["%2: Succeeded Qualification (Level %3) in %1 seconds",_Time,name _Qualifier,_Level]] remoteExec ["OKS_fnc_Chat",0];
				playSound3D [MISSION_ROOT + "victory.wav", _Terminal];
			//}			
		};		
	};
	
	sleep 3;
	{
		deleteVehicle _X;
	} forEach units _Group;
	_Qualifier setPosATL (_Terminal getPos [2,(_SpawnPos getDir _Terminal)]);
	_Qualifier setDir (_Qualifier getDir _Terminal);
	[_Barrier,false] remoteExec ["hideObjectGlobal",2];




