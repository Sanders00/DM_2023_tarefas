import 'package:gf_01/src/database/database.dart';

class AdicionalReservaReservaDB {
  Future<int> insertAdicionalReserva(AdicionalReserva adicionalReserva) async {
    final db = await HotelDatabase().database;
    return await db.insert('reserva_servico', adicionalReserva.toMap());
  }

  Future<List<AdicionalReserva>> getAllAdicionalReserva() async {
    final db = await HotelDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query('reserva_servico');
    return List.generate(maps.length, (i) {
      return AdicionalReserva.fromMap(maps[i]);
    });
  }

  Future<int> updateAdicionalReserva(AdicionalReserva adicionalReserva) async {
    final db = await HotelDatabase().database;
    return await db.update('reserva_servico', adicionalReserva.toMap(),
        where: 'id = ?', whereArgs: [adicionalReserva.id]);
  }

  Future<int> deleteAdicionalReserva(int id) async {
    final db = await HotelDatabase().database;
    return await db.delete('reserva_servico', where: 'id = ?', whereArgs: [id]);
  }
}

class AdicionalReserva {
  int? id; // Id pode ser nulo se o quarto não foi inserido ainda.
  int reservaId;
  int servicoId;

  AdicionalReserva({
    this.id,
    required this.reservaId,
    required this.servicoId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservaId': reservaId,
      'servicoId': servicoId,
    };
  }

  factory AdicionalReserva.fromMap(Map<String, dynamic> map) {
    return AdicionalReserva(
      id: map['id'],
      reservaId: map['reservaId'],
      servicoId: map['servicoId'],
    );
  }
}
