import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rphu_app/src/core/constants/colors.dart';
import 'package:rphu_app/src/core/errors/failures.dart';
import 'package:rphu_app/src/core/reusable_components/custom_dialogs.dart';
import 'package:rphu_app/src/core/routes/routes.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/controllers/delete_rphu_order_controller.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/controllers/get_rphu_order_by_id_controller.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/controllers/update_rphu_order_status_controller.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/rphu_order_extensions.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/widgets/tab_bar_view_product.dart';

class RPHUOrderDetailPage extends ConsumerWidget {
  const RPHUOrderDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final router = ref.watch(goRouterProvider);
    final state = ref.watch(getRPHUOrderByIdControllerProvider(
        int.parse(router.location.replaceAll(RegExp(r'[^0-9]'), ''))));
    ref.listen(deleteRphuOrderControllerProvider,
        (previous, next) => next.onDeleteRphuOrder(context, ref));
    ref.listen(
        updateRphuOrderStatusControllerProvider,
        (previous, next) => next.onUpdateRphuOrderStatus(
            context, ref, router.location.replaceAll(RegExp(r'[^0-9]'), '')));
    return state.when(
      data: (data) {
        if (data == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Order Detail'),
            ),
            body: const Center(
              child: Text('Data tidak ditemukan'),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Order Detail'),
            actions: [
              IconButton(
                  onPressed: () {
                    CustomDialogs.showAlertDialog(
                      context,
                      () => ref
                          .read(deleteRphuOrderControllerProvider.notifier)
                          .deleteRphuOrder(data.id),
                    );
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
          body: Column(
            children: [
              ListTile(
                title: Text(
                  '#${data.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(
                    DateFormat('yyyy-MM-dd').parse(data.date),
                  ),
                ),
                trailing: Text(
                  '${data.state[0].toUpperCase()}${data.state.substring(1)}',
                  style: theme.textTheme.bodyText1!.copyWith(
                      fontSize: 16.0,
                      color: data.state == 'draft'
                          ? Colors.orange
                          : data.state == 'validate'
                              ? AppColors.mainGreen
                              : AppColors.red),
                ),
              ),
              ListTile(
                title: Text(
                  'Dibuat oleh',
                  style: theme.textTheme.bodyMedium!.copyWith(fontSize: 13.0),
                ),
                subtitle: Text(
                  data.userId[1],
                  style: theme.textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Deskripsi',
                  style: theme.textTheme.bodyMedium!.copyWith(),
                ),
                subtitle: Text(
                  data.description,
                  style: theme.textTheme.subtitle1!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: ElevatedButton(
                    onPressed: () {
                      CustomDialogs.showUpdateRphuOrderStatusDialog(
                        context,
                        data,
                        (action) => ref
                            .read(updateRphuOrderStatusControllerProvider
                                .notifier)
                            .updateRphuOrderStatus(action, data.id),
                      );
                    },
                    child: const Text('Ubah Status')),
              ),
              const Divider(),
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                          labelColor: AppColors.mainGreen,
                          indicator: BoxDecoration(
                              color: AppColors.lightLimeGreen,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: AppColors.mainGreen)),
                          tabs: const [
                            Tab(text: 'From ID'),
                            Tab(text: 'To ID'),
                            Tab(text: 'By Product ID')
                          ]),
                      TabBarViewProducts(
                        fromIds: data.fromIds,
                        toIds: data.toIds,
                        byProductIds: data.byProductIds,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => router.goNamed(AppRoutes.rphuUpdateName,
                extra: data, params: {'id': '${data.id}'}),
            child: const Icon(Icons.edit),
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(
          title: const Text('Order Detail'),
        ),
        body: Center(child: Text(errorToString(error))),
      ),
      loading: () => Scaffold(
        appBar: AppBar(
          title: const Text('Order Detail'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
