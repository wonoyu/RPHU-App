import 'package:flutter/material.dart';
import 'package:rphu_app/src/core/constants/colors.dart';

class CustomDialogs {
  static showLoadingDialog(BuildContext context) => showDialog(
        barrierDismissible: false,
        routeSettings: const RouteSettings(name: '/loading'),
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.white,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    'Loading',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
          );
        },
      );

  static showAlertDialog(BuildContext context, VoidCallback onDelete) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Konfirmasi Hapus'),
            content: const Text(
                'Dengan menekan tombol hapus, maka data order ini akan terhapus'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: onDelete,
                child: const Text('Hapus'),
              ),
            ],
          );
        },
      );

  static showUpdateRphuOrderStatusDialog(
          BuildContext context, void Function(String) onUpdate) =>
      showDialog(
        context: context,
        builder: (context) => UpdateRPHUOrderStatusAlertDialog(
          onUpdate: onUpdate,
        ),
      );
}

class UpdateRPHUOrderStatusAlertDialog extends StatefulWidget {
  const UpdateRPHUOrderStatusAlertDialog({Key? key, required this.onUpdate})
      : super(key: key);

  final void Function(String) onUpdate;

  @override
  State<UpdateRPHUOrderStatusAlertDialog> createState() =>
      _UpdateRPHUOrderStatusAlertDialogState();
}

class _UpdateRPHUOrderStatusAlertDialogState
    extends State<UpdateRPHUOrderStatusAlertDialog> {
  String _selectedValue = 'draft';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubah RPHU Order Status'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            selected: _selectedValue == 'draft',
            value: 'draft',
            groupValue: _selectedValue,
            onChanged: (value) => setState(() => _selectedValue = value!),
            title: const Text('Draft'),
          ),
          RadioListTile<String>(
            selected: _selectedValue == 'validate',
            value: 'validate',
            groupValue: _selectedValue,
            onChanged: (value) => setState(() => _selectedValue = value!),
            title: const Text('Validate'),
          ),
          RadioListTile<String>(
            selected: _selectedValue == 'cancel',
            value: 'cancel',
            groupValue: _selectedValue,
            onChanged: (value) => setState(() => _selectedValue = value!),
            title: const Text('Cancel'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () => widget.onUpdate(_selectedValue),
          child: const Text('Ubah'),
        ),
      ],
    );
  }
}
