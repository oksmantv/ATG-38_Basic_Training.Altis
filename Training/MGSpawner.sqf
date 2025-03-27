Params ["_Object","_Player","_Target","_Positions","_Count","_Heavy"];
playSound3D [MISSION_ROOT + "activated.wav", _Object];
// [[Arrow_1,Arrow_2,Arrow_3]] execVM "3DReportSpawner.sqf";

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

_Statics = [
	"rhsgref_ins_DSHKM_Mini_TriPod",
	"LOP_BH_Landrover_M2",
	"LOP_TKA_UAZ_DshKM",
	"rhsgref_BRDM2_HQ_vmf"
];

private ["_SelectedPosition","_Unit","_Group","_HeavyNumber","_Static"];
_Group = createGroup EAST;

For "_i" from 0 to (_Count - 1) do {

	while {true} do {
		_SelectedPosition = selectRandom _Positions;
		if(_SelectedPosition NearEntities ["Man", 2] isEqualTo []) exitWith {};
	};

	if(_Heavy) then {
		_HeavyNumber = (round(random _Count - 1));
	};
	_Unit = _Group CreateUnit [(_Units call BIS_FNC_selectRandom), [0,0,0], [], -1, "NONE"];
	_Unit setCombatMode "BLUE";
	_Unit setUnitPos "UP";
	_Unit disableAI "PATH";
	_Unit setPosATL _SelectedPosition;
	_Unit setDir (_Unit getDir _Target);

	if(_Count == _HeavyNumber && (_SelectedPosition select 2 < 1)) then {
		_Static = createVehicle [selectRandom _Statics, _SelectedPosition, [], 0, "NONE"];
		_Static setDir (_Static getDir _Target);
		_Unit moveInGunner _Static;
		_Unit setBehaviour "COMBAT";
		_Static reveal [_Target,4];
		[_Static,_Target] spawn {

		Params ["_Vehicle","_Target"];
		while {Alive _Vehicle} do {
			_Vehicle doWatch _Target;
			_Vehicle doTarget _Target;
			_Vehicle reveal [_Target,4];
			if (needReload _Vehicle == 1) then { reload _Vehicle; sleep 3.5; };
			_Vehicle selectWeaponTurret [(weapons _Vehicle select 0),[0]];
			_Vehicle fire currentMuzzle (gunner _Vehicle);
			(sleep 0.15 + (random 0.85))
		}
	};
	} else {
		_Unit doWatch _Target;
		_Unit doTarget _Target;
		_Unit reveal [_Target,4];
		_Unit spawn {
			while {alive _this} do {
				_this fire PrimaryWeapon _this;
				sleep 0.4;
			}
		};
	};

	waitUntil {sleep 1; (!(Alive _Unit) || !([_Unit] call ace_common_fnc_isAwake))};
	sleep 5;
	deleteVehicle vehicle _Unit;
	deleteVehicle _Unit;
};

private _Names = "";
private _i = 1;
private _CourseNumber = str _Target select [((count (str _Target)) - 1)];
{
	if(_i != (count units group _player)) then {
		_Names = _Names + name _X;
		if(count units group _Player > 2) then {
			_Names = _Names + ", ";	
		}
	} else {
		_Names = _Names + " and " + name _X;
	};
	_i = _i + 1;
} foreach units group _Player;
format["%1 has completed MG course number %2.",_Names,_CourseNumber] remoteExec ["systemChat",0];


