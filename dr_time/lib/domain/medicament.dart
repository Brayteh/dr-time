
class Medicament {
  final int id;
  final String imagePath;
  final String medName;
  final String dosis;
  final String info;
  final String time;


  const Medicament({
    required this.id,
    required this.imagePath,
    required this.medName,
    required this.dosis,
    required this.info,
     required this.time,

  });

  Medicament copyWith({
    int? id,
    String? imagePath,
    String? medName,
    String? dosis,
    String? info,
    String? time,
  }) {
    
    return Medicament(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      medName: medName ?? this.medName,
      dosis: dosis ?? this.dosis,
      info: info ?? this.info,
      time: time ?? this.time,
    );
  }

  factory Medicament.empty() =>
      const Medicament(id: 0,imagePath: "", medName: "",dosis: "", info:"", time: "");
      
      
}