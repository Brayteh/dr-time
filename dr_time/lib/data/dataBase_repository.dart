import 'package:dr_time/domain/medicament.dart';

abstract class DatabaseRepository {

List<Medicament> readAllMedicamente();


  // create

void createMedicament(Medicament medicament);


// update
void updateMedicament(int id, Medicament medicament);

// delete
void deleteMedicament(int id);
}



