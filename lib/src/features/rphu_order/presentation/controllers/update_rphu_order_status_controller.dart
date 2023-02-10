import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rphu_app/src/features/rphu_order/domain/usecases/update_rphu_order_status_usecase.dart';

class UpdateRPHUOrderStatusController
    extends AutoDisposeAsyncNotifier<String?> {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> updateRphuOrderStatus(String action, int id) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(updateRphuOrderStatusUsecaseProvider);
    final result = await usecase.execute(action, id);
    result.match(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (success) => state = AsyncValue.data(success),
    );
  }
}

final updateRphuOrderStatusControllerProvider =
    AsyncNotifierProvider.autoDispose<UpdateRPHUOrderStatusController, String?>(
        UpdateRPHUOrderStatusController.new);
