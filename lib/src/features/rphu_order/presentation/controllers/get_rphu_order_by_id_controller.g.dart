// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rphu_order_by_id_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$GetRPHUOrderByIdControllerHash() =>
    r'82bbe3da87b585ba3c11aee8b0254ac6a9371f7d';

/// See also [GetRPHUOrderByIdController].
class GetRPHUOrderByIdControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetRPHUOrderByIdController,
        OrderResultDataEntity?> {
  GetRPHUOrderByIdControllerProvider(
    this.id,
  ) : super(
          () => GetRPHUOrderByIdController()..id = id,
          from: getRPHUOrderByIdControllerProvider,
          name: r'getRPHUOrderByIdControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$GetRPHUOrderByIdControllerHash,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is GetRPHUOrderByIdControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<OrderResultDataEntity?> runNotifierBuild(
    covariant _$GetRPHUOrderByIdController notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}

typedef GetRPHUOrderByIdControllerRef
    = AutoDisposeAsyncNotifierProviderRef<OrderResultDataEntity?>;

/// See also [GetRPHUOrderByIdController].
final getRPHUOrderByIdControllerProvider = GetRPHUOrderByIdControllerFamily();

class GetRPHUOrderByIdControllerFamily
    extends Family<AsyncValue<OrderResultDataEntity?>> {
  GetRPHUOrderByIdControllerFamily();

  GetRPHUOrderByIdControllerProvider call(
    int id,
  ) {
    return GetRPHUOrderByIdControllerProvider(
      id,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<GetRPHUOrderByIdController,
      OrderResultDataEntity?> getProviderOverride(
    covariant GetRPHUOrderByIdControllerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getRPHUOrderByIdControllerProvider';
}

abstract class _$GetRPHUOrderByIdController
    extends BuildlessAutoDisposeAsyncNotifier<OrderResultDataEntity?> {
  late final int id;

  FutureOr<OrderResultDataEntity?> build(
    int id,
  );
}
