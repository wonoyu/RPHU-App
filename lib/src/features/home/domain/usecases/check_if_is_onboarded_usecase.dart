import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/features/home/domain/repositories/home_repository.dart';

class CheckIfIsOnBoardedUsecase {
  final HomeRepository repository;

  CheckIfIsOnBoardedUsecase(this.repository);

  Either<Failure, bool> execute() => repository.checkIfOnBoarded();
}

final checkIfIsOnBoardedUsecaseProvider = Provider<CheckIfIsOnBoardedUsecase>(
    (ref) => CheckIfIsOnBoardedUsecase(ref.watch(homeRepositoryProvider)));
