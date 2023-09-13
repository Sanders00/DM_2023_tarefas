import 'package:flutter/material.dart';
import 'package:gf_01/src/quartos/presentation/quartos_page.dart';

import '../../settings/controllers/settings_controller.dart';
import '../../settings/presentation/settings_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final dbHelper = DatabaseHelper(); // Classe para gerenciar o banco de dados
  //final prefs = SharedPreferencesHelper(); // Classe para gerenciar SharedPreferences
  //final notifications = NotificationsHelper(); // Classe para gerenciar notificações

  int totalRooms = 50; // Total de quartos no hotel
  int availableRooms = 30; // Total de quartos disponíveis
  int totalReservations = 20; // Total de reservas atuais
  int checkedInGuests = 15; // Total de hóspedes que fizeram o check-in

  @override
  void initState() {
    super.initState();
    // Configurar notificações aqui
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Management App'),
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
                _buildInfoCard('Quartos', totalRooms.toString()),
                _buildInfoCard('Disponíveis', availableRooms.toString()),
                _buildInfoCard('Reservas', totalReservations.toString()),
                _buildInfoCard('Check-in', checkedInGuests.toString()),
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
                // Navegar para a tela de gerenciamento de hóspedes
              },
            ),
            ListTile(
              title: const Text('Reservas'),
              onTap: () {
                // Navegar para a tela de gerenciamento de reservas
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
