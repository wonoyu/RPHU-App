import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import 'package:rphu_app/src/core/constants/keys.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/core/utils/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDatasource {
  TaskEither<Failure, bool> setToIsOnBoarded();
  Either<Failure, bool> checkIfOnBoarded();
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final SharedPreferences prefs;
  final Logger logger;

  HomeLocalDatasourceImpl(this.prefs, this.logger);

  @override
  TaskEither<Failure, bool> setToIsOnBoarded() =>
      TaskEither<Failure, bool>.tryCatch(
        () => prefs.setBool(PrefKeys.isOnboarded, true),
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return SharedPreferencesFailure(error, stackTrace);
        },
      );

  @override
  Either<Failure, bool> checkIfOnBoarded() => Either<Failure, bool?>.tryCatch(
        () => prefs.getBool(PrefKeys.isOnboarded),
        (error, stackTrace) {
          logger.e(errorToString(error), [error, stackTrace]);
          return SharedPreferencesFailure(error, stackTrace);
        },
      ).flatMap(
        (isOnBoarded) => Either.fromNullable(isOnBoarded, () {
          logger.e('Data tidak dapat ditemukan');
          return NullableFailure('Data tidak dapat ditemukan');
        }),
      );
}

final homeLocalDatasourceProvider = Provider<HomeLocalDatasource>((ref) =>
    HomeLocalDatasourceImpl(
        ref.watch(sharedPreferencesProvider), ref.watch(loggerProvider)));
