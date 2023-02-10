import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateRPHUOrderController extends AsyncNotifier<String?> {
  @override
  FutureOr<String?> build() {
    return null;
  }

  final description = TextEditingController();
  final date = TextEditingController();

  List<List<dynamic>> fromIds = [];
  List<List<dynamic>> toIds = [];
  List<List<dynamic>> byProductIds = [];

  void addFromIds(Map<String, dynamic> product) {
    fromIds.add([0, 0, product]);
  }

  void addToIds(Map<String, dynamic> product) {
    toIds.add([0, 0, product]);
  }

  void addByProducIds(Map<String, dynamic> product) {
    byProductIds.add([0, 0, product]);
  }

  void dispose() {
    ref.onDispose(() {
      description.dispose();
      date.dispose();
    });
  }
}
