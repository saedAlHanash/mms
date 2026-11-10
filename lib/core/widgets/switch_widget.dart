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
      inactiveThumbColor: AppColorManager.neutral0,
      inactiveTrackColor: AppColorManager.neutral200,
      trackOutlineColor: WidgetStatePropertyAll(val ? AppColorManager.primary500 : AppColorManager.neutral200),
      activeThumbColor: AppColorManager.neutral0,
      activeTrackColor: AppColorManager.primary500,
      onChanged: (value) {
        val = value;
        setState(() => widget.onChange.call(value));
      },
    );
  }
}
