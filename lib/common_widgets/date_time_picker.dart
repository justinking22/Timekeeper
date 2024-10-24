import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timekeeper/app/home/jobs/job_entries/format.dart';
import 'package:timekeeper/app/home/jobs/job_entries/input_dropdown.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    this.labelText,
    this.selectedDate,
    this.selectedTime,
    this.onSelectedDate,
    this.selectTime,
    required void Function(dynamic time) onSelectedTime,
  });

  final String? labelText;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final ValueChanged<DateTime>? onSelectedDate;
  final ValueChanged<TimeOfDay>? selectTime;

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate!(pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime =
        await showTimePicker(context: context, initialTime: selectedTime!);
    if (pickedTime != null && pickedTime != selectedTime) {
      selectTime!(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.titleLarge;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: labelText!,
            valueText: Format.date(selectedDate!),
            valueStyle: valueStyle!,
            onPressed: () => _selectDate(context),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          flex: 4,
          child: InputDropdown(
            valueText: selectedTime!.format(context),
            valueStyle: valueStyle,
            onPressed: () => _selectTime(context),
          ),
        ),
      ],
    );
  }
}
