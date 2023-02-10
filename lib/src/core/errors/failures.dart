import 'package:http/http.dart' as http;

abstract class Failure {}

class HttpRequestFailure implements Failure {
  final Object object;
  final StackTrace stackTrace;

  HttpRequestFailure(this.object, this.stackTrace);
}

class RequestFailure implements Failure {
  final http.Response response;

  RequestFailure(this.response);
}

class JsonDecodeFailure implements Failure {
  final String body;

  JsonDecodeFailure(this.body);
}

class InvalidMapFailure implements Failure {
  final dynamic json;

  InvalidMapFailure(this.json);
}

class FormattingFailure implements Failure {
  final Object object;
  final StackTrace stackTrace;

  FormattingFailure(this.object, this.stackTrace);
}

class EntityFormattingFailure implements Failure {
  final Object object;
  final StackTrace stackTrace;

  EntityFormattingFailure(this.object, this.stackTrace);
}

class SharedPreferencesFailure implements Failure {
  final Object object;
  final StackTrace stackTrace;

  SharedPreferencesFailure(this.object, this.stackTrace);
}

class SembastFailure implements Failure {
  final Object object;
  final StackTrace stackTrace;

  SembastFailure(this.object, this.stackTrace);
}

class SaveToLocalFailure implements Failure {}

class NullableFailure implements Failure {
  final String message;

  NullableFailure(this.message);
}

class UnsuccessfulResult implements Failure {}

String errorToString(Object error) {
  final cases = {
    error is HttpRequestFailure:
        'Http request failed, please check your connection',
    error is RequestFailure: error is RequestFailure
        ? "${error.response.statusCode}: ${error.response.reasonPhrase}"
        : "Http request returns with failure",
    error is JsonDecodeFailure: 'Invalid http response body',
    error is InvalidMapFailure: 'Returned json is not a valid map',
    error is FormattingFailure: 'Failed to format data',
    error is EntityFormattingFailure: 'Failed to format to readable data',
    error is SharedPreferencesFailure: 'Failed to store data locally (prefs)',
    error is SembastFailure: 'Failed to store data to database',
    error is SaveToLocalFailure: 'Failed to store data to local storage',
    error is NullableFailure: 'The corresponding data cannot be found',
    error is http.Response: error is http.Response
        ? '${error.statusCode}: ${error.reasonPhrase}'
        : 'Http Request Error'
  };
  return cases[true] ?? "Unknown Error";
}
