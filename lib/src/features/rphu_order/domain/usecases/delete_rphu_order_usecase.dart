import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/rphu_order/domain/repositories/rphu_order_repository.dart';

class DeleteRPHUOrderUsecase {
  final RPHUOrderRepository repository;

  DeleteRPHUOrderUsecase(this.repository);

  Future<Either<Failure, String>> execute(int id) =>
      repository.deleteRphuOrder(id).run();
}

final deleteRphuOrderUsecase = Provider<DeleteRPHUOrderUsecase>(
    (ref) => DeleteRPHUOrderUsecase(ref.watch(rphuOrderRepositoryProvider)));
