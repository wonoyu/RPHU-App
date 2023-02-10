import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_product_entity.dart';
import 'package:rphu_app/src/features/rphu_order/domain/usecases/get_rphu_product_usecase.dart';

part 'get_rphu_product_controller.g.dart';

@riverpod
class GetRPHUProductController extends _$GetRPHUProductController {
  @override
  Future<List<RPHUProductDataEntity>> build() async {
    state = const AsyncValue.loading();
    final usecase = ref.read(getRphuProductUsecaseProvider);
    final result = await usecase.execute();
    return result.match(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return [];
      },
      (data) {
        state = AsyncValue.data(data);
        return data;
      },
    );
  }
}
