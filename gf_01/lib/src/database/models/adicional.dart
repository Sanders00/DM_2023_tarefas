import 'package:gf_01/src/database/database.dart';

class AdicionalDB {
  Future<int> insertAdicional(Adicional adicional) async {
    final db = await HotelDatabase().database;
    return await db.insert('servico_adicional', adicional.toMap());
  }

  Future<List<Adicional>> getAllAdicional() async {
    final db = await HotelDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query('servico_adicional');
    return List.generate(maps.length, (i) {
      return Adicional.fromMap(maps[i]);
    });
  }

  Future<int> updateAdicional(Adicional adicional) async {
    final db = await HotelDatabase().database;
    return await db.update('servico_adicional', adicional.toMap(),
        where: 'id = ?', whereArgs: [adicional.id]);
  }

  Future<int> deleteAdicional(int id) async {
    final db = await HotelDatabase().database;
    return await db
        .delete('servico_adicional', where: 'id = ?', whereArgs: [id]);
  }

  
}

class Adicional {
  int? id; // Id pode ser nulo se o quarto não foi inserido ainda.
  String descricao;
  double preco;

  Adicional({
    this.id,
    required this.descricao,
    required this.preco,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'descricao': descricao,
      'preco': preco,
    };
  }

  factory Adicional.fromMap(Map<String, dynamic> map) {
    return Adicional(
      id: map['id'],
      descricao: map['descricao'],
      preco: map['preco'],
    );
  }
}
