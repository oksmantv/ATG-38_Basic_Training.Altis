
Params ["_ActionBox","_SpawnPosition"];

_ActionBox addAction ["<t color='#ce2ef8'>-Random Casualty-</t>", {[((_this select 3) select 0),((_this select 3) select 1),"Random"] remoteExec ["MedicalPatient",2];},[_ActionBox,_SpawnPosition]];
_ActionBox addAction ["<t color='#fbed16'>Lost some blood</t>", {[((_this select 3) select 0),((_this select 3) select 1),"some"] remoteExec ["MedicalPatient",2];},[_ActionBox,_SpawnPosition]];
_ActionBox addAction ["<t color='#FFA500'>Lost a lot of blood</t>", {[((_this select 3) select 0),((_this select 3) select 1),"lot"] remoteExec ["MedicalPatient",2];},[_ActionBox,_SpawnPosition]];
_ActionBox addAction ["<t color='#ff5703'>Lost a large amount of blood</t>", {[((_this select 3) select 0),((_this select 3) select 1),"large"] remoteExec ["MedicalPatient",2];},[_ActionBox,_SpawnPosition]];
_ActionBox addAction ["<t color='#9c0303'>Lost a fatal amount of blood</t>", {[((_this select 3) select 0),((_this select 3) select 1),"fatal"] remoteExec ["MedicalPatient",2];},[_ActionBox,_SpawnPosition]];
_ActionBox addAction ["<t color='#000000'>Dead</t>", {[((_this select 3) select 0),((_this select 3) select 1),"dead"] remoteExec ["MedicalPatient",2];},[_ActionBox,_SpawnPosition]];
//_ActionBox addAction ["<t color='#FF0000'>Delete Patient", { { if(!isPlayer _X) then {deleteVehicle _X}} foreach (((_this select 3) select 0) nearEntities 10)},[_SpawnPosition]];
/*
waitUntil {sleep 1; _Unit getVariable ["AssessmentComplete",false] || _Unit getVariable ["AssessmentFailed",false]};
if(_Unit getVariable "AssessmentComplete" isEqualTo true) then {
	SystemChat "Complete";
} else {
    SystemChat "Failed";
};