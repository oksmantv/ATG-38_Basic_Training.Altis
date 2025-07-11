_useMineDetector = false;
_allowedNightStuff = true;

_glHE = "rhs_VOG25";
_glHEDP = "rhs_VOG25";
_glsmokeW = "rhs_GRD40_White";
_glsmokeB = "";
_glsmokeG = "rhs_GRD40_Green";
_glsmokeO = "";
_glsmokeP = "";
_glsmokeR = "rhs_GRD40_Red";
_glsmokeY = "";

_glflareG = "rhs_VG40OP_green";
_glflareR = "rhs_VG40OP_red";
_glflareW = "rhs_VG40OP_white";

_insignia = "";
_goggles = "G_Armband_red_alt_F";
_helmet = ["rhs_6b47","rhs_6b47_bare","rhs_6b47_6m2","rhs_6b47_6m2_1","rhs_6b47_bala","rhs_6b47_6B50"];
_OfficerHelmet = "rhs_6b7_1m_ess";
_uniform = "rhs_uniform_emr_patchless";
_vest = ["rhs_6b2_chicom","rhs_6b2_lifchik","rhs_6b2_RPK","rhs_6b45_rifleman","rhs_6b43","rhs_6b5"];
_backpack = "rhs_rd54_emr1";
_backpackRadio = _backpack;

if (true) then {
	_backpackRadio = "UK3CB_B_O_Tactical_Backpack_Radio";
};

if(_role isEqualTo "officer") then {
	_helmet = "rhs_6b7_1m_ess";
	_uniform = "rhs_uniform_vdv_emr";
	_goggles = "G_Armband_red_F";
	_vest = "rhs_6b23_digi_6sh92_vog_headset";
	_backpackRadio = "rhs_r148";
	_backpack = "rhs_r148";
};

if(_role in ["ag","ammg"]) then {
	_backpack = "rhs_tortila_olive";
};
if (_role isEqualTo "p") then {
	_helmet = "rhs_altyn_novisor_ess_bala";
};

if (_role isEqualTo "uav") then {
	_backpack = "O_UAV_01_backpack_F";
	_gps = "O_UAVTerminal";

};
if (_role isEqualTo "jetp") then {
	_goggles = "G_Aviator";
	_helmet = "H_PilotHelmetFighter_B";
	_uniform = "U_B_PilotCoveralls";
	_vest = "V_Rangemaster_belt";
	_backpack = "B_Parachute";
};

if (_role isEqualTo "crew") then {
	_Helmet = "rhs_6b48";
};


_silencer = "rhs_acc_dtk2";
_pointer = "";
_sight = "";
_bipod = "";

_rifle = ["rhs_weap_ak74m", _silencer, _pointer, _sight, _bipod];
_rifleC = ["rhs_weap_aks74u", _silencer, _pointer, _sight, _bipod];
_rifleGL = ["rhs_weap_ak74m_gp25", _silencer, _pointer, _sight, _bipod];
_rifleL = ["rhs_weap_rpk74m_npz", _silencer, _pointer, _sight, _bipod];
_rifle_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifle_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleGL_mag = "rhs_30Rnd_545x39_7N22_plum_AK";
_rifleGL_mag_tr = "rhs_30Rnd_545x39_AK_plum_green";
_rifleL_mag = "rhs_60Rnd_545X39_AK_Green";

_LMG = ["rhs_weap_rpk74m_npz", _silencer, _pointer, _sight, _bipod];
_LMG_mag = "rhs_60Rnd_545X39_AK_Green";

_MMG = ["rhs_weap_pkm", _silencer, _pointer, _sight, _bipod];
_MMG_mag = "rhs_100Rnd_762x54mmR_green";

_LAT = ["rhs_weap_rpg26", _silencer, _pointer, _sight, _bipod];
_LAT_mag = "rhs_rpg26_mag";
_LAT_ReUsable = false;

_MAT = ["launch_RPG7_F", _silencer, _pointer, _sight, _bipod];
_MAT_mag = "RPG7_F";

_HAT = ["launch_O_Vorona_green_F", _silencer, _pointer, _sight, _bipod];
_HAT_mag = "Vorona_HEAT";

_AA = ["rhs_weap_igla", _silencer, _pointer, _sight, _bipod];
_AA_mag = "rhs_mag_9k38_rocket";

_pistol = ["rhs_weap_makarov_pm", _silencer, _pointer, _sight, _bipod];
_pistol_mag = "rhs_mag_9x18_8_57N181S";

_pdw = ["rhs_weap_pp2000", _silencer, _pointer, _sight, _bipod];
_pdw_mag = "rhs_mag_9x19mm_7n31_44";

_silencer = "";
_pointer = "";
_sight = "JCA_optic_CRBS_black";
_bipod = "";

_rifleMarksman = ["UK3CB_MG3_KWS_B", _silencer, _pointer, _sight, _bipod];
_rifleMarksman_mag = "UK3CB_MG3_250rnd_762x51_GT";
_rifleMarksman_mag_tr = "UK3CB_MG3_250rnd_762x51_GT";