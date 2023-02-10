import 'package:rphu_app/src/features/rphu_order/data/models/rphu_order_model.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_product_entity.dart';

class RPHUProductModel {
  String? jsonrpc;
  int? id;
  RPHUResultModel? result;

  RPHUProductModel({this.jsonrpc, this.id, this.result});

  RPHUProductModel.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null
        ? RPHUResultModel.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jsonrpc'] = jsonrpc;
    data['id'] = id;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class RPHUResultModel {
  List<RPHUProductDataModel>? data;

  RPHUResultModel({this.data});

  RPHUResultModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RPHUProductDataModel>[];
      json['data'].forEach((v) {
        data!.add(RPHUProductDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RPHUProductDataModel {
  int? id;
  String? name;
  UomId? uomId;

  RPHUProductDataModel({this.id, this.name, this.uomId});

  RPHUProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    uomId = json['uom_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['uom_id'] = uomId;
    return data;
  }

  RPHUProductDataEntity toEntity() => RPHUProductDataEntity(
        id: id,
        name: name,
        uomId: uomId,
      );
}
