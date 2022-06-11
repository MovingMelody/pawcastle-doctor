part of 'diagnosis_viewmodel.dart';

extension TreatmentModule on DiagnosisViewModel {
  fetchTreatment(String caseId) async {
    if (treatment != null) return;
    var result = await _firestoreApi.getTreatment(caseId);

    if (result is Treatment) {
      treatment = result;
    }
  }

  Future<void> uploadDiagnosis() async {
    if (treatment != null) {
      var diagnosis = TreatmentDiagnosis(
        id: treatment!.id,
        pet: Pet(
            name: "name",
            species: "species",
            age: speciesAge,
            sex: speciesSex,
            breed: speciesBreed),
        history: CaseHistory(
          temperature: temperature,
          respiration: respiration,
          rumination: rumination,
          feeding: feeding,
          deworming: deworming,
          vaccination: vaccination,
          drinkingWater: drinkingWater,
        ),
        diagnosis: tentativeDiagnosis,
        symptoms: clinicalSymptoms,
      );

      await _firestoreApi.createDiagnosis(diagnosis: diagnosis);

      var medicines = selectedMedicines.map((e) => e.toMap()).toList();

      await treatment?.reference?.update(
          {'medicines': medicines, 'status': TreatmentStatus.closed.value});

      await _userService.updateStatus(true);

      // _analyticsService.logEvent(LogEvents.TreatmentDone.event);
    }
  }
}
