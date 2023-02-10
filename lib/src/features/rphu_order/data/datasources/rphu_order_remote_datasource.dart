import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:rphu_app/src/core/constants/api.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/core/utils/providers.dart';
import 'package:rphu_app/src/core/utils/util_functions.dart';
import 'package:rphu_app/src/features/rphu_order/data/models/rphu_order_model.dart';
import 'package:http/http.dart' as http;
import 'package:rphu_app/src/features/rphu_order/data/models/rphu_product_model.dart';

abstract class RPHUOrderRemoteDatasource {
  TaskEither<Failure, List<OrderResultDataModel>> getRphuOrder();
  TaskEither<Failure, OrderResultDataModel> getRphuOrderById(int id);
  TaskEither<Failure, String> deleteRphuOrder(int id);
  TaskEither<Failure, String> updateRphuOrderStatus(String action, int id);
  TaskEither<Failure, List<RPHUProductDataModel>> getRphuProduct();
  TaskEither<Failure, String> updateRphuOrder(
    int id,
    String description,
    String date,
    List<List<dynamic>> fromIds,
    List<List<dynamic>> toIds,
    List<List<dynamic>> byProductIds,
  );
  TaskEither<Failure, String> createRphuOrder(
    String description,
    String date,
    List<List<dynamic>> fromIds,
    List<List<dynamic>> toIds,
    List<List<dynamic>> byProductIds,
  );
}

class RPHUOrderRemoteDatasourceImpl implements RPHUOrderRemoteDatasource {
  final http.Client client;
  final Api api;
  final Logger logger;

  RPHUOrderRemoteDatasourceImpl(this.client, this.api, this.logger);

  @override
  TaskEither<Failure, List<OrderResultDataModel>> getRphuOrder() =>
      TaskEither<Failure, http.Response>.tryCatch(
        () async {
          Map<String, String> body = {};

          final response = await http.post(
            api.getRphuOrder(),
            headers: api.headers(),
            body: jsonEncode(body),
          );

          return response;
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return HttpRequestFailure(error, stackTrace);
        },
      )
          // check if status code is 200, otherwise returns failure
          .chainEither(
            (response) => UtilFunctions.validResponseBody(
              response,
              (error) {
                logger.e(errorToString(error), [error]);
                return RequestFailure(error);
              },
            ),
          )
          // check if body is a valid json format
          .chainEither(
            (body) => Either.tryCatch(
              () => jsonDecode(body),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return JsonDecodeFailure(body);
              },
            ),
          )
          // converts json to dart map, returns failure if fails
          .chainEither(
            (json) => Either<Failure, Map<String, dynamic>>.safeCast(
              json,
              (error) {
                logger.e(errorToString(error), [error]);
                return InvalidMapFailure(json);
              },
            ),
          )
          // format dart map to corresponding data model
          .chainEither(
            (map) => Either<Failure, List<OrderResultDataModel>>.tryCatch(
              () => RPHUOrderModel.fromJson(map).result.data,
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return FormattingFailure(error, stackTrace);
              },
            ),
          );

  @override
  TaskEither<Failure, OrderResultDataModel> getRphuOrderById(int id) =>
      TaskEither<Failure, http.Response>.tryCatch(
        () async {
          Map<String, String> body = {};

          final response = await http.post(
            api.getRphuOrder(id: id),
            headers: api.headers(),
            body: jsonEncode(body),
          );

          return response;
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return HttpRequestFailure(error, stackTrace);
        },
      )
          // check if status code is 200, otherwise returns failure
          .chainEither(
            (response) => UtilFunctions.validResponseBody(
              response,
              (error) {
                logger.e(errorToString(error), [error]);
                return RequestFailure(error);
              },
            ),
          )
          // check if body is a valid json format
          .chainEither(
            (body) => Either.tryCatch(
              () => jsonDecode(body),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return JsonDecodeFailure(body);
              },
            ),
          )
          // converts json to dart map, returns failure if fails
          .chainEither(
            (json) => Either<Failure, Map<String, dynamic>>.safeCast(
              json,
              (error) {
                logger.e(errorToString(error), [error]);
                return InvalidMapFailure(json);
              },
            ),
          )
          // format dart map to corresponding data model
          .chainEither(
            (map) => Either<Failure, OrderResultDataModel>.tryCatch(
              () => RPHUOrderModel.fromJson(map).result.data[0],
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return FormattingFailure(error, stackTrace);
              },
            ),
          );

  @override
  TaskEither<Failure, String> deleteRphuOrder(int id) =>
      TaskEither<Failure, http.Response>.tryCatch(
        () async {
          final response = await http.post(
            api.deleteRphuOrder(id),
            headers: api.headers(),
            body: jsonEncode({}),
          );

          return response;
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return HttpRequestFailure(error, stackTrace);
        },
      )
          .chainEither(
            (response) => UtilFunctions.validResponseBody(
              response,
              (error) {
                logger.e(errorToString(error), [error]);
                return RequestFailure(error);
              },
            ),
          )
          .chainEither(
            (body) => Either.tryCatch(
              () => jsonDecode(body),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return JsonDecodeFailure(body);
              },
            ),
          )
          .chainEither(
            (json) => Either<Failure, Map<String, dynamic>>.safeCast(
              json,
              (error) {
                logger.e(errorToString(error), [error]);
                return InvalidMapFailure(json);
              },
            ),
          )
          .chainEither(
            (r) => Either<Failure, Map<String, dynamic>>.fromPredicate(
              r,
              (r) => r['result']['result']['result'] == 'sukses',
              (r) {
                logger.e('Data gagal terhapus');
                return UnsuccessfulResult();
              },
            ),
          )
          .chainEither(
            (r) => Either<Failure, String>.safeCast(
              r['result']['result']['result'],
              (error) {
                logger.e(errorToString(error));
                return UnsuccessfulResult();
              },
            ),
          );

  @override
  TaskEither<Failure, String> updateRphuOrderStatus(String action, int id) =>
      TaskEither<Failure, http.Response>.tryCatch(
        () async {
          final response = await http.put(
            api.updateRphuOrderStatus(id),
            headers: api.headers(),
            body: jsonEncode(
              {
                'data': {
                  'action': action,
                },
              },
            ),
          );

          return response;
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return HttpRequestFailure(error, stackTrace);
        },
      )
          .chainEither(
            (response) => UtilFunctions.validResponseBody(
              response,
              (error) {
                logger.e(errorToString(error), [error]);
                return RequestFailure(error);
              },
            ),
          )
          .chainEither(
            (body) => Either.tryCatch(
              () => jsonDecode(body),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return JsonDecodeFailure(body);
              },
            ),
          )
          .chainEither(
        (json) {
          return Either<Failure, Map<String, dynamic>>.safeCast(
            json,
            (error) {
              logger.e(errorToString(error), [error]);
              return InvalidMapFailure(json);
            },
          );
        },
      ).chainEither(
        (r) {
          logger.d(r);
          return Either<Failure, Map<String, dynamic>>.fromPredicate(
            r,
            (r) {
              if (r['error']?['message'] != null) {
                return false;
              }
              return r['result']?['data']?['description'] == 'sukses';
            },
            (r) {
              logger.e(
                  '${r['error']?['data']?['message'] ?? 'Order status gagal diubah'}');
              return UnsuccessfulResult(
                  message:
                      '${r['error']?['data']?['message'] ?? 'Order status gagal diubah'}');
            },
          );
        },
      ).chainEither(
        (r) => Either<Failure, String>.safeCast(
          r['result']['data']['description'],
          (error) {
            logger.e(errorToString(error));
            return UnsuccessfulResult();
          },
        ),
      );

  @override
  TaskEither<Failure, List<RPHUProductDataModel>> getRphuProduct() =>
      TaskEither<Failure, http.Response>.tryCatch(
        () async {
          final response = await http.post(
            api.getRphuProduct(),
            headers: api.headers(),
            body: jsonEncode({}),
          );

          return response;
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return HttpRequestFailure(error, stackTrace);
        },
      )
          // check if status code is 200, otherwise returns failure
          .chainEither(
            (response) => UtilFunctions.validResponseBody(
              response,
              (error) {
                logger.e(errorToString(error), [error]);
                return RequestFailure(error);
              },
            ),
          )
          // check if body is a valid json format
          .chainEither(
            (body) => Either.tryCatch(
              () => jsonDecode(body),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return JsonDecodeFailure(body);
              },
            ),
          )
          // converts json to dart map, returns failure if fails
          .chainEither(
            (json) => Either<Failure, Map<String, dynamic>>.safeCast(
              json,
              (error) {
                logger.e(errorToString(error), [error]);
                return InvalidMapFailure(json);
              },
            ),
          )
          // format dart map to corresponding data model
          .chainEither(
            (map) => Either<Failure, List<RPHUProductDataModel>>.tryCatch(
              () => RPHUProductModel.fromJson(map).result!.data!,
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return FormattingFailure(error, stackTrace);
              },
            ),
          );

  @override
  TaskEither<Failure, String> createRphuOrder(String description, String date,
          List<List> fromIds, List<List> toIds, List<List> byProductIds) =>
      TaskEither<Failure, http.Response>.tryCatch(
        () async {
          var body = {
            'data': [
              {
                'description': description,
                'date': date,
                'from_ids': fromIds,
                'to_ids': toIds,
                'byproduct_ids': byProductIds,
              }
            ],
          };

          final response = await http.post(api.createRphuOrder(),
              headers: api.headers(), body: jsonEncode(body));

          return response;
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return HttpRequestFailure(error, stackTrace);
        },
      )
          .chainEither(
            (response) => UtilFunctions.validResponseBody(
              response,
              (error) {
                logger.e(errorToString(error), [error]);
                return RequestFailure(error);
              },
            ),
          )
          .chainEither(
            (body) => Either.tryCatch(
              () => jsonDecode(body),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return JsonDecodeFailure(body);
              },
            ),
          )
          .chainEither(
        (json) {
          return Either<Failure, Map<String, dynamic>>.safeCast(
            json,
            (error) {
              logger.e(errorToString(error), [error]);
              return InvalidMapFailure(json);
            },
          );
        },
      ).chainEither(
        (r) {
          logger.d(r);
          return Either<Failure, Map<String, dynamic>>.fromPredicate(
            r,
            (r) {
              if (r['error']?['message'] != null) {
                return false;
              }
              return r['result']?['code'] == 201;
            },
            (r) {
              logger.e(
                  '${r['error']?['data']?['message'] ?? 'Order status gagal diubah'}');
              return UnsuccessfulResult(
                  message:
                      '${r['error']?['data']?['message'] ?? 'Order status gagal diubah'}');
            },
          );
        },
      ).chainEither(
        (r) => Either<Failure, String>.safeCast(
          r['result']['code'].toString(),
          (error) {
            logger.e(errorToString(error));
            return UnsuccessfulResult();
          },
        ),
      );

  @override
  TaskEither<Failure, String> updateRphuOrder(
          int id,
          String description,
          String date,
          List<List> fromIds,
          List<List> toIds,
          List<List> byProductIds) =>
      TaskEither<Failure, http.Response>.tryCatch(
        () async {
          var body = {
            'data': {
              'description': description,
              'date': date,
              'from_ids': fromIds,
              'to_ids': toIds,
              'byproduct_ids': byProductIds,
            },
          };

          final response = await http.put(api.updateRphuOrder(id),
              headers: api.headers(), body: jsonEncode(body));

          return response;
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return HttpRequestFailure(error, stackTrace);
        },
      )
          .chainEither(
            (response) => UtilFunctions.validResponseBody(
              response,
              (error) {
                logger.e(errorToString(error), [error]);
                return RequestFailure(error);
              },
            ),
          )
          .chainEither(
            (body) => Either.tryCatch(
              () => jsonDecode(body),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return JsonDecodeFailure(body);
              },
            ),
          )
          .chainEither(
        (json) {
          return Either<Failure, Map<String, dynamic>>.safeCast(
            json,
            (error) {
              logger.e(errorToString(error), [error]);
              return InvalidMapFailure(json);
            },
          );
        },
      ).chainEither(
        (r) {
          logger.d(r);
          return Either<Failure, Map<String, dynamic>>.fromPredicate(
            r,
            (r) {
              if (r['error']?['message'] != null) {
                return false;
              }
              return r['result']?['data']?['description'] == 'sukses';
            },
            (r) {
              logger.e(
                  '${r['error']?['data']?['message'] ?? 'Order status gagal diubah'}');
              return UnsuccessfulResult(
                  message:
                      '${r['error']?['data']?['message'] ?? 'Order status gagal diubah'}');
            },
          );
        },
      ).chainEither(
        (r) => Either<Failure, String>.safeCast(
          r['result']['data']['description'],
          (error) {
            logger.e(errorToString(error));
            return UnsuccessfulResult();
          },
        ),
      );
}

final rphuOrderRemoteDatasourceProvider = Provider<RPHUOrderRemoteDatasource>(
    (ref) => RPHUOrderRemoteDatasourceImpl(ref.watch(httpClientProvider),
        ref.watch(apiProvider), ref.watch(loggerProvider)));
