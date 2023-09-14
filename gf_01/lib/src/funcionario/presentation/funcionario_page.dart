import 'package:flutter/material.dart';
import 'package:gf_01/src/database/models/funcionario.dart';

class FuncionarioPage extends StatefulWidget {
  const FuncionarioPage({super.key});

  @override
  State<FuncionarioPage> createState() => _FuncionarioPageState();
}

class _FuncionarioPageState extends State<FuncionarioPage> {
  final funcionarioDB = FuncionarioDB();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cargoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  refresh() {
    setState(() {});
  }

  updateDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Update funcionario"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      label: Text("Nome:"),
                    ),
                  ),
                  TextFormField(
                    controller: _cargoController,
                    decoration: const InputDecoration(
                      label: Text("Cargo:"),
                    ),
                  ),
                  TextFormField(
                    controller: _salarioController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Salario:"),
                    ),
                  ),
                  TextFormField(
                    controller: _dataController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      label: Text("Data de admição:"),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                  onPressed: () {
                    final funcionario = Funcionario(
                      nome: _nomeController.text,
                      cargo: _cargoController.text,
                      salario: double.parse(_salarioController.text),
                      dataAdmissao: _dataController.text,
                    );
                    funcionarioDB.updateFuncionario(funcionario);
                    _nomeController.clear();
                    _cargoController.clear();
                    _salarioController.clear();
                    _dataController.clear();
                    Navigator.pop(context);
                    refresh();
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          });
        });
  }

  addDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Adicionar funcionario"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      label: Text("Nome:"),
                    ),
                  ),
                  TextFormField(
                    controller: _cargoController,
                    decoration: const InputDecoration(
                      label: Text("Cargo:"),
                    ),
                  ),
                  TextFormField(
                    controller: _salarioController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Salario:"),
                    ),
                  ),
                  TextFormField(
                    controller: _dataController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      label: Text("Data de admição:"),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                  onPressed: () {
                    final funcionario = Funcionario(
                      nome: _nomeController.text,
                      cargo: _cargoController.text,
                      dataAdmissao: _dataController.text,
                      salario: double.parse(_salarioController.text),
                    );
                    funcionarioDB.insertFuncionario(funcionario);
                    _nomeController.clear();
                    _cargoController.clear();
                    _dataController.clear();
                    _salarioController.clear();
                    Navigator.pop(context);
                    refresh();
                  },
                  child: const Text('Create'),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Funcionarios"),
        actions: [
          ElevatedButton(
              onPressed: () {
                addDialog();
                setState(() {});
              },
              child: const Icon(Icons.add)),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: funcionarioDB.getAllFuncionario(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final funcionarios = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: funcionarios.length,
                itemBuilder: (context, index) {
                  return _buildFuncionarioCard(funcionarios[index]);
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFuncionarioCard(Funcionario funcionario) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(funcionario.nome),
            Column(
              children: [
                Text(funcionario.cargo),
                Text("R\$:${funcionario.salario}")
              ],
            ),
            Text(funcionario.dataAdmissao),
            ElevatedButton(
              onPressed: () {
                updateDialog();
                setState(() {});
              },
              child: const Icon(Icons.edit),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  funcionarioDB.deleteFuncionario(funcionario.id!);
                });
              },
              child: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
