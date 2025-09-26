import 'package:dr_time/domain/medicament.dart';

abstract class DatabaseRepository {
  Stream<List<Medicament>> readAllMedicamenteStream();
  Future<List<Medicament>> readAllMedicamente();
  Future<void> createMedicament(Medicament medicament);
  Future<void> updateMedicament(String id, Medicament medicament);
  Future<void> deleteMedicament(String id);
}