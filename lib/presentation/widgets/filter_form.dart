import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/logic/cubit/doctor_appointments_cubit/doctor_appointments_cubit.dart';
import 'package:clinic/presentation/widgets/custom_button.dart';
import 'package:clinic/presentation/widgets/date_picker_feild.dart';
import 'package:clinic/presentation/widgets/drop_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FilterForm extends StatefulWidget {
  const FilterForm({super.key});

  @override
  State<FilterForm> createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  final TextEditingController _dateController = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  String? _selectedState = 'All';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.only(top: 13, left: 20, bottom: 12),
        child: SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Date:   ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Flexible(
                    child: DatePickerField(
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      tColor: Colors.white,
                      hintText: 'Select Day',
                      controller: _dateController,
                      color: Colors.white,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sessions Date is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    'Filter:  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  Flexible(
                    child: DropFeild(
                      tColor: Colors.white,
                      bColor: Colors.white,
                      hint: 'All',
                      items: const ['All', 'Available', 'Booked'],
                      selectedItem: _selectedState,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedState = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              CustomButton(
                text: 'Apply',
                height: 33,
                width: 120,
                buttonColor: Colors.white,
                textColor: ColorsManager.mainAppColor,
                onTap: getFilteredSessions,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getFilteredSessions() {
    DateTime date = DateTime.parse(_dateController.text);
    context.read<DoctorAppointmentsCubit>().getFilteredAppointments(
      year: date.year,
      month: date.month,
      day: date.day,
      isBooked: getValueFromText(_selectedState!),
    );
  }

  bool? getValueFromText(String text) {
    switch (text) {
      case 'All':
        return null;
      case 'Available':
        return false;
      case 'Booked':
        return true;
      default:
        throw Exception('Invalid value: $text');
    }
  }
}
