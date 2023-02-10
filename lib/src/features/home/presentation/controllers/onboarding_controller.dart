import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnBoardingController extends StateNotifier<void> {
  OnBoardingController() : super(null);

  PageController pageController = PageController();

  List<Map<String, String>> contents = [
    {
      'title': 'RPHU App',
      'body':
          'Aplikasi mobile untuk diterapkan pada bisnis unit Rumah Pemotongan Hewan Unggas (RPHU)',
      'img': 'assets/images/img_grocery.svg',
    },
    {
      'title': 'Mudahkan pesananmu',
      'body':
          'Dengan menggunakan aplikasi ini kamu akan lebih mudah dalam melakukan pesanan terhadap produk kami',
      'img': 'assets/images/img_order.svg',
    },
    {
      'title': 'Pesan kapanpun, dimanapun',
      'body':
          'Kamu dapat melakukan pesanan kapanpun dan dimanapun, selama kamu punya aplikasi ini dan koneksi internet',
      'img': 'assets/images/img_order_2.svg',
    }
  ];

  void next() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void skip() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

final onBoardingControllerProvider =
    StateNotifierProvider((_) => OnBoardingController());
