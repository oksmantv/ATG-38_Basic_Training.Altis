// [_this,3] spawn MedicalAssessment;
// [_this,3] execVM  "Medical\MedicalAssessment.sqf";

Params ["_Unit","_CurrentTier"];
_Unit setVariable ["AssessmentTier",_CurrentTier,true];
if (hasInterface) then {
    _condition = { true }; //<only works MP
	_code1 =
	{
		Params ["_Unit","_Caller","_Array"];		
		_DiagnosedTier = 1;
		_Unit setVariable ["DiagnosedTier",_DiagnosedTier,true];
		_CurrentTier = _Unit getVariable ["AssessmentTier",0];
		
		if(_CurrentTier isEqualTo _DiagnosedTier) then {
			_Unit setVariable ["AssessmentComplete",true,true];
		} else {
			_Unit setVariable ["AssessmentFailed",true,true];
		}	
	};
	_code2 =
	{
		Params ["_Unit","_Caller","_Array"];		
		_DiagnosedTier = 2;
		_Unit setVariable ["DiagnosedTier",_DiagnosedTier,true];		
		_CurrentTier = _Unit getVariable ["AssessmentTier",0];		
		if(_CurrentTier isEqualTo _DiagnosedTier) then {
			_Unit setVariable ["AssessmentComplete",true,true];
		} else {
			_Unit setVariable ["AssessmentFailed",true,true];
		}		
	};
	_code3 =
	{
		Params ["_Unit","_Caller","_Array"];
		_DiagnosedTier = 3;
		_Unit setVariable ["DiagnosedTier",_DiagnosedTier,true];		
		_CurrentTier = _Unit getVariable ["AssessmentTier",0];		
		if(_CurrentTier isEqualTo _DiagnosedTier) then {
			_Unit setVariable ["AssessmentComplete",true,true];
		} else {
			_Unit setVariable ["AssessmentFailed",true,true];
		}	
	};
	_code4 =
	{
		Params ["_Unit","_Caller","_Array"];
		_DiagnosedTier = 4;
		_Unit setVariable ["DiagnosedTier",_DiagnosedTier,true];		
		_CurrentTier = _Unit getVariable ["AssessmentTier",0];		
		if(_CurrentTier isEqualTo _DiagnosedTier) then {
			_Unit setVariable ["AssessmentComplete",true,true];
		} else {
			_Unit setVariable ["AssessmentFailed",true,true];
		}			
	};			

    _action = ["Assess_Main", "Medical Triage","Scripts\NEKY_supply\ui\medical_cross.paa", {}, _condition] call ace_interact_menu_fnc_createAction;
    _CheckSeverity1 = ["Assess_1", "Tier 1","\a3\ui_f\data\igui\cfg\simpletasks\types\Heal_ca.paa", _code1, _condition] call ace_interact_menu_fnc_createAction;
    _CheckSeverity2 = ["Assess_2", "Tier 2","\a3\ui_f\data\igui\cfg\simpletasks\types\Heal_ca.paa", _code2, _condition] call ace_interact_menu_fnc_createAction;
    _CheckSeverity3 = ["Assess_3", "Tier 3","\a3\ui_f\data\igui\cfg\simpletasks\types\Heal_ca.paa", _code3, _condition] call ace_interact_menu_fnc_createAction;
    _CheckSeverity4 = ["Assess_4", "Tier 4","\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa", _code4, _condition] call ace_interact_menu_fnc_createAction;

    [_Unit, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
    [_Unit, 0, ["ACE_MainActions","Assess_Main"], _CheckSeverity1] call ace_interact_menu_fnc_addActionToObject;
    [_Unit, 0, ["ACE_MainActions","Assess_Main"], _CheckSeverity2] call ace_interact_menu_fnc_addActionToObject;
    [_Unit, 0, ["ACE_MainActions","Assess_Main"], _CheckSeverity3] call ace_interact_menu_fnc_addActionToObject;
    [_Unit, 0, ["ACE_MainActions","Assess_Main"], _CheckSeverity4] call ace_interact_menu_fnc_addActionToObject;
};


