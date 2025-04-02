// Global Commands
MedicalActions = compile preprocessFileLineNumbers "Training\Medical\MedicalActions.sqf";
MedicalDamage = compile preprocessFileLineNumbers "Training\Medical\MedicalDamage.sqf";
MedicalMassActions = compile preprocessFileLineNumbers "Training\Medical\MedicalMassActions.sqf";
MedicalMassPatients = compile preprocessFileLineNumbers "Training\Medical\MedicalMassPatients.sqf";
MedicalPatient = compile preprocessFileLineNumbers "Training\Medical\MedicalPatient.sqf";
MedicalQualificationActions = compile preprocessFileLineNumbers "Training\Medical\MedicalQualificationActions.sqf";
MedicalQualificationPatients = compile preprocessFileLineNumbers "Training\Medical\MedicalQualificationPatients.sqf";
MedicalAssessment = compile preprocessFileLineNumbers "Training\Medical\MedicalAssessment.sqf";
MedicalAssessmentActions = compile preprocessFileLineNumbers "Training\Medical\MedicalAssessmentActions.sqf";

// Individual Exercise
[MedicalData_1,PatientSpawn_1] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_2,PatientSpawn_2] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_3,PatientSpawn_3] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_4,PatientSpawn_4] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_5,PatientSpawn_5] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_6,PatientSpawn_6] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_7,PatientSpawn_7] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_8,PatientSpawn_8] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_9,PatientSpawn_9] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_10,PatientSpawn_10] execVM "Training\Medical\MedicalActions.sqf";

// Team Exercise
[MedicalData_11,PatientSpawn_11] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_12,PatientSpawn_12] execVM "Training\Medical\MedicalActions.sqf";
[MedicalData_13,PatientSpawn_13] execVM "Training\Medical\MedicalActions.sqf";

// Mass Tier 1 Casualty
[MedicalMass_1] execVM "Training\Medical\MedicalMassActions.sqf";

// Assessment
[TerminalAssess_1, SpawnAssess_1] execVM "Training\Medical\MedicalAssessmentActions.sqf";

// Qualification Course
[MedicalQualificationData_1,MedicalQualificationSpawn_1,Barrier_1] execVM "Training\Medical\MedicalQualificationActions.sqf";
[MedicalQualificationData_2,MedicalQualificationSpawn_2,Barrier_2] execVM "Training\Medical\MedicalQualificationActions.sqf";
[MedicalQualificationData_3,MedicalQualificationSpawn_3,Barrier_3] execVM "Training\Medical\MedicalQualificationActions.sqf";
[MedicalQualificationData_4,MedicalQualificationSpawn_4,Barrier_4] execVM "Training\Medical\MedicalQualificationActions.sqf";
[MedicalQualificationData_5,MedicalQualificationSpawn_5,Barrier_5] execVM "Training\Medical\MedicalQualificationActions.sqf";
[MedicalQualificationData_6,MedicalQualificationSpawn_6,Barrier_6] execVM "Training\Medical\MedicalQualificationActions.sqf";
[MedicalQualificationData_7,MedicalQualificationSpawn_7,Barrier_7] execVM "Training\Medical\MedicalQualificationActions.sqf";
[MedicalQualificationData_8,MedicalQualificationSpawn_8,Barrier_8] execVM "Training\Medical\MedicalQualificationActions.sqf";