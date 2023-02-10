import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/rphu_order/domain/repositories/rphu_order_repository.dart';

class CreateRPHUOrderUsecase {
  final RPHUOrderRepository repository;

  CreateRPHUOrderUsecase(this.repository);

  Future<Either<Failure, String>> execute(String description, String date,
          List<List> fromIds, List<List> toIds, List<List> byProductIds) =>
      repository
          .createRphuOrder(description, date, fromIds, toIds, byProductIds)
          .run();
}

final createRphuOrderUsecaseProvider = Provider<CreateRPHUOrderUsecase>(
    (ref) => CreateRPHUOrderUsecase(ref.watch(rphuOrderRepositoryProvider)));
