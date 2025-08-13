import 'package:dr_time/Theme/medCard.dart';
import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/domain/medicament.dart';

class MockDatabaseRepository implements DatabaseRepository {
  final List<Medicament> _medicamente = [
   ];

  @override // create
  void createMedicament(Medicament medicament) {
    _medicamente.add(medicament);
    print("Medikament added: ${medicament.medName}");
  }



  @override // update
  void updateMedicament(int id, Medicament neuesMedicament) {
    for (int i = 0; i < _medicamente.length; i++) {
      if (_medicamente[i].id == id) {
        _medicamente[i] = neuesMedicament;
        print("Medikament mit ID $id wurde updated.");
        return;
      }
    }
    print("Medikament mit ID $id nicht gefunden.");
  }

  @override //delete
  void deleteMedicament(int id) {
    _medicamente.removeWhere((med) => med.id == id);
    print("Medikament mit ID $id wurde gelöscht.");
  }

  @override
  List<Medicament> readAllMedicamente() {
    // TODO: implement readAllMedicamente
    return _medicamente;
  }
}