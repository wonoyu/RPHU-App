import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rphu_app/src/core/constants/colors.dart';
import 'package:rphu_app/src/core/reusable_components/custom_snackbars.dart';
import 'package:rphu_app/src/features/rphu_order/domain/entities/rphu_product_entity.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/controllers/create_rphu_order_controller.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/controllers/get_rphu_product_controller.dart';
import 'package:rphu_app/src/features/rphu_order/presentation/rphu_order_extensions.dart';

class RPHUOrderCreatePage extends ConsumerStatefulWidget {
  const RPHUOrderCreatePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RPHUOrderCreatePageState();
}

class _RPHUOrderCreatePageState extends ConsumerState<RPHUOrderCreatePage> {
  final _description = TextEditingController();
  final _date = TextEditingController();
  final _qtyFromIds = TextEditingController();
  final _qtyToIds = TextEditingController();
  final _qtyByProductIds = TextEditingController();
  RPHUProductDataEntity? _selectedFromIds;
  RPHUProductDataEntity? _selectedToIds;
  RPHUProductDataEntity? _selectedByProductIds;
  final List<List<dynamic>> _fromIds = [];
  final List<List<dynamic>> _toIds = [];
  final List<List<dynamic>> _byProductIds = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(getRPHUProductControllerProvider);
    ref.listen(createRphuOrderControllerProvider,
        (previous, next) => next.onCreateRphuOrder(context, ref));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
      ),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildTitle('Deskripsi', context),
                    const SizedBox(height: 4.0),
                    TextFormField(
                      controller: _description,
                      validator: (value) {
                        if (value == null) return null;
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _buildTitle('Tanggal', context),
                    const SizedBox(height: 4.0),
                    TextFormField(
                      controller: _date,
                      readOnly: true,
                      validator: (value) {
                        if (value == null) return null;
                        if (value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onTap: () async {
                        final result = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime.now(),
                        );
                        if (result == null) {
                          CustomSnackbars.showErrorSnackbar(
                              context, 'Tanggal tidak dipilih');
                          return;
                        }
                        _date.text = DateFormat('yyyy-MM-dd').format(result);
                      },
                      decoration: InputDecoration(
                        labelText: 'Tanggal',
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      ),
                    ),
                    // From Ids Product
                    const SizedBox(height: 16.0),
                    _buildTitle('From Ids', context),
                    const SizedBox(height: 4.0),
                    products.maybeWhen(
                        data: (data) {
                          return DropdownButtonFormField(
                            value: _selectedFromIds,
                            validator: (value) {
                              if (_fromIds.isEmpty) return 'Required';
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0)),
                            hint: const Text('Pilih untuk tambah produk'),
                            selectedItemBuilder: (context) => data
                                .map<Widget>((e) => Text(
                                    _selectedFromIds?.name ??
                                        'Pilih untuk tambah produk'))
                                .toList(),
                            items: data
                                .map<DropdownMenuItem<RPHUProductDataEntity>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name!),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedFromIds = value);
                              }
                            },
                          );
                        },
                        orElse: () => const SizedBox.shrink()),
                    const SizedBox(height: 8.0),
                    if (_selectedFromIds != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: _qtyFromIds,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: 'Qty',
                                  errorText: _qtyFromIds.text.isEmpty
                                      ? 'Required'
                                      : null),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(4.0)),
                              onPressed: () {
                                if (_qtyFromIds.text.isNotEmpty) {
                                  _fromIds.insert(0, [
                                    0,
                                    0,
                                    {
                                      'product_id': _selectedFromIds!.id,
                                      'qty': int.parse(_qtyFromIds.text)
                                    }
                                  ]);
                                  _selectedFromIds = null;
                                  setState(() {});
                                  _qtyFromIds.clear();
                                }
                              },
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8.0),
                    ..._fromIds.map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextFormField(
                            initialValue:
                                '${e[2]['product_id']}, ${e[2]['qty']}',
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (_fromIds.length > 1) {
                                    setState(() => _fromIds.remove(e));
                                  }
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        )),
                    // TO IDS PRODUCT
                    const SizedBox(height: 16.0),
                    _buildTitle('To Ids', context),
                    const SizedBox(height: 4.0),
                    products.maybeWhen(
                        data: (data) {
                          return DropdownButtonFormField(
                            value: _selectedToIds,
                            validator: (value) {
                              if (_toIds.isEmpty) return 'Required';
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0)),
                            hint: const Text('Pilih untuk tambah produk'),
                            selectedItemBuilder: (context) => data
                                .map<Widget>((e) => Text(_selectedToIds?.name ??
                                    'Pilih untuk tambah produk'))
                                .toList(),
                            items: data
                                .map<DropdownMenuItem<RPHUProductDataEntity>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name!),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedToIds = value);
                              }
                            },
                          );
                        },
                        orElse: () => const SizedBox.shrink()),
                    const SizedBox(height: 8.0),
                    if (_selectedToIds != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: _qtyToIds,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: 'Qty',
                                  errorText: _qtyToIds.text.isEmpty
                                      ? 'Required'
                                      : null),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(4.0)),
                              onPressed: () {
                                if (_qtyToIds.text.isNotEmpty) {
                                  _toIds.insert(0, [
                                    0,
                                    0,
                                    {
                                      'product_id': _selectedToIds!.id,
                                      'qty': int.parse(_qtyToIds.text)
                                    }
                                  ]);
                                  _selectedToIds = null;
                                  setState(() {});
                                  _qtyToIds.clear();
                                }
                              },
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8.0),
                    ..._toIds.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          initialValue: '${e[2]['product_id']}, ${e[2]['qty']}',
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (_toIds.length > 1) {
                                  setState(() => _toIds.remove(e));
                                }
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _buildTitle('By Product Ids', context),
                    const SizedBox(height: 4.0),
                    products.maybeWhen(
                        data: (data) {
                          return DropdownButtonFormField(
                            value: _selectedByProductIds,
                            validator: (value) {
                              if (_byProductIds.isEmpty) return 'Required';
                              return null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8.0)),
                            hint: const Text('Pilih untuk tambah produk'),
                            selectedItemBuilder: (context) => data
                                .map<Widget>((e) => Text(
                                    _selectedByProductIds?.name ??
                                        'Pilih untuk tambah produk'))
                                .toList(),
                            items: data
                                .map<DropdownMenuItem<RPHUProductDataEntity>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name!),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedByProductIds = value);
                              }
                            },
                          );
                        },
                        orElse: () => const SizedBox.shrink()),
                    const SizedBox(height: 8.0),
                    if (_selectedByProductIds != null)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: _qtyByProductIds,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: 'Qty',
                                  errorText: _qtyByProductIds.text.isEmpty
                                      ? 'Required'
                                      : null),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(4.0)),
                              onPressed: () {
                                if (_qtyByProductIds.text.isNotEmpty) {
                                  _byProductIds.insert(0, [
                                    0,
                                    0,
                                    {
                                      'product_id': _selectedByProductIds!.id,
                                      'qty': int.parse(_qtyByProductIds.text)
                                    }
                                  ]);
                                  _selectedByProductIds = null;
                                  setState(() {});
                                  _qtyByProductIds.clear();
                                }
                              },
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8.0),
                    ..._byProductIds.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextFormField(
                          initialValue: '${e[2]['product_id']}, ${e[2]['qty']}',
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (_byProductIds.length > 1) {
                                  setState(() => _byProductIds.remove(e));
                                }
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromWidth(
                              MediaQuery.of(context).size.width)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(createRphuOrderControllerProvider.notifier)
                              .createRphuOrder(
                                _description.text,
                                _date.text,
                                _fromIds,
                                _toIds,
                                _byProductIds,
                              );
                        }
                      },
                      child: const Text('Tambah'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String title, BuildContext context) => Text(
        title,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: AppColors.mainGreen, fontSize: 14.0),
      );

  @override
  void dispose() {
    _description.dispose();
    _date.dispose();
    _qtyByProductIds.dispose();
    _qtyFromIds.dispose();
    _qtyToIds.dispose();
    super.dispose();
  }
}
