import 'package:flutter/material.dart';
import 'package:gf_01/src/database/models/adicional_per_reserva.dart';
import 'package:gf_01/src/database/models/reservas.dart';

import '../../database/models/adicional.dart';

class AdicionaisReservaPage extends StatefulWidget {
  const AdicionaisReservaPage({super.key, required this.reserva});

  final Reserva reserva;
  @override
  State<AdicionaisReservaPage> createState() => _AdicionaisReservaPageState();
}

class _AdicionaisReservaPageState extends State<AdicionaisReservaPage> {
  final adicionalDB = AdicionalDB();
  final adicionalreservaDB = AdicionalReservaReservaDB();

  late Adicional selectedAdicional;

  List<Adicional> allAdicionais = [];
  List<AdicionalReserva> servicosAdicionais = [];

  @override
  initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    final adicionaisreserva = await adicionalreservaDB.getAllAdicionalReserva();
    final adicionais = await adicionalDB.getAllAdicional();
    var adicionaisOfReserva = adicionaisreserva
        .where((element) => element.reservaId == widget.reserva.id);
    setState(() {
      allAdicionais = adicionais;
      servicosAdicionais = adicionaisOfReserva.toList();
    });
  }

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
                  Row(
                    children: [
                      const Text("Adicional:"),
                      //todo Dropdown esta selecionando os itens porem não esta mostrando eles
                      DropdownButton(
                        onChanged: (newValue) {
                          selectedAdicional = newValue!;
                          setState(() {});
                        },
                        items: allAdicionais.map((Adicional adicional) {
                          return DropdownMenuItem<Adicional>(
                            value: adicional,
                            child: Text(
                                "${adicional.descricao} - R\$${adicional.preco}"),
                          );
                        }).toList(),
                        hint: const Text(
                          'Selecione o adicional',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
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
                    final adicionalreserva = AdicionalReserva(
                      reservaId: widget.reserva.id!,
                      servicoId: selectedAdicional.id!,
                    );
                    adicionalreservaDB.updateAdicionalReserva(adicionalreserva);
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
                  Row(
                    children: [
                      const Text("Adicional:"),
                      //todo Dropdown esta selecionando os itens porem não esta mostrando eles
                      DropdownButton(
                        onChanged: (newValue) {
                          selectedAdicional = newValue!;
                          setState(() {});
                        },
                        items: allAdicionais.map((Adicional adicional) {
                          return DropdownMenuItem<Adicional>(
                            value: adicional,
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                  "${adicional.descricao} - R\$${adicional.preco}"),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          'Selecione o adicional',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
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
                    final adicionalreserva = AdicionalReserva(
                      reservaId: widget.reserva.id!,
                      servicoId: selectedAdicional.id!,
                    );
                    adicionalreservaDB.insertAdicionalReserva(adicionalreserva);
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
          future: adicionalreservaDB.getAllAdicionalReserva(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: servicosAdicionais.length,
                itemBuilder: (context, index) {
                  return _buildAdicionalCard(servicosAdicionais[index]);
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

  Widget _buildAdicionalCard(AdicionalReserva adicional) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(allAdicionais
                .singleWhere((element) => element.id == adicional.servicoId)
                .descricao),
            Text(allAdicionais
                .singleWhere((element) => element.id == adicional.servicoId)
                .preco
                .toString()),
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
