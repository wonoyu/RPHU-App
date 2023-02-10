import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/home/domain/repositories/home_repository.dart';

class SetToIsOnBoardedUsecase {
  final HomeRepository repository;

  SetToIsOnBoardedUsecase(this.repository);

  Future<Either<Failure, bool>> execute() =>
      repository.setToIsOnBoarded().run();
}

final setToIsOnBoardedUsecaseProvider = Provider<SetToIsOnBoardedUsecase>(
    (ref) => SetToIsOnBoardedUsecase(ref.watch(homeRepositoryProvider)));
