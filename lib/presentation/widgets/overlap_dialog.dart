import 'package:clinic/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

class OverlapDialog extends StatelessWidget {
  final String customMessage;

  const OverlapDialog({super.key, required this.customMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Appointment Conflict',
        style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
      ),
      content: Text(
        customMessage,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
        ),
      ),
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
