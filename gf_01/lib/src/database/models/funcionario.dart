import 'package:gf_01/src/database/database.dart';

class FuncionarioDB {
  Future<int> insertFuncionario(Funcionario funcionario) async {
    final db = await HotelDatabase().database;
    return await db.insert('funcionarios', funcionario.toMap());
  }

  Future<List<Funcionario>> getAllFuncionario() async {
    final db = await HotelDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query('funcionarios');
    return List.generate(maps.length, (i) {
      return Funcionario.fromMap(maps[i]);
    });
  }

  Future<int> updateFuncionario(Funcionario funcionario) async {
    final db = await HotelDatabase().database;
    return await db.update('funcionarios', funcionario.toMap(),
        where: 'id = ?', whereArgs: [funcionario.id]);
  }

  Future<int> deleteFuncionario(int id) async {
    final db = await HotelDatabase().database;
    return await db.delete('funcionarios', where: 'id = ?', whereArgs: [id]);
  }
}

class Funcionario {
  int? id; // Id pode ser nulo se o quarto não foi inserido ainda.
  String nome;
  String cargo;
  double salario;
  String dataAdmissao;

  Funcionario({
    this.id,
    required this.nome,
    required this.cargo,
    required this.salario,
    required this.dataAdmissao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cargo': cargo,
      'salario': salario,
      'dataAdmissao': dataAdmissao,
    };
  }

  factory Funcionario.fromMap(Map<String, dynamic> map) {
    return Funcionario(
      id: map['id'],
      nome: map['nome'],
      cargo: map['cargo'],
      salario: map['salario'],
      dataAdmissao: map['dataAdmissao'],
    );
  }
}
