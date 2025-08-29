import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/domain/medicament.dart';

class MockDatabaseRepository implements DatabaseRepository {
  final List<Medicament> _medicamente = [
   ];

  @override // create
  Future <void> createMedicament(Medicament medicament) async {
    await Future.delayed(const Duration(seconds: 1)); // Simuliere eine Verzögerung
    _medicamente.add(medicament);
    print("Medikament added: ${medicament.medName}");
  }



@override // update
Future <void> updateMedicament(int id, Medicament medicament) async {
  await Future.delayed(const Duration(seconds: 1)); // Simuliere eine Verzögerung
  for (int i = 0; i < _medicamente.length; i++) {
    if (_medicamente[i].id == id) {
      _medicamente[i] = medicament;
      print("Medikament mit ID $id wurde updated.");
      return;
    }
  }
    print("Medikament mit ID $id nicht gefunden.");
  }

  @override //delete
  Future <void> deleteMedicament(int id) async {
    await Future.delayed(const Duration(seconds: 1)); // Simuliere eine Verzögerung
    _medicamente.removeWhere((med) => med.id == id);
    print("Medikament mit ID $id wurde gelöscht.");
  }

  @override
  Future <List<Medicament>> readAllMedicamente() async {
    await Future.delayed(const Duration(seconds: 1));
    return _medicamente;
  }
}