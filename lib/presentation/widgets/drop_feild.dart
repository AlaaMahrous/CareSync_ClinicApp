import 'package:clinic/core/utils/colors_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropFeild extends StatelessWidget {
  const DropFeild({
    super.key,
    this.selectedItem,
    this.onChanged,
    required this.hint,
    required this.items,
  });
  final String? selectedItem;
  final String hint;
  final void Function(String?)? onChanged;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ColorsManager.mainAppColor, width: 1.3.w),
      ),
      child: Center(
        child: DropdownButton2<String>(
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
          ),
          isDense: true,
          isExpanded: true,
          value: selectedItem,
          hint: Text(hint),
          items:
              items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
