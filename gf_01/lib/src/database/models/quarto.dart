import 'package:gf_01/src/database/database.dart';

class QuartoDB {
  Future<int> insertQuarto(Quarto quarto) async {
    final db = await HotelDatabase().database;
    return await db.insert('quartos', quarto.toMap());
  }

  Future<List<Quarto>> getAllQuartos() async {
    final db = await HotelDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query('quartos');
    return List.generate(maps.length, (i) {
      return Quarto.fromMap(maps[i]);
    });
  }

  Future<int> updateQuarto(Quarto quarto) async {
    final db = await HotelDatabase().database;
    return await db.update('quartos', quarto.toMap(),
        where: 'id = ?', whereArgs: [quarto.id]);
  }

  Future<int> deleteQuarto(int id) async {
    final db = await HotelDatabase().database;
    return await db.delete('quartos', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Quarto>> getAllQuartosDisponiveis() async {
    final db = await HotelDatabase().database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM quartos WHERE status = 'Disponivel'");
    return List.generate(maps.length, (i) {
      return Quarto.fromMap(maps[i]);
    });
  }
}

class Quarto {
  int? id; // Id pode ser nulo se o quarto não foi inserido ainda.
  String numeroQuarto;
  String tipo;
  String status;
  double precoPorNoite;

  Quarto({
    this.id,
    required this.numeroQuarto,
    required this.tipo,
    required this.status,
    required this.precoPorNoite,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numeroQuarto': numeroQuarto,
      'tipo': tipo,
      'status': status,
      'precoPorNoite': precoPorNoite,
    };
  }

  factory Quarto.fromMap(Map<String, dynamic> map) {
    return Quarto(
      id: map['id'],
      numeroQuarto: map['numeroQuarto'],
      tipo: map['tipo'],
      status: map['status'],
      precoPorNoite: map['precoPorNoite'],
    );
  }
}
