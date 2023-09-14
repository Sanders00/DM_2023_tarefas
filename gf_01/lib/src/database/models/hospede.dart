import 'package:gf_01/src/database/database.dart';

class HospedeDB {
  Future<int> insertHospede(Hospede hospede) async {
    final db = await HotelDatabase().database;
    return await db.insert('hospedes', hospede.toMap());
  }

  Future<List<Hospede>> getAllHospedes() async {
    final db = await HotelDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query('hospedes');
    return List.generate(maps.length, (i) {
      return Hospede.fromMap(maps[i]);
    });
  }

  Future<int> updateHospede(Hospede hospede) async {
    final db = await HotelDatabase().database;
    return await db.update('hospedes', hospede.toMap(),
        where: 'id = ?', whereArgs: [hospede.id]);
  }

  Future<int> deleteHospede(int id) async {
    final db = await HotelDatabase().database;
    return await db.delete('hospedes', where: 'id = ?', whereArgs: [id]);
  }
}

class Hospede {
  int? id; // Id pode ser nulo se o quarto não foi inserido ainda.
  String nome;
  String sobrenome;
  String documento;
  String contato;

  Hospede({
    this.id,
    required this.nome,
    required this.sobrenome,
    required this.documento,
    required this.contato,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'documento_id': documento,
      'contato': contato,
    };
  }

  factory Hospede.fromMap(Map<String, dynamic> map) {
    return Hospede(
      id: map['id'],
      nome: map['nome'],
      sobrenome: map['sobrenome'],
      documento: map['documento_id'],
      contato: map['contato'],
    );
  }
}
