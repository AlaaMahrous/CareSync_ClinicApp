import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? hintText;

  const TimePickerField({
    super.key,
    required this.controller,
    required this.validator,
    this.hintText = 'Select session time',
  });

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  TimeOfDay time = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: time,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsManager.mainAppColor,
              secondary: ColorsManager.mainAppColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        time = pickedTime;
        final formattedTime = DateFormat(
          'hh:mm a',
        ).format(DateTime(2023, 1, 1, pickedTime.hour, pickedTime.minute));
        widget.controller.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyleManager.loginFeildHint,
        suffixIcon: const Icon(
          Icons.access_time,
          color: ColorsManager.mainAppColor,
          size: 23,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: ColorsManager.mainAppColor, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: ColorsManager.mainAppColor, width: 1.w),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      onTap: () => _selectTime(context),
    );
  }
}
