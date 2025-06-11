Params [
	"_Player","_ArrayOfTargets","_DistanceForSmoke"
];


if(!isServer) exitWith {false};
_Player setVariable ["OKS_Target_Task_Deactivated",true,true];
[_Player,format ["TargetTask_Main_%1",name _Player], ["Description", ["CAS Duties: %1",name _Player], "MarkerName"], objNull,"CREATED",-1, false,"destroy", false] call BIS_fnc_taskCreate;

// Create a copy of the Original Array of landing sites
_CurrentArrayOfTargets =+ _ArrayOfTargets;

_CreateTarget = {
	Params ["_TargetObject","_Side"];
	Private ["_Text","_Vehicle"];

	_Settings = [_Side] call OKS_fnc_Dynamic_Setting;
	_Settings Params ["_UnitArray","_SideMarker","_SideColor","_Vehicles","_Civilian","_ObjectiveTypes","_Configuration"];
	_UnitArray Params ["_Leaders","_Units","_Officer"];
	_Vehicles Params ["_Wheeled","_APC","_Tank","_Artillery","_Helicopter","_Transport","_Supply","_AntiAir"];
	_TargetTypes = ["infantry","vehicle"];


	_Group = CreateGroup _Side;
	_Vehicle = switch (selectRandom _TargetTypes) do
	{
		case "infantry":
		{
			_Text = "Infantry";
			for "_i" from 1 to (selectRandom [5,6,7]) do
			{
				Private "_Unit";
				if ( (count (units _Group)) == 0 ) then
				{
					_Unit = _Group CreateUnit [(_Leaders call BIS_FNC_selectRandom), _TargetObject getPos [(4+random 4),random 360], [], 0, "NONE"];
					_Unit setRank "SERGEANT";
				} else {
					_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), _TargetObject getPos [(4+random 4),random 360], [], 0, "NONE"];
				};
			};
		};
		case "vehicle":
		{
			_Selection = SelectRandom(SelectRandom [_Wheeled,_APC]);
			_Vehicle = _Selection createVehicle (getPos _TargetObject);
			_Text = getText (configFile >> "CfgVehicles" >> (typeOf _Vehicle) >> "displayName");
			_Group = [_Vehicle,WEST] call OKS_AddVehicleCrew;
			_Group addVehicle _Vehicle;
			[driver _Vehicle,"PATH"] remoteExec ["disableAI",0];
			[_Vehicle,true] remoteExec ["engineOn",0];
			[_Vehicle,true] remoteExec ["lock",0];
			_Vehicle
		};
	};
	if(isNil "_Vehicle") exitWith {
		[_Group,_Text]
	};
	if(true) exitWith {
		[_Group,_Text,_Vehicle]
	};
};

// Timer for results between smoke pop & successful landing
_Timer = {
	Params ["_Player","_TargetGroup","_Count","_EnemyVehicle"];
	Private _Time = 0;

	//systemChat str _EnemyVehicle;

	while {alive vehicle _Player} do
	{
		sleep 1;
		_Time = _Time + 1;
		// systemChat str [
		// 	isNull _EnemyVehicle,
		// 	{!alive _X || _X getVariable ["ACE_isUnconscious",false]} count units _TargetGroup isEqualTo count units _TargetGroup,
		// 	!isNull _EnemyVehicle,
		// 	!Alive _EnemyVehicle];
		if(isNull _EnemyVehicle && {!alive _X || _X getVariable ["ACE_isUnconscious",false]} count units _TargetGroup isEqualTo count units _TargetGroup) exitWith {
			//systemChat "Infantry Squad Destroyed";
			["HQ","side",format["%2 - Target %1 - Time from Smoke to completion: %3 seconds at distance %4 meters",_Count,name _Player,_Time,round(vehicle _Player distance (vehicle (leader _TargetGroup)))]] remoteExec ["OKS_fnc_Chat",0];
			{deleteVehicle _X} foreach units _TargetGroup;
			break;
		};
		if(!isNull _EnemyVehicle && !Alive _EnemyVehicle) exitWith {
			//systemChat "Vehicle Destroyed";
			["HQ","side",format["%2 - Target %1 - Time from Smoke to completion: %3 seconds at distance %4 meters",_Count,name _Player,_Time,round(vehicle _Player distance (vehicle (leader _TargetGroup)))]] remoteExec ["OKS_fnc_Chat",0];
			{deleteVehicle _X} foreach units _TargetGroup;
			deleteVehicle _EnemyVehicle;
			break;
		};
	};
	 
};


// Enable smoke on HLS each 80 seconds to keep it smoked until pilot is successful
_CreateSmokeOnTarget = {
	Params ["_TargetGroup","_Player"];
	_Pos = (selectRandom units _TargetGroup) getPos [(15+(random 5)),(random 360)];
	while {{Alive _X || _X getVariable ["ACE_isUnconscious",false]} count units _TargetGroup isNotEqualTo 0} do
	{
		_Smoke = "SmokeShellRed" createVehicle _Pos;
		sleep 60;
	};
};

_CalculateCardinalDirection = {
	Params ["_Direction"];
	_Cardinal = str _Direction;
	if((_Direction >= 337.5 && _Direction <= 360) || (_Direction > 0 && _Direction < 22.5)) then { _Cardinal = "North" };
	if(_Direction >= 22.5 && _Direction < 67.5) then { _Cardinal = "North-East" };
	if(_Direction >= 67.5 && _Direction < 112.5) then { _Cardinal = "East" };
	if(_Direction >= 112.5 && _Direction < 157.5) then { _Cardinal = "South-East" };
	if(_Direction >= 157.5 && _Direction < 202.5) then { _Cardinal = "South" };
	if(_Direction >= 202.5 && _Direction < 247.5) then { _Cardinal = "South-West" };
	if(_Direction >= 247.5 && _Direction < 292.5) then { _Cardinal = "West" };
	if(_Direction >= 292.5 && _Direction < 360) then { _Cardinal = "North-West" };
	_Cardinal
};

// Count for Objective Id
Private _Count = 1;
Private "_TargetGroup";

For "_i" from 0 to (count _CurrentArrayOfTargets - 1) do {

	private _nearPotentialTargetArray = _CurrentArrayOfTargets select {
		_X Distance _Player > 2500 && !(_X getVariable ["TARGET_Active",false])
	};
	_DistanceSortedTargetArray = [_nearPotentialTargetArray, [], {_x distance _Player}, "ASCEND"] call BIS_fnc_sortBy;
	private _RandomIndex = 0;
	if(count _DistanceSortedTargetArray > 10) then {
		_RandomIndex = round(random 5);
	} else {
		_RandomIndex = round (random (count _DistanceSortedTargetArray - 1));
	};

	if(_RandomIndex > (count _DistanceSortedTargetArray) - 1) then {
		_RandomIndex = 0;
	};

	private _randomTarget = _DistanceSortedTargetArray select _RandomIndex;

	if(isNil "_randomTarget") then {
		break
	};
	
	private _IngressCardinal = (getDir _randomTarget) call _CalculateCardinalDirection;
	private _EgressCardinal = (round random 360) call _CalculateCardinalDirection;

	_CurrentArrayOfTargets deleteAt(_CurrentArrayOfTargets find _randomTarget);

	_TargetObject = [_randomTarget,WEST] call _CreateTarget;
	_TargetObject Params ["_TargetGroup","_Text","_EnemyVehicle"];
	sleep 0.5;
	[_TargetGroup] remoteExec ["OKS_SetStatic",0];

	_marker = createMarker [format ["oks_%2_targetMarker_marker_%1",str round(random 80000 + random 9999),_Player],getPos _randomTarget];
	_marker setMarkerType "mil_destroy";
	_marker setMarkerColor "colorRed";
	_marker setMarkerText (format["%2: CAS %1 - Target %3 - Ingress: %4 - Egress %5",_Count,name _Player,_Text,_IngressCardinal,_EgressCardinal]);
	_marker setMarkerShape "ICON";
	_marker setMarkerDir 45;
	_marker setMarkerSize [0.8,0.8];

	if(isNull (objectParent _Player))  then {
		["HQ","side",format["Task will be given when you have occupied your selected vehicle."]] remoteExec ["OKS_fnc_Chat",0];
	};
	
	waitUntil {sleep 1; (objectParent _Player) isKindOf "Helicopter" || (objectParent _Player) isKindOf "Plane"};
	_Vehicle = vehicle _Player;
	Private _Altitude = 100;
	if(_Vehicle isKindOf "Plane") then { _DistanceForSmoke = _DistanceForSmoke + 3000; _Altitude = 100; };

	_Task = format ["TargetTaskId_%1",_Count + 1];
	[_Player, [_Task,format ["TargetTask_Main_%1",name _Player]], [format["A friendly force has requested that you strike %4 at the <font color='#84e4ff'><marker name = '%1'>target location</marker></font color>. Ingress %2, Egress %3.",_marker,_IngressCardinal,_EgressCardinal,_Text], format["CAS Target %1",_Count], "Target"], objNull,"ASSIGNED",-1, true,"attack", false] call BIS_fnc_taskCreate;
	["HQ","side",format["%5 - Requesting CAS. Ingress %2. Egress %3. Red smoke & laser on %6 when within %4 meters and at minimum altitude of %7 meters, out!",_Text,_IngressCardinal,_EgressCardinal,_DistanceForSmoke,name _Player,_Text,_Altitude]] remoteExec ["OKS_fnc_Chat",0];


	waitUntil {
		sleep 0.5;
		//str ["Smoke Check - IsHelicopter: "+(str (vehicle _Player isKindOf "Helicopter"))+" IsInRange: "+(str (_Player distance _randomHLS < _DistanceForSmoke))+" Above 20 Altitude: "+(str (getPos (vehicle _Player) select 2 > 20))] remoteExec ["SystemChat",0];
		(
			(vehicle _Player isKindOf "Helicopter" || vehicle _Player isKindOf "Plane") && _Player distance _randomTarget < _DistanceForSmoke && getPos vehicle _Player select 2 > _Altitude
		) || (!Alive _Vehicle || !Alive _Player) || {!Alive _X || (_X getVariable ["ACE_isUnconscious",false])} count units _TargetGroup isEqualTo count units _TargetGroup
	};

	if(!Alive _Vehicle || !Alive _Player) exitWith {
		[_Task,"FAILED"] call BIS_fnc_taskSetState;
		_Player setVariable ["TeleportActive",true,true];
		deleteVehicle vehicle leader _TargetGroup;
		{deleteVehicle _X} foreach units _TargetGroup;
		[_marker] remoteExec ["deleteMarker",0];
	};

	if(isNil "_EnemyVehicle") then {
		_EnemyVehicle = objNull;
	} else {
		_EnemyVehicle reveal [_Player,4];
	};
	
	_TargetGroup reveal [_Player,4];
	[_Player,_TargetGroup,_Count,_EnemyVehicle] spawn _Timer;
	[_TargetGroup,_Player] spawn _CreateSmokeOnTarget;
	[_TargetGroup,_EnemyVehicle,_Vehicle,_Player,_randomTarget] spawn {

		Params ["_TargetGroup","_EnemyVehicle","_Vehicle","_Player","_randomTarget"];
		
		[vehicle _player,true] remoteExec ["setVehicleReceiveRemoteTargets",0];
		if(!isNull _EnemyVehicle) then {
			_randomTarget = _EnemyVehicle;
			//SystemChat "Selected Enemy Vehicle as Target.";
		} else {
			_randomTarget = leader _TargetGroup;
			//SystemChat "Selected Group Leader as Target.";
		};
		
		_laser = createVehicle ["LaserTargetW" , _randomTarget, [], 0, "CAN_COLLIDE"];
		[side _Player,[_laser, 3600]] remoteExec ["reportRemoteTarget",0];
		[_laser,[side _Player, true]] remoteExec ["confirmSensorTarget",0];

		//systemChat ("Attaching Target to " + str _randomTarget);
		_laser attachTo [_randomTarget,[0,0,0]];
		waitUntil {sleep 0.1; 
			// systemChat str [
			// 	{!Alive _X || (_X getVariable ["ACE_isUnconscious",false])} count units _TargetGroup isEqualTo count units _TargetGroup,
			// 	!isNull _EnemyVehicle,
			// 	!Alive _EnemyVehicle
			// ];
			(!(isNull _EnemyVehicle) && !Alive _EnemyVehicle) || {!Alive _X || (_X getVariable ["ACE_isUnconscious",false])} count units _TargetGroup isEqualTo count units _TargetGroup
		};
		//systemChat "Laser deleted. Target Destroyed";
		deleteVehicle _laser;		
	};

	//[side _Player,[_laser, 600]] remoteExec ["reportRemoteTarget",0];
	//[_laser,[side _Player, true]] remoteExec ["confirmSensorTarget",0];

	sleep 5;

	["HQ","side",format["%2 - Target %1: Red smoke & laser on the target!",_Count,name _Player]] remoteExec ["OKS_fnc_Chat",0];
	_Vehicle = vehicle _Player;

	if !(isNull _EnemyVehicle) then {
		waitUntil {
			sleep 0.5;
			// SystemChat str [
			// 	{!alive _X || _X getVariable ["ACE_isUnconscious",false]} count crew _EnemyVehicle isEqualTo (count crew _EnemyVehicle),
			// 	!Alive _EnemyVehicle,
			// 	!Alive _Vehicle,
			// 	!Alive _Player
			// ];
			//systemChat str[{!alive _X || _X getVariable ["ACE_isUnconscious",false]} count crew _EnemyVehicle isEqualTo (count crew _EnemyVehicle),!Alive _Vehicle,!Alive _EnemyVehicle];
			(({!alive _X || _X getVariable ["ACE_isUnconscious",false]} count crew _EnemyVehicle isEqualTo (count crew _EnemyVehicle) || !Alive _EnemyVehicle) || (!Alive _Vehicle || !Alive _Player));
		};
	} else {
		waitUntil {
			sleep 0.5;
			//SystemChat str [_TargetGroup,_Vehicle];
			// systemChat str [
			// 	{!alive _X || (_X getVariable ["ACE_isUnconscious",false])} count units _TargetGroup isEqualTo (count units _TargetGroup),
			// 	!Alive _Vehicle,
			// 	!Alive _Player
			// ];
			({!alive _X || (_X getVariable ["ACE_isUnconscious",false])} count units _TargetGroup isEqualTo (count units _TargetGroup) || (!Alive _Vehicle || !Alive _Player));
		};
	};

	_Count = _Count + 1;
	[_marker] remoteExec ["deleteMarker",0];
	Private _Failed = false;
	//systemChat str [str _Vehicle,str typeOf _Vehicle,str alive _Vehicle,str CanMove _Vehicle];
	if(alive _Vehicle && CanMove _Vehicle && (_Vehicle isKindOf "Helicopter" || _Vehicle isKindOf "Plane")) then {
		sleep 5;
		[_Task,"SUCCEEDED"] call BIS_fnc_taskSetState;
	} else {
		_Failed = true;
	};
	if(alive _Player && _Failed) exitWith {
		[_Task,"FAILED"] call BIS_fnc_taskSetState;
		_Player setVariable ["TeleportActive",true,true];
		deleteVehicle vehicle leader _TargetGroup;
		{deleteVehicle _X} foreach units _TargetGroup;
	};
	_randomTarget setVariable ["TARGET_Active",false,true];
	sleep 5;
};
_Player setVariable ["OKS_Target_Task_Deactivated",false,true];

