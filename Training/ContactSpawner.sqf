Params ["_Spawn","_Interval","_Trigger"];

// [Spawn_1,0,6] execVM "ContactSpawner.sqf";

_Units = [
	"O_Soldier_A_F",
	"O_Soldier_AR_F",
	"O_Soldier_AR_F",
	"O_medic_F",
	"O_medic_F",
	"O_Soldier_GL_F",
	"O_HeavyGunner_F",
	"O_soldier_M_F",
	"O_Soldier_F",
	"O_Soldier_F",
	"O_Soldier_F",
	"O_Soldier_LAT_F"
];
private ["_Unit"];

While {!triggerActivated _Trigger} do {

	if(triggerActivated _Trigger) exitWith {false};
	sleep (round random _Interval);
	if(!triggerActivated _Trigger) then {
		_Group = createGroup EAST;
		_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), getPos _Spawn, [], -1, "NONE"];
		_Unit setCombatMode "RED";
		_Unit setUnitPos "UP";
		_Unit disableAI "FSM";

		waitUntil {sleep 0.1; !isNil "lambs_wp_fnc_moduleRush"};
		[_Group,500,15,[],[],true] spawn lambs_wp_fnc_taskRush;
	};
	if(triggerActivated _Trigger) exitWith {false};
	waitUntil {sleep 1; !(Alive _Unit) || !([_Unit] call ace_common_fnc_isAwake)}
};

