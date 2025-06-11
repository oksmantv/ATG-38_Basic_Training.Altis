// [_this,"lot"] execVM "Training\Medical\MedicalDamage.sqf";

params ["_Unit", "_Severe", ["_Terminal", "",[]], ["_IsAssessment",false,[false]]];
Private ["_SelectedSeverity","_lot","_large","_fatal","_dead"];

removeHeadgear _Unit;
removeVest _Unit;
removeBackpack _Unit;
removeAllWeapons _Unit;
_NoOfWounds = (round ((random [0.1, 0.25, 0.4])* 5));
_BodyPart = selectRandom ["RightLeg", "LeftLeg", "Body", "RightArm", "LeftArm"];
_Severe = toLower _Severe;

_some = 5.6;
_lot = 5.1;
_large = 4.2;
_fatal = 3.6;
_dead = selectRandom [_some,_lot,_large,_fatal];

if(_isAssessment) then {	
	_lot = _lot * 0.9;
	_large = _large * 0.9;
	_fatal = _fatal * 0.9;
};

_SelectedSeverity = _Severe;
if((toLower _Severe) isEqualTo "random") then {
	_SelectedSeverity = selectRandom["some","lot","large","fatal","dead"];
};

//systemChat format["Severity Random: %1",_SelectedSeverity];
switch (_SelectedSeverity) do {
	case "some": {
		_Unit setUnitPos "DOWN";
		_unit setVariable ["ace_medical_bloodVolume", _some, true];
		[_unit, true, 300, false] call ace_medical_fnc_setUnconscious;

		if(!(_IsAssessment)) then {
			for "_j" from 0 to 3 do {
				[_Unit, selectRandom [0.1,0.2,0.3], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				[_Unit, selectRandom [0.1,0.2,0.3], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
			[_Unit, 0.2, "Body", selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 0.05, "Head", selectRandom ["avulsion"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		};
	};

	case "lot": {
		_Unit setUnitPos "DOWN";
		_unit setVariable ["ace_medical_bloodVolume", _lot, true];
		[_unit, true] call ace_medical_fnc_setUnconscious;

		if(!(_IsAssessment)) then {
			for "_j" from 0 to 3 do {
				[_Unit, selectRandom [0.1,0.2,0.3], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				[_Unit, selectRandom [0.1,0.2,0.3], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
			[_Unit, 0.2, "Body", selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 0.05, "Head", selectRandom ["avulsion"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		};
	};

	case "large": {
		_unit setVariable ["ace_medical_bloodVolume", _large, true];
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;

		if(!(_IsAssessment)) then {		
			for "_j" from 0 to 3 do {
				[_Unit, selectRandom [0.1,0.2,0.3], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				[_Unit, selectRandom [0.1,0.2,0.3], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
			[_Unit, 0.4, "Body", selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 0.05, "Head", selectRandom ["avulsion"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		}
	};

	case "fatal": {
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;
		_unit setVariable ["ace_medical_bloodVolume", _fatal, true];
		if(!(_IsAssessment)) then {
			for "_j" from 0 to 3 do {
				[_Unit, selectRandom [0.1,0.2,0.3], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				[_Unit, selectRandom [0.1,0.2,0.3], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
			[_Unit, 0.4, "Body", selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			//[_Unit, 0.2, "Head", selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		};
		if ((typeOf _Terminal) isEqualTo "Land_InfoStand_V2_F") then {
			MED_MASS_READY = true;
		};
	};

	case "qualification": {
		_unit allowDamage false;
		_unit setVariable ["ace_medical_bloodVolume", 3.5, true];
		_Unit setUnitPos "DOWN";

		[_unit, true] call ace_medical_fnc_setUnconscious;

		for "_j" from 0 to 3 do {
			[_Unit, selectRandom [0.15,0.175,0.2], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom [0.15,0.175,0.2], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			sleep 0.1;
		};
		//[_Unit, 0.2, "Body", selectRandom ["avulsion","stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		//[_Unit, 0.25, "Body", selectRandom ["avulsion","stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, 0.15, "Body", selectRandom ["avulsion"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		//[_Unit, 0.2, "Head", selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
	};

	case "dead": {
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;
		_Unit setVariable ["ace_medical_bloodVolume", _dead];
		for "_j" from 0 to 6 do {
			_arm = selectRandom ["LeftArm", "RightArm"];
			_leg = selectRandom ["LeftLeg", "RightLeg"];
			[_Unit, 2, _leg, selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 2, _arm, selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			sleep 0.1;
		};
		[_Unit, 0.2, "Body", selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, 0.2, "Head", selectRandom ["avulsion", "stab"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
	};
};
if (_SelectedSeverity isEqualTo "dead") then {
	_Unit hideObjectGlobal false;
	_Unit setDamage 1;
};

sleep 3;
_Unit setVariable ["GOL_Qualification_Ready", true, true];
if (_SelectedSeverity in ["easy", "medium", "heavy", "lot", "large", "fatal", "dead"]) then {
	playSound3D [MISSION_ROOT + "blood_loss.wav", _Unit];
};