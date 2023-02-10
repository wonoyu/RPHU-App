import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';

typedef UserId = List<dynamic>;
typedef ProductId = List<dynamic>;
typedef UomId = List<dynamic>;

class RPHUOrderModel {
  RPHUOrderModel({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  final String jsonrpc;
  final int? id;
  final OrderResultModel result;

  factory RPHUOrderModel.fromJson(Map<String, dynamic> json) => RPHUOrderModel(
        jsonrpc: json['jsonrpc'],
        id: json['id'],
        result: OrderResultModel.fromJson(json['result']),
      );

  RPHUOrderEntity toEntity() => RPHUOrderEntity(
        jsonrpc: jsonrpc,
        id: id,
        result: result.toEntity(),
      );
}

class OrderResultModel {
  OrderResultModel({
    required this.data,
  });

  final List<OrderResultDataModel> data;

  factory OrderResultModel.fromJson(Map<String, dynamic> json) =>
      OrderResultModel(
        data: List<OrderResultDataModel>.from(
          json['data'].map(
            (e) => OrderResultDataModel.fromJson(e),
          ),
        ),
      );

  OrderResultEntity toEntity() => OrderResultEntity(
        data: List<OrderResultDataEntity>.from(data.map((e) => e.toEntity())),
      );
}

class OrderResultDataModel {
  OrderResultDataModel({
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
  final List<FromIdsModel> fromIds;
  final List<ToIdsModel> toIds;
  final List<ByProductIdModel> byProductIds;

  factory OrderResultDataModel.fromJson(Map<String, dynamic> json) =>
      OrderResultDataModel(
          id: json['id'],
          name: json['name'],
          date: json['date'],
          description: json['description'],
          userId: json['user_id'],
          state: json['state'],
          fromIds: List<FromIdsModel>.from(
              json['from_ids'].map((e) => FromIdsModel.fromJson(e))),
          toIds: List<ToIdsModel>.from(
            json['to_ids'].map((e) => ToIdsModel.fromJson(e)),
          ),
          byProductIds: List<ByProductIdModel>.from(
              json['byproduct_ids'].map((e) => ByProductIdModel.fromJson(e))));

  OrderResultDataEntity toEntity() => OrderResultDataEntity(
      id: id,
      name: name,
      date: date,
      description: description,
      userId: userId,
      state: state,
      fromIds: List<FromIdsEntity>.from(fromIds.map((e) => e.toEntity())),
      toIds: List<ToIdsEntity>.from(toIds.map((e) => e.toEntity())),
      byProductIds:
          List<ByProductIdEntity>.from(byProductIds.map((e) => e.toEntity())));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date,
        'description': description,
        'user_id': userId,
        'state': state,
        'from_ids': fromIds.map((e) => e.toJson()).toList(),
        'to_ids': toIds.map((e) => e.toJson()).toList(),
        'byproduct_ids': byProductIds.map((e) => e.toJson()).toList(),
      };
}

class ToIdsModel {
  ToIdsModel({
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

  factory ToIdsModel.fromJson(Map<String, dynamic> json) => ToIdsModel(
        id: json['id'],
        productId: json['product_id'],
        qty: json['qty'],
        uomId: json['uom_id'],
        secondQty: json['second_qty'],
        secondUom: json['second_uom'],
      );

  ToIdsEntity toEntity() => ToIdsEntity(
        id: id,
        productId: productId,
        qty: qty,
        uomId: uomId,
        secondQty: secondQty,
        secondUom: secondUom,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'qty': qty,
        'uom_id': uomId,
        'second_qty': secondQty,
        'second_uom': secondUom,
      };
}

class FromIdsModel {
  FromIdsModel({
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

  factory FromIdsModel.fromJson(Map<String, dynamic> json) => FromIdsModel(
        id: json['id'],
        productId: json['product_id'],
        qty: json['qty'],
        uomId: json['uom_id'],
        secondQty: json['second_qty'],
        secondUom: json['second_uom'],
      );

  FromIdsEntity toEntity() => FromIdsEntity(
        id: id,
        productId: productId,
        qty: qty,
        uomId: uomId,
        secondQty: secondQty,
        secondUom: secondUom,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'qty': qty,
        'uom_id': uomId,
        'second_qty': secondQty,
        'second_uom': secondUom,
      };
}

class ByProductIdModel {
  ByProductIdModel({
    required this.id,
    required this.productId,
    required this.qty,
    required this.uomId,
  });

  final int id;
  final ProductId productId;
  final double qty;
  final UomId uomId;

  factory ByProductIdModel.fromJson(Map<String, dynamic> json) =>
      ByProductIdModel(
        id: json['id'],
        productId: json['product_id'],
        qty: json['qty'],
        uomId: json['uom_id'],
      );

  ByProductIdEntity toEntity() => ByProductIdEntity(
        id: id,
        productId: productId,
        qty: qty,
        uomId: uomId,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product_id': productId,
        'qty': qty,
        'uom_id': uomId,
      };
}
