import 'package:envied/envied.dart';
import 'package:rphu_app/src/core/env/app_env.dart';
import 'package:rphu_app/src/core/env/app_env_fields.dart';
part 'env.g.dart';

@Envied(name: 'Env', path: '.env')
class Env implements AppEnv, AppEnvFields {
  Env();

  @override
  @EnviedField(varName: 'TOKEN', obfuscate: true)
  final String token = _Env.token;

  @override
  @EnviedField(varName: 'BASE_URL', obfuscate: true)
  final String baseUrl = _Env.baseUrl;

  @override
  @EnviedField(varName: 'RPHU_ORDER_ENDPOINT', obfuscate: true)
  final String rphuOrderEndpoint = _Env.rphuOrderEndpoint;

  @override
  @EnviedField(varName: 'RPHU_PRODUCT_ENDPOINT', obfuscate: true)
  final String rphuProductEndpoint = _Env.rphuProductEndpoint;

  @override
  @EnviedField(varName: 'CREATE_RECORD_RPHU_ENDPOINT', obfuscate: true)
  final String createRphuEndpoint = _Env.createRphuEndpoint;

  @override
  @EnviedField(varName: 'UPDATE_RECORD_BY_RPHU_ID_ENDPOINT', obfuscate: true)
  final String updateRphuEndpoint = _Env.updateRphuEndpoint;

  @override
  @EnviedField(varName: 'DELETE_RECORD_BY_RPHU_ID_ENDPOINT', obfuscate: true)
  final String deleteRphuEndpoint = _Env.deleteRphuEndpoint;

  @override
  @EnviedField(varName: 'UPDATE_STATE_RPHU_ENDPOINT', obfuscate: true)
  final String updateStateRphuEndpoint = _Env.updateStateRphuEndpoint;
}
