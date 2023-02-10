import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';
import 'package:rphu_app/src/features/rphu_order/domain/usecases/get_rphu_order_by_id_usecase.dart';

part 'get_rphu_order_by_id_controller.g.dart';

@riverpod
class GetRPHUOrderByIdController extends _$GetRPHUOrderByIdController {
  @override
  Future<OrderResultDataEntity?> build(int id) async {
    final usecase = ref.read(getRphuOrderByIdUsecaseProvider);
    final result = await usecase.execute(id);
    return result.match(
      (failure) => null,
      (data) => data,
    );
  }
}
