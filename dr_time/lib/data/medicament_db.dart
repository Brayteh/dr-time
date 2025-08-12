//CRUD und DB Repo


import 'package:dr_time/domain/medicament.dart';

class InMemoryMedicamentDB {
  final List<Medicament> _items = [

    const Medicament(
      id: "1",
      name: "Lamotrigine",
      info:"3 mal pro Tag nach dem Essen"
    ),

  ];

  int _idCounter = 20;

  List<Medicament> get items => List.unmodifiable(_items);

  Medicament? byId(String id) => _items
      .where((m) => m.id == id)
      .cast<Medicament?>()
      .firstWhere((m) => m != null, orElse: () => null);

  //CREATE
  Medicament create(Medicament draft) {
    final created = draft.copyWith(id: (_idCounter++).toString());
    _items.add(created);
    return created;
  }

  //UPDATE
  void update(Medicament updated) {
    final i = _items.indexWhere((m) => m.id == updated.id);
    if (i == -1) return;
    _items[i] = updated;
  }

  //DELETE
  void delete(String id) {
    _items.removeWhere((m) => m.id == id);
  }
}