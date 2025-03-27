params ["_Unit", "_Severe", ["_Terminal", "",[]], ["_IsAssessment",false,[false]]];
Private ["_SelectedSeverity","_lot","_large","_fatal","_dead"];

removeHeadgear _Unit;
removeVest _Unit;
removeBackpack _Unit;
removeAllWeapons _Unit;
_NoOfWounds = (round ((random [0.1, 0.25, 0.4])* 10));
_BodyPart = selectRandom ["RightLeg", "LeftLeg", "Body", "RightArm", "LeftArm"];
_Severe = toLower _Severe;

_lot = 5.1;
_large = 4.2;
_fatal = 3.6;
_dead = random [3.5,4,4.5];

if(_isAssessment) then {	
	_lot = _lot * 0.8;
	_large = _large * 0.8;
	_fatal = _fatal * 0.8;
};

_SelectedSeverity = _Severe;
if((toLower _Severe) isEqualTo "random") then {
	_SelectedSeverity = selectRandom["easy","medium","heavy","lot","large","fatal","dead"];
};

//systemChat format["Severity Random: %1",_SelectedSeverity];
switch (_SelectedSeverity) do {
	case "easy": {
		if(!(_IsAssessment)) then {
			[_Unit, selectRandom[0, Random[0.4, 0.6, 1]], selectRandom["RightLeg","LeftLeg"], selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom[0, Random[0.4, 0.6, 1]], "Body", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom[0, 0.3], "head", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom[0, Random[0.4, 0.6, 1]], selectRandom["RightArm","LeftArm"], selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		};
		For "_i" from 0 to _NoOfWounds do {
			[_unit, Random[0.1, 0.4, 0.6], _BodyPart, selectrandom ["stab", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			sleep 0.1;
		};
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;
	};

	case "medium": {

		if(!(_IsAssessment)) then {
			[_Unit, selectRandom[0.2, Random[0.6, 1, 1.5]], "RightLeg", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom[0.2, Random[0.6, 1, 1.5]], "LeftLeg", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom[0.4, Random[0.6, 1, 1.5]], "Body", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom[0, 0.3], "head", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom[0.6, Random[0.6, 1, 1.5]], "RightArm", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom[0.6, Random[0.6, 1, 1.5]], "LeftArm", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			
			if (_BodyPart == "Body" && _NoOfWounds > 2) then {
				_NoOfWounds = 2
			};
			For "_i" from 0 to _NoOfWounds do {
				[_unit, Random[0.5, 0.75, 1.5], _BodyPart, selectrandom ["stab", "bullet", "falling"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
		};
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;
	};

	case "heavy": {

		[_Unit, selectRandom[0.5, Random[1.5, 2.4, 3]], "RightLeg", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, selectRandom[0.5, Random[1.6, 2.4, 3]], "LeftLeg", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, selectRandom[0, Random[1.5, 1.6, 2.5]], "Body", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, selectRandom[0, 0.3], "head", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, selectRandom[0.5, Random[1.7, 2.4, 3]], "RightArm", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, selectRandom[0.5, Random[1.7, 2.4, 3]], "LeftArm", selectrandom ["stab", "bullet", "grenade"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];

		if (_BodyPart == "Body" && _NoOfWounds > 2) then {
			_NoOfWounds = 2
		} else {
			_NoOfWounds = _NoOfWounds + 2
		};
		For "_i" from 0 to _NoOfWounds do {
			[_unit, Random[1, 2.1, 3], _BodyPart, selectrandom ["stab", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			sleep 0.1;
		};
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;
	};

	case "lot": {
		_Unit setUnitPos "DOWN";
		_unit setVariable ["ace_medical_bloodVolume", _lot, true];
		[_unit, true] call ace_medical_fnc_setUnconscious;

		if(!(_IsAssessment)) then {
			for "_j" from 0 to 2 do {
				[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
			[_Unit, 0.4, "Body", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 0.2, "Head", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		};
	};

	case "large": {
		_unit setVariable ["ace_medical_bloodVolume", _large, true];
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;
		for "_j" from 0 to 2 do {
			[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			sleep 0.1;
		};
		[_Unit, 0.4, "Body", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, 0.2, "Head", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
	};

	case "fatal": {
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;
		_unit setVariable ["ace_medical_bloodVolume", _fatal, true];
		sleep 1;

		if(!(_IsAssessment)) then {
			for "_j" from 0 to 2 do {
				[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
				sleep 0.1;
			};
			[_Unit, 0.4, "Body", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 0.2, "Head", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		};
		if ((typeOf _Terminal) isEqualTo "Land_InfoStand_V2_F") then {
			MED_MASS_READY = true;
		};
	};

	case "qualification": {
		_unit setVariable ["ace_medical_bloodVolume", 3.5, true];
		_Unit setUnitPos "DOWN";

		[_unit, true] call ace_medical_fnc_setUnconscious;

		for "_j" from 0 to 2 do {
			[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftLeg", "RightLeg"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, selectRandom [0.25,0.5,0.75], selectRandom ["LeftArm", "RightArm"], selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			sleep 0.1;
		};
		[_Unit, 0.4, "Body", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, 0.2, "Head", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
	};

	case "dead": {
		_Unit setUnitPos "DOWN";
		[_unit, true] call ace_medical_fnc_setUnconscious;
		_Unit setVariable ["ace_medical_bloodVolume", _dead];
		for "_j" from 0 to 6 do {
			_arm = selectRandom ["LeftArm", "RightArm"];
			_leg = selectRandom ["LeftLeg", "RightLeg"];
			[_Unit, 2, _leg, selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			[_Unit, 2, _arm, selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
			sleep 0.1;
		};
		[_Unit, 0.2, "Body", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
		[_Unit, 0.2, "Head", selectRandom ["avulsion", "bullet"]] remoteExec ["ace_medical_fnc_addDamageToUnit", 2];
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