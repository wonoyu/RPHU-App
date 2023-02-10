import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';
import 'package:rphu_app/src/features/rphu_order/domain/usecases/get_rphu_order_usecase.dart';

part 'get_rphu_order_controller.g.dart';

@riverpod
class GetRPHUOrderController extends _$GetRPHUOrderController {
  @override
  Future<List<OrderResultDataEntity>> build(
      {int? id, int? offset, int? limit, String? name}) async {
    state = const AsyncValue.loading();
    final usecase = ref.read(getRphuOrderUsecaseProvider);
    final result = await usecase.execute();
    return result.match(
      (failure) {
        state = const AsyncValue.data([]);
        return [];
      },
      (data) {
        state = AsyncValue.data(data);
        return data;
      },
    );
  }
}
