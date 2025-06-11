
// [TerminalAssess_1,getPos player] spawn MedicalAssessmentActions;

Params ["_ActionBox","_SpawnPosition"];

_ActionBox addAction ["<t color='#ce2ef8'>Initiate Casualty Assessment</t>", {
	[
		((_this select 3) select 0),
		((_this select 3) select 1),
		selectRandom["some","dead","lot","large","fatal"],
		false,
		true,
		(_this select 1)
	] remoteExec ["MedicalPatient",2];
	},
	[
		_ActionBox,
		_SpawnPosition
	]
];

//_ActionBox addAction ["<t color='#FF0000'>Delete Patient", { { if(!isPlayer _X) then {deleteVehicle _X}} foreach (((_this select 3) select 0) nearEntities 10)},[_SpawnPosition]];
/*
waitUntil {sleep 1; _Unit getVariable ["AssessmentComplete",false] || _Unit getVariable ["AssessmentFailed",false]};
if(_Unit getVariable "AssessmentComplete" isEqualTo true) then {
	SystemChat "Complete";
} else {
    SystemChat "Failed";
};