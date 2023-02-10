// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rphu_order_controller.dart';

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

String _$GetRPHUOrderControllerHash() =>
    r'523cbe0830aa0d300073442f60fbeef7a7902c76';

/// See also [GetRPHUOrderController].
class GetRPHUOrderControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GetRPHUOrderController,
        List<OrderResultDataEntity>> {
  GetRPHUOrderControllerProvider({
    this.id,
    this.offset,
    this.limit,
    this.name,
  }) : super(
          () => GetRPHUOrderController()
            ..id = id
            ..offset = offset
            ..limit = limit
            ..name = name,
          from: getRPHUOrderControllerProvider,
          name: r'getRPHUOrderControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$GetRPHUOrderControllerHash,
        );

  final int? id;
  final int? offset;
  final int? limit;
  final String? name;

  @override
  bool operator ==(Object other) {
    return other is GetRPHUOrderControllerProvider &&
        other.id == id &&
        other.offset == offset &&
        other.limit == limit &&
        other.name == name;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<List<OrderResultDataEntity>> runNotifierBuild(
    covariant _$GetRPHUOrderController notifier,
  ) {
    return notifier.build(
      id: id,
      offset: offset,
      limit: limit,
      name: name,
    );
  }
}

typedef GetRPHUOrderControllerRef
    = AutoDisposeAsyncNotifierProviderRef<List<OrderResultDataEntity>>;

/// See also [GetRPHUOrderController].
final getRPHUOrderControllerProvider = GetRPHUOrderControllerFamily();

class GetRPHUOrderControllerFamily
    extends Family<AsyncValue<List<OrderResultDataEntity>>> {
  GetRPHUOrderControllerFamily();

  GetRPHUOrderControllerProvider call({
    int? id,
    int? offset,
    int? limit,
    String? name,
  }) {
    return GetRPHUOrderControllerProvider(
      id: id,
      offset: offset,
      limit: limit,
      name: name,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<GetRPHUOrderController,
      List<OrderResultDataEntity>> getProviderOverride(
    covariant GetRPHUOrderControllerProvider provider,
  ) {
    return call(
      id: provider.id,
      offset: provider.offset,
      limit: provider.limit,
      name: provider.name,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'getRPHUOrderControllerProvider';
}

abstract class _$GetRPHUOrderController
    extends BuildlessAutoDisposeAsyncNotifier<List<OrderResultDataEntity>> {
  late final int? id;
  late final int? offset;
  late final int? limit;
  late final String? name;

  FutureOr<List<OrderResultDataEntity>> build({
    int? id,
    int? offset,
    int? limit,
    String? name,
  });
}
