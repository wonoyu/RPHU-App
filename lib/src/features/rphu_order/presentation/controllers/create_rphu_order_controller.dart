import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rphu_app/src/features/rphu_order/domain/usecases/create_rphu_order_usecase.dart';

class CreateRPHUOrderController extends AutoDisposeAsyncNotifier<String?> {
  @override
  FutureOr<String?> build() {
    return null;
  }

  Future<void> createRphuOrder(
    String description,
    String date,
    List<List<dynamic>> fromIds,
    List<List<dynamic>> toIds,
    List<List<dynamic>> byProductIds,
  ) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(createRphuOrderUsecaseProvider);
    final result =
        await usecase.execute(description, date, fromIds, toIds, byProductIds);
    result.match(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(r),
    );
  }
}

final createRphuOrderControllerProvider =
    AsyncNotifierProvider.autoDispose<CreateRPHUOrderController, String?>(
        CreateRPHUOrderController.new);
