import 'package:rphu_app/src/features/rphu_order/data/models/rphu_order_model.dart';

class RPHUProductEntity {
  String? jsonrpc;
  int? id;
  RPHUResultEntity? result;

  RPHUProductEntity({this.jsonrpc, this.id, this.result});
}

class RPHUResultEntity {
  List<RPHUProductDataEntity>? data;

  RPHUResultEntity({this.data});
}

class RPHUProductDataEntity {
  int? id;
  String? name;
  UomId? uomId;

  RPHUProductDataEntity({this.id, this.name, this.uomId});
}
