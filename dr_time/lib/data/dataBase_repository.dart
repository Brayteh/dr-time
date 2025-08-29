import 'package:dr_time/domain/medicament.dart';

abstract class DatabaseRepository {

Future<List<Medicament>> readAllMedicamente();


  // create

Future<void> createMedicament(Medicament medicament);


// update
Future<void> updateMedicament(int id, Medicament medicament,);

// delete
Future<void> deleteMedicament(int id);
}



