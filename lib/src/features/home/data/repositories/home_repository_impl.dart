import 'package:logger/logger.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:fpdart/src/task_either.dart';
import 'package:fpdart/src/either.dart';
import 'package:rphu_app/src/features/home/data/datasources/home_local_datasource.dart';
import 'package:rphu_app/src/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDatasource localDatasource;
  final Logger logger;

  HomeRepositoryImpl(this.localDatasource, this.logger);

  @override
  TaskEither<Failure, bool> setToIsOnBoarded() =>
      localDatasource.setToIsOnBoarded();

  @override
  Either<Failure, bool> checkIfOnBoarded() =>
      localDatasource.checkIfOnBoarded();
}
