import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rphu_app/src/features/rphu_order/domain/usecases/update_rphu_order_usecase.dart';

class UpdateRPHUOrderController extends AutoDisposeAsyncNotifier<String?> {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> updateRphuOrder(
    int id,
    String description,
    String date,
    List<List<dynamic>> fromIds,
    List<List<dynamic>> toIds,
    List<List<dynamic>> byProductIds,
  ) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(updateRphuOrderUsecaseProvider);
    final result = await usecase.execute(
        id, description, date, fromIds, toIds, byProductIds);
    result.match(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final updateRphuOrderControllerProvider =
    AsyncNotifierProvider.autoDispose<UpdateRPHUOrderController, String?>(
        UpdateRPHUOrderController.new);
