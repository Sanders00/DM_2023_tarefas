import 'package:flutter/material.dart';
import 'package:gf_01/src/database/models/hospede.dart';

class HospedePage extends StatefulWidget {
  const HospedePage({super.key});

  @override
  State<HospedePage> createState() => _HospedePageState();
}

class _HospedePageState extends State<HospedePage> {
  final hospedeDB = HospedeDB();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _documentoController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();

  refresh() {
    setState(() {});
  }

  updateDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Update hospede"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      label: Text("Nome:"),
                    ),
                  ),
                  TextFormField(
                    controller: _sobrenomeController,
                    decoration: const InputDecoration(
                      label: Text("Sobrenome:"),
                    ),
                  ),
                  TextFormField(
                    controller: _documentoController,
                    decoration: const InputDecoration(
                      label: Text("Documento:"),
                    ),
                  ),
                  TextFormField(
                    controller: _contatoController,
                    decoration: const InputDecoration(
                      label: Text("Contato:"),
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
                    final hospede = Hospede(
                      nome: _nomeController.text,
                      sobrenome: _sobrenomeController.text,
                      contato: _contatoController.text,
                      documento: _documentoController.text,
                    );
                    hospedeDB.updateHospede(hospede);
                    _nomeController.clear();
                    _sobrenomeController.clear();
                    _documentoController.clear();
                    _contatoController.clear();
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
              title: const Text("Adicionar hospede"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      label: Text("Nome:"),
                    ),
                  ),
                  TextFormField(
                    controller: _sobrenomeController,
                    decoration: const InputDecoration(
                      label: Text("Sobrenome:"),
                    ),
                  ),
                  TextFormField(
                    controller: _documentoController,
                    decoration: const InputDecoration(
                      label: Text("Documento:"),
                    ),
                  ),
                  TextFormField(
                    controller: _contatoController,
                    decoration: const InputDecoration(
                      label: Text("Contato:"),
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
                    final hospede = Hospede(
                      nome: _nomeController.text,
                      sobrenome: _sobrenomeController.text,
                      contato: _contatoController.text,
                      documento: _documentoController.text,
                    );
                    hospedeDB.insertHospede(hospede);
                    _nomeController.clear();
                    _sobrenomeController.clear();
                    _documentoController.clear();
                    _contatoController.clear();
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
        title: const Text("Hospedes"),
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
          future: hospedeDB.getAllHospedes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final hospedes = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: hospedes.length,
                itemBuilder: (context, index) {
                  return _buildHospedeCard(hospedes[index]);
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

  Widget _buildHospedeCard(Hospede hospede) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${hospede.nome} ${hospede.sobrenome}"),
            Column(
              children: [Text(hospede.documento), Text(hospede.contato)],
            ),
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
                  hospedeDB.deleteHospede(hospede.id!);
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
