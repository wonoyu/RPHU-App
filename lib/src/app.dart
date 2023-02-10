import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rphu_app/src/core/constants/themes.dart';
import 'package:rphu_app/src/core/routes/routes.dart';

class RPHUApp extends ConsumerWidget {
  const RPHUApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      title: 'RPHU App',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routerConfig: router,
    );
  }
}
