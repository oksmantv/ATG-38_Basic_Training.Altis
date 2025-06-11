Params [
	"_Player","_ArrayOfHLS"
];

if(!isServer) exitWith {false};

Private _Group = group _Player;
Private _NameOfPlayers = "";
{
	_X setCaptive false;
	_NameOfPlayers = _NameOfPlayers + format["%1 ",name _X];
} foreach units _Group;

_TaskHistory = _Group getVariable ["TaskCount",0];
_TaskHistory = _TaskHistory + 1;
_Group setVariable ["TaskCount",_TaskHistory,true];

_MainTask = format ["FacTask_Main_%1_%2",_Player,_TaskHistory];
["hq","side",format["%1 started FAC tasks - %2",groupId (group _Player),_NameOfPlayers]] remoteExec ["OKS_fnc_Chat",0];
_Group setVariable ["ReadyForNextTask",true,true];
_Group setVariable ["OKS_FAC_Task_Active",true,true];
[_Group, _MainTask, ["This task will continue to loop until you return to base using the action available to the person initiating the tasks. When you arrive at the HLS, call in the helicopter and once the helicopter has landed, the task will be complete and you will have access to another action called 'Ready for next HLS'. Use it to teleport to the next task.", ["FAC Duties %2: %1",(groupId (group _Player)),_TaskHistory], "MarkerName"], objNull,"CREATED",-1, false,"map", false] call BIS_fnc_taskCreate;
[_MainTask,"CREATED",true] call BIS_fnc_taskSetState;	
_CurrentArrayOfHLS =+ _ArrayOfHLS;

Private _Count = 0;
Private "_Vehicle";

For "_i" from 0 to (count _CurrentArrayOfHLS - 1) do {
	waitUntil {sleep 5; _Group getVariable ["ReadyForNextTask",false] isEqualTo true || !(_Group getVariable ["OKS_FAC_Task_Active",true])};
	if(!(_Group getVariable ["OKS_FAC_Task_Active",true])) exitWith {
		[_MainTask,"CANCELED"] call BIS_fnc_taskSetState;	
		"The FAC Course has been deactivated. Return to the airbase to restart." remoteExec ["systemChat",units group _Player];
	};
	private _nearPotentialHLSArray = _CurrentArrayOfHLS select {
		_Player distance2d _X > 2500 && _Player distance2d _X < 5000 && !(_X getVariable ["HLS_Active",false])
	};

	private _randomHLS = selectRandom _nearPotentialHLSArray;
	_randomHLS setVariable ["HLS_Active",true,true];
	{
		_X setPos (_randomHLS getPos [random 5,random 360]);
	} foreach units _Group;
	_CurrentArrayOfHLS deleteAt(_CurrentArrayOfHLS find _randomHLS);

	_Count = _Count + 1;
	_TaskHistory = _Group getVariable ["TaskCount",0];
	_Task = format ["FacTaskId_%1_%2",_TaskHistory,_Count];
	//systemChat str [_TaskHistory,_Count];
	_marker = createMarker [format["FacTaskMarker_%1_%2_%3",_Count,_randomHLS,_Player],getPos _randomHLS];
	[_Group, [_Task,_MainTask], [format["You have been tasked with ordering a helicopter to land at the following <font color='#84e4ff'><marker name = '%1'>HLS</marker></font color>.",_marker], format["Setup HLS #%1",_Count], "Landing"], getMarkerPos _marker,"ASSIGNED",-1, false,"takeoff", false] call BIS_fnc_taskCreate;
	[_Task,"ASSIGNED"] call BIS_fnc_taskSetState;	
	waitUntil {
		sleep 5;
		!(_Group getVariable ["OKS_FAC_Task_Active",true]) OR
		{
			(vehicle _X isKindOf "Helicopter") AND
			(vehicle _X) distance _randomHLS < 400 AND
			(getPos (vehicle _X)) select 2 < 0.5 AND
			speed (vehicle _X) < 0.5
		} count AllPlayers > 0
	};

	if(!(_Group getVariable ["OKS_FAC_Task_Active",true])) exitWith {
		_randomHLS setVariable ["HLS_Active",false,true];
		[_Task,"CANCELED"] call BIS_fnc_taskSetState;
		[_MainTask,"CANCELED"] call BIS_fnc_taskSetState;	
		_Group setVariable ["ReadyForNextTask",true,true];
		[_marker] remoteExec ["deleteMarker",0];
	};
	_Player = (AllPlayers select {
		(vehicle _X isKindOf "Helicopter") AND
		(vehicle _X) distance _randomHLS < 400 AND
		(getPos (vehicle _X)) select 2 < 0.5 AND
		speed (vehicle _X) < 0.5
	}) select 0;
			
	if(
		alive (vehicle _Player) AND
		CanMove (vehicle _Player) AND
		(vehicle _Player) isKindOf "Helicopter"
		OR (vehicle _Player) isKindOf "Plane"
	) then {
		sleep 5;
		[_Task,"SUCCEEDED"] call BIS_fnc_taskSetState;
	} else {
		[_Task,"FAILED"] call BIS_fnc_taskSetState;
	};
	_randomHLS setVariable ["HLS_Active",false,true];
	sleep 5;
	_Group setVariable ["ReadyForNextTask",false,true];
};
_Group setVariable ["OKS_FAC_Task_Active",false,true];

