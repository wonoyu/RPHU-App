import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';
import 'package:rphu_app/src/features/rphu_order/domain/repositories/rphu_order_repository.dart';

class GetRPHUOrderUsecase {
  final RPHUOrderRepository repository;

  GetRPHUOrderUsecase(this.repository);

  Future<Either<Failure, List<OrderResultDataEntity>>> execute() =>
      repository.getRphuOrder().run();
}

final getRphuOrderUsecaseProvider = Provider<GetRPHUOrderUsecase>(
    (ref) => GetRPHUOrderUsecase(ref.watch(rphuOrderRepositoryProvider)));
