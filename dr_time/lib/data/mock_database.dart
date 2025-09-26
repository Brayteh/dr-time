
/*class FirestoreDatabaseRepository implements DatabaseRepository {
  final CollectionReference medicamentsCollection =
      FirebaseFirestore.instance.collection('medicaments');

  @override
  Future<List<Medicament>> readAllMedicamente() async {
    final QuerySnapshot snapshot = await medicamentsCollection.get();
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Medicament.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Future<void> createMedicament(Medicament medicament) async {
    await medicamentsCollection.add(medicament.toMap());
  }

  @override
  Future<void> updateMedicament(int id, Medicament medicament) async {
    await medicamentsCollection.doc(id.toString()).update(medicament.toMap());
  }

  @override
  Future<void> deleteMedicament(int id) async {
    await medicamentsCollection.doc(id.toString()).delete();
  }
}
*/