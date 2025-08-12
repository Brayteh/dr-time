
class Medicament {
  final String id;
  final String name;
  final String info;


  const Medicament({
    required this.id,
    required this.name,
    required this.info,

  });

  Medicament copyWith({
    String? id,
    String? name,
    String? info,
  }) {
    return Medicament(
      id: id ?? this.id,
      name: name ?? this.name,
      info: info ?? this.info,
    );
  }

  factory Medicament.empty() =>
      const Medicament(id: "", name: "",info:"");
}