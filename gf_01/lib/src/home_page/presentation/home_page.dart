import 'package:flutter/material.dart';
import 'package:gf_01/src/adicionais/presentation/adicionais_page.dart';
import 'package:gf_01/src/database/models/hospede.dart';
import 'package:gf_01/src/database/models/reservas.dart';
import 'package:gf_01/src/funcionario/presentation/funcionario_page.dart';
import 'package:gf_01/src/hospedes/presentation/hospedes_page.dart';
import 'package:gf_01/src/quartos/presentation/quartos_page.dart';
import 'package:gf_01/src/reservas/presentation/reservas_page.dart';

import '../../database/models/quarto.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../settings/presentation/settings_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final quartosDB = QuartoDB();
  final hospedeDB = HospedeDB();
  final reservasDB = ReservaDB();

  late int todosquartos = 0;
  late int availableRooms = 0; // Total de quartos disponíveis
  late int totalReservations = 0;
  late int totalHospedes = 0;

  @override
  initState() {
    _loadInfo();
    super.initState();
  }

  Future<void> _loadInfo() async {
    final reservas = await reservasDB.getAllReservas();
    final hospedes = await hospedeDB.getAllHospedes();
    final quartos = await quartosDB.getAllQuartos();
    final quartosDisponiveis = await quartosDB.getAllQuartosDisponiveis();
    setState(() {
      totalHospedes = hospedes.length;
      todosquartos = quartos.length;
      totalReservations = reservas.length;
      availableRooms = quartosDisponiveis.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Management App'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(Icons.replay_outlined))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Status do Hotel',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoCard('Quartos', "$todosquartos"),
                _buildInfoCard('Disponíveis', availableRooms.toString()),
                _buildInfoCard('Reservas', "$totalReservations"),
                _buildInfoCard('Check-in', "$totalHospedes"),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.23,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/flutter_logo.png',
                      fit: BoxFit.contain,
                      height: 70,
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Quartos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuartoPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Hóspedes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HospedePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Funcionarios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FuncionarioPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Reservas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReservasPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Adicionais'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdicionaisPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Configurações'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SettingsView(controller: widget.settingsController),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoCard(String title, String value) {
  return Card(
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    ),
  );
}
