import 'package:rphu_app/src/features/rphu_order/data/models/rphu_order_model.dart';

class RPHUOrderEntity {
  RPHUOrderEntity({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  final String jsonrpc;
  final int? id;
  final OrderResultEntity result;
}

class OrderResultEntity {
  OrderResultEntity({
    required this.data,
  });

  final List<OrderResultDataEntity> data;
}

class OrderResultDataEntity {
  OrderResultDataEntity({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.userId,
    required this.state,
    required this.fromIds,
    required this.toIds,
    required this.byProductIds,
  });

  final int id;
  final String name;
  final String date;
  final String description;
  final UserId userId;
  final String state;
  final List<FromIdsEntity> fromIds;
  final List<ToIdsEntity> toIds;
  final List<ByProductIdEntity> byProductIds;
}

class ToIdsEntity {
  ToIdsEntity({
    required this.id,
    required this.productId,
    required this.qty,
    required this.uomId,
    required this.secondQty,
    required this.secondUom,
  });

  final int id;
  final ProductId productId;
  final double qty;
  final UomId uomId;
  final double secondQty;
  final bool secondUom;
}

class FromIdsEntity {
  FromIdsEntity({
    required this.id,
    required this.productId,
    required this.qty,
    required this.uomId,
    required this.secondQty,
    required this.secondUom,
  });

  final int id;
  final ProductId productId;
  final double qty;
  final UomId uomId;
  final double secondQty;
  final bool secondUom;
}

class ByProductIdEntity {
  ByProductIdEntity(
      {required this.id,
      required this.productId,
      required this.qty,
      required this.uomId});

  final int id;
  final ProductId productId;
  final double qty;
  final UomId uomId;
}
