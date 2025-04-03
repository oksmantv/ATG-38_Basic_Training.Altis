/*

    [
        [basicpeelterminal_1,basicpeelterminal_2],
        [basicpeelflag_1, basicpeelflag_2],
        [
            basicpeeltarget_1, basicpeeltarget_2, basicpeeltarget_3, basicpeeltarget_4, 
            basicpeeltarget_5, basicpeeltarget_6, basicpeeltarget_7
        ]
    ] spawn OKS_Peeling;

*/

Params ["_Terminals","_Flags","_Targets"];
// Actions to setVariable.
{
    _X addAction
    [
        "<t color='#1bd82a'>Activate Peeling Targets</t>",	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script
            missionNamespace setVariable ["OKS_BasicPeel_Active",true,true];
            "Basic Peeling Course Activated." remoteExec ["SystemChat",0];
        },
        nil,		// arguments
        2,		// priority
        true,		// showWindow
        true,		// hideOnUse
        "",			// shortcut
        "!(missionNameSpace getVariable ['OKS_BasicPeel_Active',false])",		// condition
        10,			// radius
        false,		// unconscious
        "",			// selection
        ""			// memoryPoint
    ];
    _X addAction
    [
        "<t color='#c93c0c'>Deactivate Peeling Targets</t>",	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script
            missionNamespace setVariable ["OKS_BasicPeel_Active",false,true];
            "Basic Peeling Course Deactivated." remoteExec ["SystemChat",0];
        },
        nil,		// arguments
        1.9,		// priority
        true,		// showWindow
        true,		// hideOnUse
        "",			// shortcut
        "(missionNameSpace getVariable ['OKS_BasicPeel_Active',false])",		// condition
        10,			// radius
        false,		// unconscious
        "",			// selection
        ""			// memoryPoint
    ];    
} foreach _Terminals;

GOL_SpawnPeelingContact = {

};

_MainTrigger = createTrigger ["EmptyDetector", getpos (selectRandom _Terminals)];
_MainTrigger setTriggerArea [0, 0, 0, false];
_MainTrigger setTriggerActivation ["NONE", "PRESENT", true];
_MainTrigger setTriggerStatements ["false", "hint 'trigger on'", "hint 'trigger off'"];

// Actions on Flags to teleport.
{
    _X addAction
    [
        "Teleport to Base",	// title
        {
            params ["_target", "_caller", "_actionId", "_arguments"]; // script
            _caller setPos (BaseTeleport getPos [random 6,random 360]);
        },
        nil,		// arguments
        1.5,		// priority
        true,		// showWindow
        true,		// hideOnUse
        "",			// shortcut
        "true",		// condition
        10,			// radius
        false,		// unconscious
        "",			// selection
        ""			// memoryPoint
    ];    
} foreach _Flags;

if(isServer) then {
    // Loop to check if Variable active, spawn if active.
    while {true} do {
        waitUntil {sleep 5; missionNameSpace getVariable ['OKS_BasicPeel_Active',false]};
        if(missionNameSpace getVariable ['OKS_BasicPeel_Active',false]) then {
            if(!(missionNameSpace getVariable ['OKS_BasicPeel_Live',false])) then {
                missionNameSpace setVariable ['OKS_BasicPeel_Live',true,true];
                "Basic Peel Course is live." remoteExec ["systemChat",0];
                {
                    [_X,"rush",1,east,500,[],_MainTrigger, 30] spawn OKS_Lambs_Spawner;
                    sleep 10;
                } foreach _Targets;
            };
        } else {
            missionNameSpace setVariable ['OKS_BasicPeel_Live',false,true];
            _MainTrigger setTriggerStatements ["true", "hint 'trigger on'", "hint 'trigger off'"];

            waitUntil {sleep 1; triggerActivated _MainTrigger};
            _MainTrigger setTriggerStatements ["false", "hint 'trigger on'", "hint 'trigger off'"];
        };
        sleep 10;
    };
};