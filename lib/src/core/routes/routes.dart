import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rphu_app/src/features/home/presentation/controllers/check_onboarding_status_controller.dart';
import 'package:rphu_app/src/features/home/presentation/pages/dashboard_page.dart';
import 'package:rphu_app/src/features/home/presentation/pages/onboarding_page.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/pages/rphu_order_detail_page.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/pages/rphu_order_update_page.dart';

class AppRoutes {
  // top level route paths
  static const home = '/';
  static const onboarding = '/onboarding';

  // sub route paths
  static const rphuDetail = 'rphu/order/:id';
  static const rphuUpdate = 'update';

  // route names
  static const homeName = 'home';
  static const onboardingName = 'onboarding';
  static const rphuDetailName = 'rphuDetail';
  static const rphuUpdateName = 'update';

  // navigation observers
  static RouteObserver routeObserver = RouteObserver();
}

final goRouterProvider = Provider.autoDispose<GoRouter>(
  (ref) {
    final controller = ref.watch(checkOnBoardingStatusControllerProvider);
    return GoRouter(
      initialLocation: AppRoutes.home,
      observers: [AppRoutes.routeObserver],
      routes: [
        GoRoute(
          path: AppRoutes.home,
          name: AppRoutes.homeName,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const DashboardPage(),
          ),
          routes: [
            GoRoute(
              path: AppRoutes.rphuDetail,
              name: AppRoutes.rphuDetailName,
              pageBuilder: (context, state) => CupertinoPage(
                key: state.pageKey,
                child: const RPHUOrderDetailPage(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.rphuUpdate,
                  name: AppRoutes.rphuUpdateName,
                  pageBuilder: (context, state) {
                    final data = state.extra as OrderResultDataEntity;
                    return CupertinoPage(
                        child: RPHUOrderUpdatePage(data: data));
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          name: AppRoutes.onboardingName,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const OnBoardingPage(),
          ),
        ),
      ],
      redirect: (context, state) {
        return controller.when(
          data: (data) {
            if (data) return null;
            return AppRoutes.onboarding;
          },
          error: (_, __) {
            return AppRoutes.onboarding;
          },
          loading: () {
            return AppRoutes.onboarding;
          },
        );
      },
    );
  },
);
