import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/database/database.dart';
import 'src/settings/controllers/settings_controller.dart';
import 'src/settings/controllers/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = HotelDatabase();
  await database.database;

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));
}
