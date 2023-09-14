import 'package:gf_01/src/database/database.dart';

class ReservaDB {
  Future<int> insertReserva(Reserva reserva) async {
    final db = await HotelDatabase().database;
    return await db.insert('reservas', reserva.toMap());
  }

  Future<List<Reserva>> getAllReservas() async {
    final db = await HotelDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query('reservas');
    return List.generate(maps.length, (i) {
      return Reserva.fromMap(maps[i]);
    });
  }

  Future<int> updateReserva(Reserva reserva) async {
    final db = await HotelDatabase().database;
    return await db.update('reservas', reserva.toMap(),
        where: 'id = ?', whereArgs: [reserva.id]);
  }

  Future<int> deleteReserva(int id) async {
    final db = await HotelDatabase().database;
    return await db.delete('reservas', where: 'id = ?', whereArgs: [id]);
  }
}

class Reserva {
  int? id; // Id pode ser nulo se o quarto não foi inserido ainda.
  int hospedeId;
  int quartoId;
  String dataEntrada;
  String dataSaida;

  Reserva({
    this.id,
    required this.hospedeId,
    required this.quartoId,
    required this.dataEntrada,
    required this.dataSaida,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hospedeId': hospedeId,
      'quartoId': quartoId,
      'dataEntrada': dataEntrada,
      'dataSaida': dataSaida,
    };
  }

  factory Reserva.fromMap(Map<String, dynamic> map) {
    return Reserva(
      id: map['id'],
      hospedeId: map['hospedeId'],
      quartoId: map['quartoId'],
      dataEntrada: map['dataEntrada'],
      dataSaida: map['dataSaida'],
    );
  }
}
