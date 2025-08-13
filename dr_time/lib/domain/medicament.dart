
class Medicament {
  final int id;
  final String imagePath;
  final String medName;
  final String dosis;
  final String info;


  const Medicament({
    required this.id,
    required this.imagePath,
    required this.medName,
    required this.dosis,
    required this.info,

  });

  Medicament copyWith({
    int? id,
    String? imagePath,
    String? medName,
    String? dosis,
    String? info,
  }) {
    
    return Medicament(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      medName: medName ?? this.medName,
      dosis: dosis ?? this.dosis,
      info: info ?? this.info,
    );
  }

  factory Medicament.empty() =>
      const Medicament(id: 0,imagePath: "", medName: "",dosis: "", info:"");
}