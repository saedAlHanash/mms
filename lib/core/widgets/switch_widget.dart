import 'package:flutter/material.dart';
import 'package:mms/core/strings/app_color_manager.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    super.key,
    required this.initialVal,
    required this.onChange,
  });

  final bool initialVal;
  final Function(bool) onChange;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool val = false;

  @override
  void initState() {
    val = widget.initialVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: val,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: AppColorManager.lightGrayAb,
      trackOutlineColor: WidgetStatePropertyAll(
          val ? Colors.green : AppColorManager.lightGrayAb),
      activeThumbColor: Colors.white,
      activeTrackColor: Colors.green,
      onChanged: (value) {
        val = value;
        setState(() => widget.onChange.call(value));
      },
    );
  }
}
