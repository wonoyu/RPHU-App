import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rphu_app/src/features/home/domain/usecases/check_if_is_onboarded_usecase.dart';
import 'package:rphu_app/src/features/home/domain/usecases/set_to_is_onboarded_usecase.dart';

part 'check_onboarding_status_controller.g.dart';

@riverpod
class CheckOnBoardingStatusController
    extends _$CheckOnBoardingStatusController {
  @override
  Future<bool> build() async {
    final usecase = ref.read(checkIfIsOnBoardedUsecaseProvider);
    final result = usecase.execute();
    return result.match(
      (failure) => false,
      (data) => data,
    );
  }

  Future<void> setToIsOnBoarded() async {
    final usecase = ref.read(setToIsOnBoardedUsecaseProvider);
    final result = await usecase.execute();
    return result.match(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (data) => state = AsyncValue.data(data),
    );
  }
}
