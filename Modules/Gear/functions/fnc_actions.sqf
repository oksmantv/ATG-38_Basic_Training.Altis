/*
	Author: GuzzenVonLidl
	Sets the addactions for gearbox

	Usage:
	[player, "sl"] call GW_Gear_Fnc_Actions;

	Arguments:
	0: Unit <OBJECT>

	Return Value: NO

	Public: No
*/
#include "script_Component.hpp"
#define	bullShit nil,1,false,false,"",""
#define	ALL nil,1,false,false,"","!(((_this getVariable ['GOL_SelectedRole',['']]) select 0) in ['pl','sl','ftl','g','ar','mmg','fac'])"
#define	GL nil,1,false,false,"","(((_this getVariable ['GOL_SelectedRole',['']]) select 0) in ['pl','sl','ftl','g','fac'])"
#define	LMG nil,1,false,false,"","(((_this getVariable ['GOL_SelectedRole',['']]) select 0) in ['ar','mmg'])"
params [["_unit", objNull, [objNull]]];

_ArsenalAllowed = missionNamespace getVariable ["ARSENAL_ALLOW",true];
_GroundRolesAllowed = missionNamespace getVariable ["GroundRoles_ALLOW",true];
_AirRolesAllowed = missionNamespace getVariable ["AirRoles_ALLOW",true];

if(_ArsenalAllowed isEqualTo true) then {
	_unit addAction ["<t color='#00EAFF'>Attachment Menu</t>", {[_this select 0, player] call ace_arsenal_fnc_openBox},ALL,5];
	_unit addAction ["<t color='#00EAFF'>Attachment Menu (GL)</t>", {_ArsenalGL =  missionNamespace getVariable [format["GOL_ArsenalGL_%1",(side group player)], objNull]; [_ArsenalGL, player] call ace_arsenal_fnc_openBox},GL,5];
	_unit addAction ["<t color='#00EAFF'>Attachment Menu (LMG)</t>", {_ArsenalLMG = missionNamespace getVariable [format["GOL_ArsenalLMG_%1",(side group player)], objNull]; [_ArsenalLMG, player] call ace_arsenal_fnc_openBox},LMG,5];
};

_unit addAction ["<t color='#ff962c'>Remove Night gear</t>", {
	player unassignItem "ACE_NVG_Gen4_Black";
	player removeItem "ACE_NVG_Gen4_Black";
	if (true) then {
		player removeItem "ACE_IR_Strobe_Item";
		player removeItem "ACE_Flashlight_XL50";
		player removeMagazines  "ACE_40mm_Flare_green";
		player removeMagazines  "ACE_40mm_Flare_red";
		player removeMagazines  "ACE_40mm_Flare_white";
		player removeMagazines  "ACE_HandFlare_Green";
		player removeMagazines  "ACE_HandFlare_Red";
		player removeMagazines  "ACE_HandFlare_White";
		player removeMagazines  "ACE_HandFlare_Yellow";
		player removeMagazines  "rhs_VG40OP_green";
		player removeMagazines  "rhs_VG40OP_red";
	};
},nil,1,false,false,"","!((((getUnitLoadout player) select 9) select 5) isEqualTo '')",5];

_unit addAction ["<t color='#ffb400'>Platoon > Actual</t>","[player,'pl'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#ffb400'>Platoon > Platoon Medic</t>","[player,'pm'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#ffb400'>Platoon > Forward Air Controller</t>","[player,'fac'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#ffb400'>Platoon > Drone Operator</t>","[player,'drone'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#2eff2e'>Squad > Squad Leader</t>","[player,'sl'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#2eff2e'>Squad > Squad Medic</t>","[player,'sm'] call GW_Gear_Fnc_Handler;",bullShit,4];

_unit addAction ["<t color='#2eff2e'>Squad > Fire Team Leader</t>","[player,'ftl'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#ff3737'>Squad > Rifleman</t>","[player,'r'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#ff3737'>Squad > Grenadier</t>","[player,'g'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#6a9fff'>Squad > Asst. Gunner</t>","[player,'ag'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#6a9fff'>Squad > Automatic Rifleman</t>","[player,'ar'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#6a9fff'>Special > Asst. Medium Machine Gunner</t>","[player,'ammg'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#6a9fff'>Special > Medium Machine Gunner</t>","[player,'mmg'] call GW_Gear_Fnc_Handler;",bullShit,4];
_unit addAction ["<t color='#FDF916'>Squad > Vehicle Crew</t>","[player,'crew'] call GW_Gear_Fnc_Handler;",bullShit,4];

if(_GroundRolesAllowed isEqualTo true) then {
	_unit addAction ["<t color='#FDF916'>Special > Dragon</t>","[player,'dragon'] call GW_Gear_Fnc_Handler;",bullShit,4];
	_unit addAction ["<t color='#FDF916'>Special > Light Rifleman</t>","[player,'lr'] call GW_Gear_Fnc_Handler;",bullShit,4];
	_unit addAction ["<t color='#FDF916'>Special > Ammo Bearer</t>","[player,'ab'] call GW_Gear_Fnc_Handler;",bullShit,4];
	_unit addAction ["<t color='#FDF916'>Special > Anti-Air</t>","[player,'aa'] call GW_Gear_Fnc_Handler;",bullShit,4];
	_unit addAction ["<t color='#FDF916'>Special > Asst. Heavy AT</t>","[player,'amat'] call GW_Gear_Fnc_Handler;",bullShit,4];
	_unit addAction ["<t color='#FDF916'>Special > Heavy AT</t>","[player,'mat'] call GW_Gear_Fnc_Handler;",bullShit,4];
};

//_unit addAction ["Special > Diver","[player,'diver'] call GW_Gear_Fnc_Handler;",bullShit,4];
//_unit addAction ["Special > UAV Operator","[player,'uav'] call GW_Gear_Fnc_Handler;",bullShit,4];

_unit addAction ["<t color='#22B9FF'>Echo > Chopper Pilot</t>","[player,'p'] call GW_Gear_Fnc_Handler;",bullShit,4];

if(_AirRolesAllowed isEqualTo true) then {
	_unit addAction ["<t color='#22B9FF'>Echo > Para-Rescueman</t>","[player,'pj'] call GW_Gear_Fnc_Handler;",bullShit,4];
	_unit addAction ["<t color='#22B9FF'>Echo Special > Jet Pilot</t>","[player,'jetp'] call GW_Gear_Fnc_Handler;",bullShit,4];
	_unit addAction ["<t color='#22B9FF'>Echo Special > Marksman</t>","[player,'marksman'] call GW_Gear_Fnc_Handler;",bullShit,4];
};