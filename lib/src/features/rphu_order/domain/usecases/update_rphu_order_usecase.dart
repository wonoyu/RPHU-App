import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/rphu_order/domain/repositories/rphu_order_repository.dart';

class UpdateRphuOrderUsecase {
  final RPHUOrderRepository repository;

  UpdateRphuOrderUsecase(this.repository);

  Future<Either<Failure, String>> execute(
    int id,
    String description,
    String date,
    List<List<dynamic>> fromIds,
    List<List<dynamic>> toIds,
    List<List<dynamic>> byProductIds,
  ) =>
      repository
          .updateRphuOrder(id, description, date, fromIds, toIds, byProductIds)
          .run();
}

final updateRphuOrderUsecaseProvider = Provider<UpdateRphuOrderUsecase>(
    (ref) => UpdateRphuOrderUsecase(ref.watch(rphuOrderRepositoryProvider)));
