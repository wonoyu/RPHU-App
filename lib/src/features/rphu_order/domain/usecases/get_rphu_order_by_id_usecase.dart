import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';
import 'package:rphu_app/src/features/rphu_order/domain/repositories/rphu_order_repository.dart';

class GetRPHUOrderByIdUsecase {
  final RPHUOrderRepository repository;

  GetRPHUOrderByIdUsecase(this.repository);

  Future<Either<Failure, OrderResultDataEntity>> execute(int id) =>
      repository.getRphuOrderById(id).run();
}

final getRphuOrderByIdUsecaseProvider = Provider<GetRPHUOrderByIdUsecase>(
    (ref) => GetRPHUOrderByIdUsecase(ref.watch(rphuOrderRepositoryProvider)));
