import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rphu_app/src/core/constants/colors.dart';
import 'package:rphu_app/src/core/routes/routes.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/controllers/get_rphu_order_controller.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppRoutes.routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
  }

  @override
  void didPopNext() {
    ref.invalidate(getRPHUOrderControllerProvider);
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightLimeGreen,
      appBar: AppBar(
        title: const Text('RPHU Order'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(getRPHUOrderControllerProvider());
          final router = ref.watch(goRouterProvider);
          return state.when(
            data: (data) => ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () => router.goNamed(AppRoutes.rphuDetailName,
                          params: {'id': '${data[index].id}'}),
                      title: Text('Order: ${data[index].name}'),
                      subtitle: Text(data[index].description),
                      trailing: Text(
                        '${data[index].state[0].toUpperCase()}${data[index].state.substring(1)}',
                        style: theme.textTheme.bodyText1!.copyWith(
                            fontSize: 16.0,
                            color: data[index].state == 'draft'
                                ? Colors.orange
                                : data[index].state == 'validate'
                                    ? AppColors.mainGreen
                                    : AppColors.red),
                      ),
                    ),
                  );
                }),
            error: (e, st) => const Center(
              child: Text('Gagal ambil data'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  @override
  void dispose() {
    AppRoutes.routeObserver.unsubscribe(this);
    super.dispose();
  }
}
