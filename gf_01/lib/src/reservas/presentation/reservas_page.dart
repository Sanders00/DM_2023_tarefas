import 'package:flutter/material.dart';
import 'package:gf_01/src/adicionais/presentation/adicionais_per_reserva_page.dart';
import 'package:gf_01/src/database/models/hospede.dart';
import 'package:gf_01/src/database/models/quarto.dart';
import 'package:gf_01/src/database/models/reservas.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({super.key});

  @override
  State<ReservasPage> createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  final reservaDB = ReservaDB();
  final hospedeDB = HospedeDB();
  final quartoDB = QuartoDB();

  late Hospede selectedHospede;
  late Quarto selectedQuarto;
  List<Hospede> allHospedes = [];
  List<Quarto> allQuartos = [];

  final TextEditingController _dataEntradaController = TextEditingController();
  final TextEditingController _dataSaidaController = TextEditingController();

  @override
  initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    final hospedes = await hospedeDB.getAllHospedes();
    final quartos = await quartoDB.getAllQuartos();
    setState(() {
      allHospedes = hospedes;
      allQuartos = quartos;
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
              title: const Text("Update reserva"),
              content: Column(
                children: [],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                TextButton(
                  onPressed: () {},
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
              title: const Text("Adicionar reserva"),
              content: Column(
                children: [
                  Row(
                    children: [
                      const Text("Hospede:"),
                      //todo Dropdown esta selecionando os itens porem não esta mostrando eles
                      DropdownButton(
                        onChanged: (newValue) {
                          selectedHospede = newValue!;
                          setState(() {});
                        },
                        items: allHospedes.map((Hospede hospede) {
                          return DropdownMenuItem<Hospede>(
                            value: hospede,
                            child: Text(
                                "${hospede.nome} ${hospede.sobrenome} - ${hospede.documento}"),
                          );
                        }).toList(),
                        hint: const Text(
                          'Selecione o hospede',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Quartos:"),
                      //todo Dropdown esta selecionando os itens porem não esta mostrando eles
                      DropdownButton(
                        onChanged: (newValue) {
                          selectedQuarto = newValue!;
                          setState(() {});
                        },
                        items: allQuartos.map((Quarto quarto) {
                          return DropdownMenuItem<Quarto>(
                            value: quarto,
                            child: Text(
                              "${quarto.numeroQuarto}-${quarto.tipo}-${quarto.status}",
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          'Selecione o quarto',
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  TextFormField(
                    controller: _dataEntradaController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      label: Text("Data entrada:"),
                    ),
                  ),
                  TextFormField(
                    controller: _dataSaidaController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      label: Text("Data saida:"),
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
                    final reserva = Reserva(
                        hospedeId: selectedHospede.id!,
                        quartoId: selectedQuarto.id!,
                        dataEntrada: _dataEntradaController.text,
                        dataSaida: _dataSaidaController.text);
                    reservaDB.insertReserva(reserva);
                    _dataEntradaController.clear();
                    _dataSaidaController.clear();
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
        title: const Text("Reservas"),
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
          future: reservaDB.getAllReservas(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final reservas = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: reservas.length,
                itemBuilder: (context, index) {
                  return _buildReservaCard(reservas[index]);
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

  Widget _buildReservaCard(Reserva reserva) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdicionaisReservaPage(reserva: reserva),
          ),
        );
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(allQuartos
                  .singleWhere((element) => element.id == reserva.quartoId)
                  .numeroQuarto),
              Text(allHospedes
                  .singleWhere((element) => element.id == reserva.hospedeId)
                  .nome),
              Column(
                children: [
                  Text(reserva.dataEntrada),
                  Text(reserva.dataSaida),
                ],
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
                    reservaDB.deleteReserva(reserva.id!);
                  });
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
