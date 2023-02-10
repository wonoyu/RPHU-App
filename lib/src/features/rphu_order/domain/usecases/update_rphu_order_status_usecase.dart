import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/rphu_order/domain/repositories/rphu_order_repository.dart';

class UpdateRPHUOrderStatusUsecase {
  final RPHUOrderRepository repository;

  UpdateRPHUOrderStatusUsecase(this.repository);

  Future<Either<Failure, String>> execute(String action, int id) =>
      repository.updateRphuOrderStatus(action, id).run();
}

final updateRphuOrderStatusUsecaseProvider =
    Provider<UpdateRPHUOrderStatusUsecase>((ref) =>
        UpdateRPHUOrderStatusUsecase(ref.watch(rphuOrderRepositoryProvider)));
