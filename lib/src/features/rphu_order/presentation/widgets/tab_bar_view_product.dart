import 'package:flutter/material.dart';
import 'package:rphu_app/src/features/rphu_order/data/models/rphu_order_model.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_order_entity.dart';

class TabBarViewProducts extends StatelessWidget {
  const TabBarViewProducts({
    Key? key,
    required this.fromIds,
    required this.toIds,
    required this.byProductIds,
  }) : super(key: key);

  final List<FromIdsEntity> fromIds;
  final List<ToIdsEntity> toIds;
  final List<ByProductIdEntity> byProductIds;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: [
          ListView.separated(
            itemBuilder: (context, index) => _buildListTile(
                fromIds[index].productId,
                fromIds[index].uomId,
                fromIds[index].qty.toString()),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: fromIds.length,
          ),
          ListView.separated(
            itemBuilder: (context, index) => _buildListTile(
                toIds[index].productId,
                toIds[index].uomId,
                toIds[index].qty.toString()),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: toIds.length,
          ),
          ListView.separated(
            itemBuilder: (context, index) => _buildListTile(
                byProductIds[index].productId,
                byProductIds[index].uomId,
                byProductIds[index].qty.toString()),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: byProductIds.length,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    ProductId productId,
    UomId uomId,
    String qty,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            'Product ID: ${productId[0]}',
          ),
          subtitle: Text(productId[1]),
        ),
        ListTile(
          title: const Text(
            'Jumlah',
          ),
          subtitle: Text(qty),
        ),
        ListTile(
          title: const Text(
            'Bobot',
          ),
          subtitle: Text('${uomId[0]} ${uomId[1]}'),
        ),
      ],
    );
  }
}
