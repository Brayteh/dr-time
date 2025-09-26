import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_time/data/database_repository.dart';
import 'package:dr_time/domain/medicament.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

Future<void> initPrefs() async {
  prefs = await SharedPreferences.getInstance();
}

// تعريف الدالة
Future<void> saveMed({
  required int id,
  required String medName,
  required String dosis,
  required String imagePath,
  required String info,
}) async {
  // استخدام النسخة الموجودة بالفعل
  // prefs! تعني أنك متأكد أن prefs ليس null
  await prefs!.setInt('med_id', id);
  await prefs!.setString('med_name', medName);
  await prefs!.setString('med_dosis', dosis);
  await prefs!.setString('med_imagePath', imagePath);
  await prefs!.setString('med_info', info);
}

// دالة لتحميل اسم الدواء
Future<String?> loadMedName() async {
  return prefs!.getString('med_name');
}

// دالة لتحميل الجرعة
Future<String?> loadMedDosis() async {
  return prefs!.getString('med_dosis');
}

// دالة لتحميل مسار الصورة
Future<String?> loadMedImagePath() async {
  return prefs!.getString('med_imagePath');
}

// دالة لتحميل المعلومات
Future<String?> loadMedInfo() async {
  return prefs!.getString('med_info');
}

class FirestoreDatabaseRepository implements DatabaseRepository {
  final CollectionReference medicamentsCollection =
      FirebaseFirestore.instance.collection('medicaments');

  @override
  Future<List<Medicament>> readAllMedicamente() async {
    final QuerySnapshot snapshot = await medicamentsCollection.get();
    return snapshot.docs.map((DocumentSnapshot doc) {
      return Medicament.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  @override
  Stream<List<Medicament>> readAllMedicamenteStream() {
    return medicamentsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Medicament.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  @override
  Future<void> createMedicament(Medicament medicament) async {
    await medicamentsCollection.add(medicament.toMap());
  }

  @override
  Future<void> updateMedicament(String id, Medicament medicament) async {
    await medicamentsCollection.doc(id).update(medicament.toMap());
  }

  @override
  Future<void> deleteMedicament(String id) async {
    await medicamentsCollection.doc(id).delete();
  }
}