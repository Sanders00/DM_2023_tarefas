import 'package:flutter/material.dart';

import '../../database/models/adicional.dart';

class AdicionaisPage extends StatefulWidget {
  const AdicionaisPage({super.key});

  @override
  State<AdicionaisPage> createState() => _AdicionaisPageState();
}

class _AdicionaisPageState extends State<AdicionaisPage> {
  final adicionalDB = AdicionalDB();

  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  refresh() {
    setState(() {});
  }

  updateDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Update Adicional"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                      label: Text("Descrição:"),
                    ),
                  ),
                  TextFormField(
                    controller: _precoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Preço:"),
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
                    final adicional = Adicional(
                      descricao: _descricaoController.text,
                      preco: double.parse(_precoController.text),
                    );
                    adicionalDB.updateAdicional(adicional);
                    _descricaoController.clear();
                    _precoController.clear();
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
              title: const Text("Adicionar adicional"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                      label: Text("Descrição:"),
                    ),
                  ),
                  TextFormField(
                    controller: _precoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Preço:"),
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
                    final adicional = Adicional(
                      descricao: _descricaoController.text,
                      preco: double.parse(_precoController.text),
                    );
                    adicionalDB.insertAdicional(adicional);
                    _descricaoController.clear();
                    _precoController.clear();
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
        title: const Text("Adicionais"),
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
          future: adicionalDB.getAllAdicional(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final adicionais = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: adicionais.length,
                itemBuilder: (context, index) {
                  return _buildAdicionalCard(adicionais[index]);
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

  Widget _buildAdicionalCard(Adicional adicional) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(adicional.preco.toString()),
            Text(adicional.descricao),
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
                  adicionalDB.deleteAdicional(adicional.id!);
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
