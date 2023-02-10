import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rphu_app/src/app.dart';
import 'package:rphu_app/src/core/utils/providers.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await initializeDateFormatting('id_ID');
  final prefs = await SharedPreferences.getInstance();
  final database = await initSembast();

  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(database),
      ],
      child: const RPHUApp(),
    ),
  );
}

Future<Database> initSembast() async {
  final appDir = await getApplicationDocumentsDirectory();
  await appDir.create(recursive: true);
  final dbPath = path.join(appDir.path, "sembast.db");
  final db = await databaseFactoryIo.openDatabase(dbPath);
  return db;
}
