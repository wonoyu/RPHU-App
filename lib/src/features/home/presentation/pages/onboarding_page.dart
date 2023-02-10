import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rphu_app/src/features/home/presentation/controllers/onboarding_controller.dart';
import 'package:rphu_app/src/features/home/presentation/widgets/onboarding_page_contents.dart';

class OnBoardingPage extends ConsumerWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(onBoardingControllerProvider);
    final notifier = ref.watch(onBoardingControllerProvider.notifier);
    return Scaffold(
      body: PageView.builder(
        controller: notifier.pageController,
        itemCount: notifier.contents.length,
        itemBuilder: (_, index) {
          return OnBoardingPageContents(
            title: notifier.contents[index]['title']!,
            body: notifier.contents[index]['body']!,
            img: notifier.contents[index]['img']!,
            index: index,
          );
        },
      ),
    );
  }
}
