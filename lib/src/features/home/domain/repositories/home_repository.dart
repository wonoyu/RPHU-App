import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/core/utils/providers.dart';
import 'package:rphu_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:rphu_app/src/features/home/data/repositories/home_repository_impl.dart';

abstract class HomeRepository {
  TaskEither<Failure, bool> setToIsOnBoarded();
  Either<Failure, bool> checkIfOnBoarded();
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) =>
    HomeRepositoryImpl(
        ref.watch(homeLocalDatasourceProvider), ref.watch(loggerProvider)));
