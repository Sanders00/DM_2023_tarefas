import 'package:flutter/material.dart';

import '../../database/models/quarto.dart';

class QuartoPage extends StatefulWidget {
  const QuartoPage({super.key});

  @override
  State<QuartoPage> createState() => _QuartoPageState();
}

class _QuartoPageState extends State<QuartoPage> {
  final quartosDB = QuartoDB();

  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  var _status = 'Disponivel';
  var _tipo = "Simples";

  refresh() {
    setState(() {});
  }

  updateDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text("Update quarto"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _numeroController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Numero do quarto:"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Tipo do quarto: "),
                      DropdownButton(
                        value: _tipo,
                        onChanged: (value) {
                          setState(() {
                            _tipo = value!;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: "Simples",
                            child: Text('Simples'),
                          ),
                          DropdownMenuItem(
                            value: "Luxo",
                            child: Text('Luxo'),
                          ),
                          DropdownMenuItem(
                            value: "Suíte",
                            child: Text('Suíte'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Status: "),
                      DropdownButton(
                        value: _status,
                        onChanged: (value) {
                          setState(
                            () {
                              _status = value!;
                            },
                          );
                        },
                        items: const [
                          DropdownMenuItem(
                            value: "Disponivel",
                            child: Text('Disponivel'),
                          ),
                          DropdownMenuItem(
                            value: "Ocupado",
                            child: Text('Ocupado'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _precoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Preço Estadia:"),
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
                    final quarto = Quarto(
                      numeroQuarto: _numeroController.text,
                      tipo: _tipo,
                      status: _status,
                      precoPorNoite: double.parse(_precoController.text),
                    );
                    quartosDB.updateQuarto(quarto);
                    _numeroController.clear();
                    _status = 'Disponivel';
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
              title: const Text("Adicionar quarto"),
              content: Column(
                children: [
                  TextFormField(
                    controller: _numeroController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Numero do quarto:"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Tipo do quarto: "),
                      DropdownButton(
                        value: _tipo,
                        onChanged: (value) {
                          setState(() {
                            _tipo = value!;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            value: "Simples",
                            child: Text('Simples'),
                          ),
                          DropdownMenuItem(
                            value: "Luxo",
                            child: Text('Luxo'),
                          ),
                          DropdownMenuItem(
                            value: "Suíte",
                            child: Text('Suíte'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Status: "),
                      DropdownButton(
                        value: _status,
                        onChanged: (value) {
                          setState(
                            () {
                              _status = value!;
                            },
                          );
                        },
                        items: const [
                          DropdownMenuItem(
                            value: "Disponivel",
                            child: Text('Disponivel'),
                          ),
                          DropdownMenuItem(
                            value: "Ocupado",
                            child: Text('Ocupado'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _precoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Preço Estadia:"),
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
                    final quarto = Quarto(
                      numeroQuarto: _numeroController.text,
                      tipo: _tipo,
                      status: _status,
                      precoPorNoite: double.parse(_precoController.text),
                    );
                    quartosDB.insertQuarto(quarto);
                    _numeroController.clear();
                    _status = 'Disponivel';
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
        title: const Text("Quartos"),
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
          future: quartosDB.getAllQuartos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final quartos = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: quartos.length,
                itemBuilder: (context, index) {
                  return _buildQuartoCard(quartos[index]);
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

  Widget _buildQuartoCard(Quarto quarto) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(quarto.numeroQuarto),
            Column(
              children: [
                Text(quarto.tipo),
                Text(quarto.status),
              ],
            ),
            Text(quarto.precoPorNoite.toString()),
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
                  quartosDB.deleteQuarto(quarto.id!);
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
