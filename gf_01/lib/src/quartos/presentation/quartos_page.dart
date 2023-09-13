import 'package:flutter/material.dart';

import '../../database/models/quarto.dart';

class QuartoPage extends StatefulWidget {
  const QuartoPage({super.key});

  @override
  State<QuartoPage> createState() => _QuartoPageState();
}

class _QuartoPageState extends State<QuartoPage> {
  final quartosDB = QuartoDB();

  final quartoteste = Quarto(
    numeroQuarto: '101',
    tipo: 'Luxo',
    status: 'Disponível',
    precoPorNoite: 250.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  quartosDB.insertQuarto(quartoteste);
                });
              },
              child: Text("+")),
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
            Text(quarto.tipo),
            Text(quarto.status),
            Text(quarto.precoPorNoite.toString()),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    quartosDB.deleteQuarto(quarto.id!);
                  });
                },
                child: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
