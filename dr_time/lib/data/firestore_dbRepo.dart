import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/domain/medicament.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabaseRepository implements DatabaseRepository {
  // Helper to get the user-specific collection
  CollectionReference _getMedicamentsCollection() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in. Cannot access database.');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('medicaments');
  }

  @override
  Future<List<Medicament>> readAllMedicamente() async {
    final QuerySnapshot snapshot = await _getMedicamentsCollection().get();
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Medicament.fromMap(doc.data() as Map<String, dynamic>, doc.id); // Übergib die Dokument-ID
    }).toList();
  }

  @override
  Stream<List<Medicament>> readAllMedicamenteStream() {
    return _getMedicamentsCollection().snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Medicament.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  @override
  Future<void> createMedicament(Medicament medicament) async {
    await _getMedicamentsCollection().add(medicament.toMap());
  }

  @override
  Future<void> updateMedicament(String id, Medicament medicament) async { // Verwende String als ID
    await _getMedicamentsCollection().doc(id).update(medicament.toMap()); // Verwende String als ID
  }

  @override
  Future<void> deleteMedicament(String id) async { // Verwende String als ID
    await _getMedicamentsCollection().doc(id).delete(); // Verwende String als ID
  }
}
