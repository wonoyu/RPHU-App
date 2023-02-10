import 'package:rphu_app/src/core/env/app_env.dart';

class Api {
  final AppEnv env;

  Api(this.env);

  Map<String, String> headers() => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${env.token}',
      };

  Uri getRphuOrder({int? id, int? offset, int? limit}) {
    String path = env.rphuOrderEndpoint;
    if (id != null) {
      path = '$path$id';
    }
    if (offset != null && limit != null) {
      path = '${env.rphuOrderEndpoint}$offset/$limit';
    }
    return Uri.parse('http://${env.baseUrl}/$path');
  }

  Uri deleteRphuOrder(int id) =>
      Uri.parse('http://${env.baseUrl}/${env.deleteRphuEndpoint}$id');

  Uri updateRphuOrderStatus(int id) =>
      Uri.parse('http://${env.baseUrl}/${env.updateStateRphuEndpoint}$id');

  Uri getRphuProduct({int? id, int? offset, int? limit}) {
    String path = env.rphuProductEndpoint;
    if (id != null) {
      path = '$path/$id';
    }
    if (offset != null && limit != null) {
      path = '${env.rphuProductEndpoint}/$offset/$limit';
    }
    return Uri.parse('http://${env.baseUrl}/$path');
  }

  Uri updateRphuOrder(int id) =>
      Uri.parse('http://${env.baseUrl}/${env.updateRphuEndpoint}$id');

  Uri createRphuOrder() =>
      Uri.parse('http://${env.baseUrl}/${env.createRphuEndpoint}');
}
