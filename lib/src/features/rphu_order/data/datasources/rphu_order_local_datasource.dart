import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/core/utils/providers.dart';
import 'package:rphu_app/src/features/rphu_order/data/models/rphu_order_model.dart';
import 'package:sembast/sembast.dart';

abstract class RPHUOrderLocalDatasource {
  TaskEither<Failure, List<OrderResultDataModel>> insertRphuOrder(
      List<OrderResultDataModel> data);
  TaskEither<Failure, List<OrderResultDataModel>> getRphuOrder();
  TaskEither<Failure, OrderResultDataModel> getRphuOrderById(int id);
  TaskEither<Failure, String> deleteRphuOrder(int id);
}

class RPHUOrderLocalDatasourceImpl implements RPHUOrderLocalDatasource {
  final Database db;
  final Logger logger;

  RPHUOrderLocalDatasourceImpl(this.db, this.logger);

  final StoreRef _store = intMapStoreFactory.store("order_store");

  @override
  TaskEither<Failure, List<OrderResultDataModel>> insertRphuOrder(
          List<OrderResultDataModel> data) =>
      TaskEither<Failure, List<OrderResultDataModel>>.tryCatch(
        () async {
          await db.transaction((txn) async {
            for (var res in data) {
              final dt = res.toJson();
              await _store.record(res.id).put(txn, dt);
            }
          });
          return data;
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return SembastFailure(error, stackTrace);
        },
      );

  @override
  TaskEither<Failure, List<OrderResultDataModel>> getRphuOrder() =>
      TaskEither<Failure, List<Object?>>.tryCatch(
        () async {
          return await db.transaction((txn) async {
            var query = await _store.query().getSnapshots(txn);
            return query.map((e) => e.value).toList();
          });
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return SembastFailure(error, stackTrace);
        },
      )
          .chainEither(
            (dt) => Either.fromPredicate(
              dt,
              (dt) => !dt.any((e) => e == null),
              (dt) {
                logger.e('Terdapat data yang korup');
                return SaveToLocalFailure();
              },
            ),
          )
          .chainEither(
            (result) => Either.tryCatch(
              () => result.map((e) => e as Map<String, dynamic>),
              (error, stackTrace) {
                logger.e(errorToString(error), [error]);
                return InvalidMapFailure(error);
              },
            ),
          )
          .chainEither(
            (list) => Either.tryCatch(
                () =>
                    list.map((e) => OrderResultDataModel.fromJson(e)).toList(),
                (error, stackTrace) {
              logger.e(errorToString(error), [error, stackTrace]);
              return FormattingFailure(error, stackTrace);
            }),
          );

  @override
  TaskEither<Failure, OrderResultDataModel> getRphuOrderById(int id) =>
      TaskEither<Failure, Object?>.tryCatch(
        () async {
          return await db
              .transaction((txn) async => await _store.record(id).get(txn));
        },
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return SembastFailure(error, stackTrace);
        },
      )
          .chainEither(
            (dt) => Either.fromPredicate(
              dt,
              (dt) => dt != null,
              (dt) {
                logger.e('Terdapat data yang korup');
                return SaveToLocalFailure();
              },
            ),
          )
          .chainEither(
            (result) => Either<Failure, Map<String, dynamic>>.safeCast(
              result,
              (error) {
                logger.e(errorToString(error), [error]);
                return InvalidMapFailure(error);
              },
            ),
          )
          .chainEither(
            (map) => Either<Failure, OrderResultDataModel>.tryCatch(
                () => OrderResultDataModel.fromJson(map), (error, stackTrace) {
              logger.e(errorToString(error), [error, stackTrace]);
              return FormattingFailure(error, stackTrace);
            }),
          );

  @override
  TaskEither<Failure, String> deleteRphuOrder(int id) =>
      TaskEither<Failure, Object?>.tryCatch(
        () async => await db
            .transaction((txn) async => await _store.record(id).delete(txn)),
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return SembastFailure(error, stackTrace);
        },
      )
          .chainEither(
            (r) => Either<Failure, Object>.fromNullable(r, () {
              logger.e('Data tidak ditemukan, gagal menghapus');
              return NullableFailure('Data tidak ditemukan, gagal menghapus');
            }),
          )
          .pure('sukses');
}

final rphuOrderLocalDatasourceProvider = Provider<RPHUOrderLocalDatasource>(
    (ref) => RPHUOrderLocalDatasourceImpl(
        ref.watch(databaseProvider), ref.watch(loggerProvider)));
