import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/core/utils/text_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? hintText;
  final DateTime firstDate;
  final DateTime lastDate;
  final Color color;
  final Color tColor;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.validator,
    this.hintText = 'Enter your birth date',
    required this.firstDate,
    required this.lastDate,
    this.color = ColorsManager.mainAppColor,
    this.tColor = Colors.black,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime dateTime = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsManager.mainAppColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        dateTime = pickedDate;
        widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      readOnly: true,
      style: TextStyle(color: widget.tColor),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyleManager.loginFeildHint,
        suffixIcon: Icon(Icons.calendar_today, color: widget.color, size: 20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: widget.color, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: widget.color, width: 1.w),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
