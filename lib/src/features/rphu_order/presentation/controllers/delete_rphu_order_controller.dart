import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rphu_app/src/features/rphu_order/domain/usecases/delete_rphu_order_usecase.dart';

class DeleteRPHUOrderController extends AutoDisposeAsyncNotifier<String?> {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> deleteRphuOrder(int id) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(deleteRphuOrderUsecase);
    final result = await usecase.execute(id);
    result.match(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (success) => state = AsyncValue.data(success),
    );
  }
}

final deleteRphuOrderControllerProvider =
    AsyncNotifierProvider.autoDispose<DeleteRPHUOrderController, String?>(
        DeleteRPHUOrderController.new);
