import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rphu_app/src/core/reusable_components/custom_dialogs.dart';
import 'package:rphu_app/src/core/reusable_components/custom_snackbars.dart';
import 'package:rphu_app/src/core/routes/routes.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/controllers/get_rphu_order_by_id_controller.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/controllers/get_rphu_order_controller.dart';

extension RPHUOrderExtension on AsyncValue {
  void onDeleteRphuOrder(BuildContext context, WidgetRef ref) {
    final router = ref.read(goRouterProvider);
    whenOrNull(
      loading: () => CustomDialogs.showLoadingDialog(context),
      data: (success) {
        if (success == 'sukses') {
          CustomSnackbars.showSuccessSnackbar(
              context, 'Order berhasil dihapus');
          Future.delayed(
            const Duration(milliseconds: 750),
            () {
              router.goNamed(AppRoutes.homeName);
              ref.invalidate(getRPHUOrderControllerProvider);
            },
          );
        }
      },
      error: (e, st) {
        Navigator.pop(context);
        CustomSnackbars.showErrorSnackbar(context, 'Order gagal dihapus');
      },
    );
  }

  void onUpdateRphuOrder(BuildContext context, WidgetRef ref, String orderId) {
    whenOrNull(
      loading: () => CustomDialogs.showLoadingDialog(context),
      data: (success) {
        if (success == 'sukses') {
          CustomSnackbars.showSuccessSnackbar(
              context, 'Status order berhasil diubah');
          Future.delayed(
            const Duration(milliseconds: 750),
            () {
              Navigator.pop(context);
              ref.invalidate(
                  getRPHUOrderByIdControllerProvider(int.parse(orderId)));
            },
          );
        }
      },
      error: (e, st) {
        Navigator.pop(context);
        CustomSnackbars.showErrorSnackbar(context, 'Status order gagal diubah');
      },
    );
  }
}
