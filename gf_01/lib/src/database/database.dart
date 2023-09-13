import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HotelDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('hotel.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

    await db.execute('''
      CREATE TABLE quartos (
        id $idType,
        numeroQuarto TEXT,
        tipo TEXT,
        status TEXT,
        precoPorNoite REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE hospedes (
        id $idType,
        nome TEXT,
        sobrenome TEXT,
        documento_id TEXT,
        contato TEXT
      )
    ''');

    await db.execute('''
    CREATE TABLE reservas (
      id $idType,
      dataEntrada TEXT,
      dataSaida TEXT,
      hospedeId INTEGER,
      quartoId INTEGER,
      FOREIGN KEY (hospedeId) REFERENCES hospedes (id),
      FOREIGN KEY (quartoId) REFERENCES quartos (id)
    )
  ''');

    await db.execute('''
      CREATE TABLE funcionarios (
        id $idType,
        nome TEXT,
        cargo TEXT,
        salario REAL,
        dataAdmissao TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE reserva_servico (
        id $idType,
        reservaId INTEGER,
        servicoId INTEGER,
        FOREIGN KEY (reservaId) REFERENCES reservas (id),
        FOREIGN KEY (servicoId) REFERENCES servico_adicional (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE servico_adicional (
        id $idType,
        descricao TEXT,
        preco REAL
      )
    ''');
  }
}
