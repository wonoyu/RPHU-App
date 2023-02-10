import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_product_entity.dart';
import 'package:rphu_app/src/features/rphu_order/domain/repositories/rphu_order_repository.dart';

class GetRPHUProductUsecase {
  final RPHUOrderRepository repository;

  GetRPHUProductUsecase(this.repository);

  Future<Either<Failure, List<RPHUProductDataEntity>>> execute() =>
      repository.getRphuProduct().run();
}

final getRphuProductUsecaseProvider = Provider<GetRPHUProductUsecase>(
    (ref) => GetRPHUProductUsecase(ref.watch(rphuOrderRepositoryProvider)));
