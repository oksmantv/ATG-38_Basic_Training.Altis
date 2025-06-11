params ["_Terminal","_SpawnPos","_Severe",["_ShouldBleed",true,[true]],["_isAssessment",false,[false]],["_Player",objNull,[objNull]]];
private ["_TierLevel"];

switch (toLower _Severe) do {
    case "some": {
        _TierLevel = 3;
    };
    case "lot": {
        _TierLevel = 2;
    };    
    case "large": {
        _TierLevel = 2;
    };       
     case "fatal": {
        _TierLevel = 1;
    };     
    case "dead": {
        _TierLevel = 4;
    };        
    default { 
        _TierLevel = 0;
    };
};

    if(!isNull _Terminal) then {
        if ((typeOf _Terminal) isEqualTo "Land_DataTerminal_01_F") then {
            [_Terminal,3] call BIS_fnc_dataTerminalAnimate;
            playSound3D [MISSION_ROOT + "activated.wav", _Terminal];
            sleep 3.5;
        };
    };
    _previousUnit = _Terminal getVariable ["AttachedUnit",objNull];
    deleteVehicle _previousUnit;
    _Group = createGroup west;
    _Group setVariable ["GW_Gear_BlackList",true,true];
    _Group setVariable ["acex_headless_blacklist",true,true];
    _Unit = _Group createUnit ["B_Soldier_F",_SpawnPos, [], -1, "CAN_COLLIDE"];
    _Unit setVariable ["GW_Gear_BlackList",true,true];
    _Terminal setVariable ["AttachedUnit",_Unit,true];

    For "_i" from 0 to 30 do {
        _Unit addItemToUniform "ACE_ElasticBandage"
    };
    _Unit setBehaviour "CARELESS"; _Unit disableAI "MOVE";
    doStop _Unit;
    if(!isNull _Terminal) then {
            _Unit setDir (_Unit getDir _Terminal);
    } else {
        _Unit setDir (random 360);
    };
    [_Unit,_Severe,_Terminal,_IsAssessment] spawn MedicalDamage;
    if(!isNull _Terminal) then {
        if (typeOf _Terminal == "Land_DataTerminal_01_F") then {
            [_Terminal,0] call BIS_fnc_dataTerminalAnimate;
            sleep 3;
        };
    };
    
    if !(isNil "MED_MASS_READY") then {
        waitUntil {sleep 0.1; MED_MASS_READY};
        if ((typeOf _Terminal) isEqualTo "Land_InfoStand_V2_F") then {
            playSound3D [MISSION_ROOT + "whistle.wav", MedicalMass_1];
            {
                    _x setObjectTextureGlobal [0,"#(argb,8,8,3)color(0,1,0,1.0,ca)"];
            } forEach [IndicatorL_1,IndicatorL_2,IndicatorL_3,IndicatorL_4];
        };
    };

    sleep 0.5;
    [_Unit, "unarmed"] call GW_Gear_Fnc_Handler;

    if(_IsAssessment) then {
        systemChat str ["IsAssessment",_TierLevel];

        [_Unit,_TierLevel] remoteExec ["MedicalAssessment",0];

        waitUntil {sleep 1; _Unit getVariable ["AssessmentComplete",false] || _Unit getVariable ["AssessmentFailed",false]};
        
        _DiagnosedTier = _Unit getVariable ["DiagnosedTier",0];
        if(_Unit getVariable ["AssessmentComplete",false]) then {
            ["HQ","side",format["%1 completed assessment of a Tier %2 casualty.",name _Player,_TierLevel]] remoteExec ["OKS_fnc_Chat",0];
            deleteVehicle _Unit;
        } else {
            ["HQ","side",format["%1 failed assessment of a Tier %2 casualty, player selected Tier %3",name _Player,_TierLevel,_DiagnosedTier]] remoteExec ["OKS_fnc_Chat",0];
            deleteVehicle _Unit;
        };
    };