
if (hasInterface) then {
	_condition = { true };
    _conditionTeleport = { true };
    _conditionReady = { 
		//!(group player) getVariable ["ReadyForNextTask",false]
		true
	};
	_codeReady =
	{
		(group _Player) setVariable ["ReadyForNextTask",true,true];	
		"You are set to ready for next FAC Tasking. Standby for Teleport." remoteExec ["systemChat",(units group _Player)];
	};
	_codeTeleport =
	{
		"You have teleported to the airbase." remoteExec ["systemChat",(units group _Player)];
		{
			_X setPos (teleportbase getPos [random 5,random 360]);
		} foreach units (group _Player);
	};

	_action = ["FAC_Actions", "FAC Actions","\a3\ui_f\data\igui\cfg\simpletasks\types\Radio_ca.paa", {},_condition] call ace_interact_menu_fnc_createAction;
	_ReadyForNext = ["ReadyNext", "Ready for next HLS","\a3\ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa", _codeReady, _conditionReady] call ace_interact_menu_fnc_createAction;
	_TeleportBase = ["TeleportBase", "Return to Base","\a3\ui_f\data\IGUI\Cfg\Actions\returnflag_ca.paa", _codeTeleport, _conditionTeleport] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;
	[typeof player, 1, ["ACE_SelfActions","FAC_Actions","ReadyNext"], _ReadyForNext] call ace_interact_menu_fnc_addActionToClass;
	[typeof player, 1, ["ACE_SelfActions","FAC_Actions","TeleportBase"], _TeleportBase] call ace_interact_menu_fnc_addActionToClass;
};

