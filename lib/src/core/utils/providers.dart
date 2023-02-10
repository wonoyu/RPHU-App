import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rphu_app/src/core/constants/api.dart';
import 'package:rphu_app/src/core/env/app_env.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sharedPreferencesProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

final databaseProvider = Provider<Database>((_) => throw UnimplementedError());

final httpClientProvider = Provider<http.Client>((_) => http.Client());

final loggerProvider =
    Provider<Logger>((_) => Logger(printer: PrettyPrinter(colors: false)));

final appEnvProvider = Provider<AppEnv>((_) => AppEnv());

final apiProvider = Provider<Api>((ref) => Api(ref.watch(appEnvProvider)));
