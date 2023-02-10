import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rphu_app/src/core/constants/colors.dart';
import 'package:rphu_app/src/core/reusable_components/page_view_indicator.dart';
import 'package:rphu_app/src/features/home/presentation/controllers/check_onboarding_status_controller.dart';
import 'package:rphu_app/src/features/home/presentation/controllers/onboarding_controller.dart';

class OnBoardingPageContents extends ConsumerWidget {
  const OnBoardingPageContents({
    super.key,
    required this.title,
    required this.body,
    required this.img,
    required this.index,
  });

  final String title;
  final String body;
  final String img;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(onBoardingControllerProvider.notifier);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      height: size.height,
      width: size.width,
      color: AppColors.lightLimeGreen,
      child: Column(
        children: [
          const Spacer(flex: 2),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(24.0)),
              child: SvgPicture.asset(
                img,
                width: size.width,
                height: size.height * 0.35,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.mainGreen,
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1!
                  .copyWith(color: AppColors.mainGreen),
            ),
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (index == 0) ...[
                const RoundedRectangePageViewIndicator(),
                const SizedBox(width: 4.0),
                const CirclePageViewIndicator(),
                const SizedBox(width: 4.0),
                const CirclePageViewIndicator(),
              ],
              if (index == 1) ...[
                const CirclePageViewIndicator(),
                const SizedBox(width: 4.0),
                const RoundedRectangePageViewIndicator(),
                const SizedBox(width: 4.0),
                const CirclePageViewIndicator(),
              ],
              if (index == 2) ...[
                const CirclePageViewIndicator(),
                const SizedBox(width: 4.0),
                const CirclePageViewIndicator(),
                const SizedBox(width: 4.0),
                const RoundedRectangePageViewIndicator(),
              ]
            ],
          ),
          const Spacer(),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            buttonPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            children: [
              if (index != 2) ...[
                TextButton(
                  onPressed: notifier.skip,
                  child: const Text('Lewati'),
                ),
                TextButton(
                  onPressed: notifier.next,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Lanjut'),
                      Icon(Icons.arrow_right_alt_rounded),
                    ],
                  ),
                ),
              ],
              if (index == 2)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(size.width),
                  ),
                  onPressed: ref
                      .read(checkOnBoardingStatusControllerProvider.notifier)
                      .setToIsOnBoarded,
                  child: const Text('Mulai Sekarang'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
