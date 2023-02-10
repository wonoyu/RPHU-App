import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:rphu_app/src/features/rphu_order/data/datasources/rphu_order_local_datasource.dart';
import 'package:rphu_app/src/features/rphu_order/data/datasources/rphu_order_remote_datasource.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_product_entity.dart';
import 'package:rphu_app/src/features/rphu_order/domain/repositories/rphu_order_repository.dart';

class RPHUOrderRepositoryImpl implements RPHUOrderRepository {
  final RPHUOrderRemoteDatasource remoteDatasource;
  final RPHUOrderLocalDatasource localDatasource;
  final Logger logger;

  RPHUOrderRepositoryImpl(
      this.remoteDatasource, this.localDatasource, this.logger);

  @override
  TaskEither<Failure, List<OrderResultDataEntity>> getRphuOrder() =>
      remoteDatasource
          .getRphuOrder()
          .alt(() => localDatasource.getRphuOrder())
          .flatMap((r) => localDatasource.insertRphuOrder(r))
          .chainEither(
            (result) => Either.tryCatch(
              () => result.map((e) => e.toEntity()).toList(),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return EntityFormattingFailure(error, stackTrace);
              },
            ),
          );

  @override
  TaskEither<Failure, OrderResultDataEntity> getRphuOrderById(int id) =>
      remoteDatasource
          .getRphuOrderById(id)
          .alt(() => localDatasource.getRphuOrderById(id))
          .chainEither(
            (result) => Either.tryCatch(
              () => result.toEntity(),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return EntityFormattingFailure(error, stackTrace);
              },
            ),
          );

  @override
  TaskEither<Failure, String> deleteRphuOrder(int id) =>
      remoteDatasource.deleteRphuOrder(id).flatMap(
            (r) => localDatasource.deleteRphuOrder(id),
          );

  @override
  TaskEither<Failure, String> updateRphuOrderStatus(String action, int id) =>
      remoteDatasource.updateRphuOrderStatus(action, id);

  @override
  TaskEither<Failure, List<RPHUProductDataEntity>> getRphuProduct() =>
      remoteDatasource.getRphuProduct().chainEither(
            (r) => Either.tryCatch(
              () => r.map((e) => e.toEntity()).toList(),
              (error, stackTrace) {
                logger.e(errorToString(error), [error, stackTrace]);
                return EntityFormattingFailure(error, stackTrace);
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
      remoteDatasource.updateRphuOrder(
          id, description, date, fromIds, toIds, byProductIds);

  @override
  TaskEither<Failure, String> createRphuOrder(String description, String date,
          List<List> fromIds, List<List> toIds, List<List> byProductIds) =>
      remoteDatasource.createRphuOrder(
          description, date, fromIds, toIds, byProductIds);
}
