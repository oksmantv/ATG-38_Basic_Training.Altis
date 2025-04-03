Params [
	"_Player","_ArrayOfHLS","_DistanceForSmoke"
];
if(!isServer) exitWith {false};
_Player setVariable ["OKS_Transport_Task_Deactivated",true,true];
[_Player,format ["LandingTask_Main_%1",_Player], ["Description", ["Transport Duties: %1",name _Player], "MarkerName"], objNull,"CREATED",-1, false,"heli", false] call BIS_fnc_taskCreate;

// Create a copy of the Original Array of landing sites
_CurrentArrayOfHLS =+ _ArrayOfHLS;

// Timer for results between smoke pop & successful landing
_Timer = {
	Params ["_Player","_randomHLS","_Count"];
	Private _Time = 0;

	while {alive vehicle _Player} do
	{
		sleep 1;
		_Time = _Time + 1;
		if(vehicle _Player isKindOf "Helicopter" AND _Player distance2d _randomHLS < 20 AND (getPos (vehicle _Player) select 2) < 0.3) then {break};
	};
	sleep 2;
	if(Alive vehicle _Player AND vehicle _Player isKindOf "Helicopter" AND canMove vehicle _Player) then {
		["HQ","side",format["%2 - HLS %1 - Time from Smoke to landing: %3 seconds",_Count,name _Player,_Time]] remoteExec ["OKS_Chat",0];
	};
};

// If mission fails be able to teleport to airfield or cancel teleport.
// _Respawn = {
// 	Params ["_Player"];
// 	_Teleport = _Player addAction ["<t color='#11FF14'>Teleport to Airfield</t>",{(_this select 1) setPos getPos teleportBase; (_this select 1) setVariable ["TeleportActive",false,true]},nil,6,false,true,"","_this getVariable ['TeleportActive',false]"];
// 	_Cancel = _Player addAction ["<t color='#FF2911'>Cancel Teleport</t>",{ (_this select 1) setVariable ["TeleportActive",false,true]},nil,6,false,true,"","_this getVariable ['TeleportActive',false]"];
// };

// Enable smoke on HLS each 80 seconds to keep it smoked until pilot is successful
_CreateSmokeOnHLS = {
	Params ["_HLS","_Player","_Smokeshell"];
	_Pos = _HLS getPos [(5+(random 5)),(random 360)];
	while {!(vehicle _Player isKindOf "Helicopter" AND _Player distance2d _HLS < 40 AND (getPos (vehicle _Player) select 2) < 0.3)} do
	{
		if(_Player distance2d _HLS < 30) exitWith {};
		_Smoke = _Smokeshell createVehicle _Pos;
		sleep 60;
	};
};

_GetSmokeVariables = {
	_SmokeColour = selectRandom ["Yellow","Green","Blue","Purple"];
	private _Classname = "";
	switch (toLower _SmokeColour) do {
		case "yellow": {
			_Classname = "SmokeShellYellow";
		};
		case "green": {
			_Classname = "SmokeShellGreen";
		};
		case "blue": {
			_Classname = "SmokeShellBlue";
		};
		case "purple": {
			_Classname = "SmokeShellPurple";
		};
	};

	_Array = [_SmokeColour,_Classname];
	_Array
};

_CalculateCardinalDirection = {
	Params ["_Direction"];
	_Cardinal = str _Direction;
	if((_Direction >= 337.5 AND _Direction <= 360) OR (_Direction > 0 AND _Direction < 22.5)) then { _Cardinal = "North" };
	if(_Direction >= 22.5 AND _Direction < 67.5) then { _Cardinal = "North-East" };
	if(_Direction >= 67.5 AND _Direction < 112.5) then { _Cardinal = "East" };
	if(_Direction >= 112.5 AND _Direction < 157.5) then { _Cardinal = "South-East" };
	if(_Direction >= 157.5 AND _Direction < 202.5) then { _Cardinal = "South" };
	if(_Direction >= 202.5 AND _Direction < 247.5) then { _Cardinal = "South-West" };
	if(_Direction >= 247.5 AND _Direction < 292.5) then { _Cardinal = "West" };
	if(_Direction >= 292.5 AND _Direction < 360) then { _Cardinal = "North-West" };
	_Cardinal
};

// Count for Objective Id
Private _Count = 1;
Private "_Vehicle";
//_Player spawn _Respawn;

For "_i" from 0 to (count _CurrentArrayOfHLS - 1) do {

	private _nearPotentialHLSArray = _CurrentArrayOfHLS select {
		_Player distance2d _X > 2500 && _Player distance2d _X < 5000 && !(_X getVariable ["HLS_Active",false])
	};
	//systemChat str _nearPotentialHLSArray;
	private _randomHLS = selectRandom _nearPotentialHLSArray;
	_randomHLS setVariable ["HLS_Active",true,true];
	private _IngressCardinal = (getDir _randomHLS) call _CalculateCardinalDirection;
	private _EgressCardinal = (round random 360) call _CalculateCardinalDirection;

	_CurrentArrayOfHLS deleteAt(_CurrentArrayOfHLS find _randomHLS);
	[getPos _randomHLS,getDir _randomHLS] remoteExec ["CreateHLSPanels",2];
	//["HLS_Markings", getPos _randomHLS, [0,0,0], getDir _randomHLS] call LARs_fnc_spawnComp;

	_marker = createMarker [format ["oks_%2_landingMarker_marker_%1",str round(random 80000 + random 9999),_Player],getPos _randomHLS];
	_marker setMarkerType "mil_dot";
	_marker setMarkerColor "colorGreen";
	_marker setMarkerText (format["%2: HLS %1 - Ingress: %3 - Egress %4",_Count,name _Player, _IngressCardinal, _EgressCardinal]);
	_marker setMarkerShape "ICON";
	_marker setMarkerDir (getDir _randomHLS);
	_marker setMarkerSize [0.7,0.7];

	_Task = format ["LandingTaskId_%1",_Count + 1];

	_SmokeArray = call _GetSmokeVariables;
	_SmokeArray params ["_Colour","_SmokeClass"];

	[_Player, [_Task,format ["LandingTask_Main_%1",_Player]], [format["A friendly force has requested that you land at the <font color='#84e4ff'><marker name = '%1'>HLS</marker></font color>. Ingress %2, Egress %3.",_marker,_IngressCardinal,_EgressCardinal], format["Landing Zone %1",_Count], "Landing"], objNull,"ASSIGNED",-1, true,"takeoff", false] call BIS_fnc_taskCreate;
	["HQ","side",format["%5 - Requesting Landing at HLS %1. Ingress %2. Egress %3. Purple Panels. %6 smoke on HLS when within %4 meters, out!",_Count,_IngressCardinal,_EgressCardinal,_DistanceForSmoke,name _Player,_Colour]] remoteExec ["OKS_Chat",0];

	waitUntil { 
		sleep 1;
		vehicle _Player isKindOf "Helicopter" OR vehicle _Player isKindOf "Plane"
	};
	_Vehicle = vehicle _Player;
	waitUntil {
		sleep 0.5;
		//str ["Smoke Check - IsHelicopter: "+(str (vehicle _Player isKindOf "Helicopter"))+" IsInRange: "+(str (_Player distance _randomHLS < _DistanceForSmoke))+" Above 20 Altitude: "+(str (getPos (vehicle _Player) select 2 > 20))] remoteExec ["SystemChat",0];
		(
			// Vehicle is Correct, Distance is within range and helicopter is above 20m altitude
			(vehicle _Player isKindOf "Helicopter" OR vehicle _Player isKindOf "Plane") AND _Player distance _randomHLS < _DistanceForSmoke AND getPos vehicle _Player select 2 > 20
		)
		OR 
		(	
			// If Helicopter is already within distance of HLS
			vehicle _Player isKindOf "Helicopter" AND _Player distance _randomHLS < 30
		)
		OR 
		(
			// Player & Vehicle is dead or player unsonscious
			(!Alive _Vehicle) || (!Alive _Player) OR _Player GetVariable ["ACE_isUnconscious",false]
		)
	};
	if((!Alive _Vehicle) OR (!Alive _Player) OR _Player GetVariable ["ACE_isUnconscious",false]) exitWith {
		// If player and vehicle is dead set to failed and disable transport objectives.
		_Player setVariable ["OKS_Transport_Task_Deactivated",false,true];
		[_Task,"FAILED"] call BIS_fnc_taskSetState; 
		_Player setVariable ["TeleportActive",true,true];
		[_marker] remoteExec ["deleteMarker",0];
	};
	_Vehicle = vehicle _Player;
	[_Player,_randomHLS,_Count] spawn _Timer;
	[_randomHLS,_Player,_SmokeClass] spawn _CreateSmokeOnHLS;
	["HQ","side",format["HLS %1 - %2: %3 smoke out on the HLS!",_Count,name _Player,_Colour]] remoteExec ["OKS_Chat",0];
	
	waitUntil {
		sleep 0.5;
		//str ["Land Check - IsHelicopter:"+(str (vehicle _Player isKindOf "Helicopter"))+" IsWithinRange:"+(str (_Player distance _randomHLS < 20))+" On Ground: "+str (getPos (vehicle _Player) select 2 < 0.1)] remoteExec ["SystemChat",0];
		((vehicle _Player isKindOf "Helicopter" OR vehicle _Player isKindOf "Plane") AND _Player distance2d _randomHLS < 30 AND (getPos (vehicle _Player) select 2) < 0.3) OR 
		((!Alive _Vehicle) OR (!Alive _Player) OR _Player GetVariable ["ACE_isUnconscious",false]);
	};
	_Vehicle = vehicle _Player;
	_Count = _Count + 1;
	[_marker] remoteExec ["deleteMarker",0];
	
	Private _Failed = false;
	//systemChat str [str _Vehicle,str typeOf _Vehicle,str alive _Vehicle,str CanMove _Vehicle];
	if(alive _Vehicle AND CanMove _Vehicle AND (_Vehicle isKindOf "Helicopter" OR _Vehicle isKindOf "Plane")) then {
		sleep 5;
		[_Task,"SUCCEEDED"] call BIS_fnc_taskSetState;
	} else {
		_Failed = true;
	};
	if(_Failed) exitWith {
		[_Task,"FAILED"] call BIS_fnc_taskSetState;
		_Player setVariable ["TeleportActive",true,true];
	};
	_panels = _randomHLS nearObjects ["42cdo_marker_panel",15];
	{
		deleteVehicle _X;
	} foreach _panels;
	_randomHLS setVariable ["HLS_Active",false,true];
	sleep 5;
};
_Player setVariable ["OKS_Transport_Task_Deactivated",false,true];

