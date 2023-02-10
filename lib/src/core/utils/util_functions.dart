import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

// check if the statusCode equals to 200 then returns response.body
class UtilFunctions {
  static Either<E, String> validResponseBody<E>(
    http.Response response,
    E Function(http.Response) onError,
  ) =>
      Either<E, http.Response>.fromPredicate(
        response,
        (r) => r.statusCode == 200,
        onError,
      ).map((r) => r.body);
}
