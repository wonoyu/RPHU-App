import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/core/utils/providers.dart';
import 'package:rphu_app/src/features/rphu_order/data/datasources/rphu_order_local_datasource.dart';
import 'package:rphu_app/src/features/rphu_order/data/datasources/rphu_order_remote_datasource.dart';
import 'package:rphu_app/src/features/rphu_order/data/repositories/rphu_order_repository_impl.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_product_entity.dart';

abstract class RPHUOrderRepository {
  TaskEither<Failure, List<OrderResultDataEntity>> getRphuOrder();
  TaskEither<Failure, OrderResultDataEntity> getRphuOrderById(int id);
  TaskEither<Failure, String> deleteRphuOrder(int id);
  TaskEither<Failure, String> updateRphuOrderStatus(String action, int id);
  TaskEither<Failure, List<RPHUProductDataEntity>> getRphuProduct();
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

final rphuOrderRepositoryProvider = Provider<RPHUOrderRepository>((ref) =>
    RPHUOrderRepositoryImpl(
        ref.watch(rphuOrderRemoteDatasourceProvider),
        ref.watch(rphuOrderLocalDatasourceProvider),
        ref.watch(loggerProvider)));
