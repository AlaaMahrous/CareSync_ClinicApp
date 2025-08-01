import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomContentDialog extends StatelessWidget {
  final String customTitle;
  final Widget content;

  const CustomContentDialog({
    super.key,
    required this.customTitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        customTitle,
        style: const TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16, color: ColorsManager.mainAppColor),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      elevation: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    );
  }
}
