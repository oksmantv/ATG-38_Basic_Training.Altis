// [getPos vehicle player, getDir Vehicle player] execVM "Scripts\CreateHLSPanels.sqf";

Params ["_Position","_Direction"];

_CenterPanel = createVehicle ["42cdo_marker_panel", _Position, [], 0, "CAN_COLLIDE"];
_CenterPanel setDir _Direction;

_ForwardPanel = createVehicle ["42cdo_marker_panel", _Position getPos [5,_Direction], [], 0, "CAN_COLLIDE"];
_ForwardPanel setDir _Direction;

_LeftPanel = createVehicle ["42cdo_marker_panel", _Position getPos [5,(_Direction - 140)], [], 0, "CAN_COLLIDE"];
_LeftPanel setDir (_Direction - 140);

_RightPanel = createVehicle ["42cdo_marker_panel", _Position getPos [5,(_Direction + 140)], [], 0, "CAN_COLLIDE"];
_RightPanel setDir (_Direction + 140);