import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectSingeDateScrollWidget extends StatelessWidget {
  const SelectSingeDateScrollWidget({
    super.key,
    this.onSelect,
    this.initial,
    this.maxDate,
    this.minDate,
  });

  final DateTime? initial;
  final DateTime? maxDate;
  final DateTime? minDate;
  final Function(DateTime? selected)? onSelect;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final datePicked = await showDatePicker(
          context: context,
          initialDate: initial,
          firstDate: minDate ?? DateTime(1900),
          lastDate: maxDate ?? DateTime(2052),
          initialDatePickerMode: DatePickerMode.year,
          initialEntryMode: DatePickerEntryMode.calendarOnly
        );
        //
        // var datePicked = await DatePicker.showSimpleDatePicker(
        //   context,
        //   backgroundColor: Colors.white,
        //   initialDate: initial,
        //   firstDate: minDate,
        //   lastDate: maxDate,
        //   dateFormat: "dd-MMMM-yyyy",
        //   looping: true,
        // );
        if (datePicked != null) onSelect?.call(datePicked);
      },
      icon: Icon(
        Icons.date_range,
        size: 30.0.r,
      ),
    );
  }
}
