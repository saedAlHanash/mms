import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:mms/core/widgets/spinner_widget.dart';

import '../strings/app_color_manager.dart';

class MyCheckboxWidget extends StatefulWidget {
  const MyCheckboxWidget({
     super.key,
    required this.items,
    this.buttonBuilder,
    this.onSelected,
    this.isRadio,
  });

  final List<SpinnerItem> items;
  final bool? isRadio;
  final GroupButtonValueBuilder<SpinnerItem>? buttonBuilder;
  final Function(SpinnerItem value, int index, bool isSelected)? onSelected;

  @override
  State<MyCheckboxWidget> createState() => _MyCheckboxWidgetState();
}

class _MyCheckboxWidgetState extends State<MyCheckboxWidget> {
  final controller = GroupButtonController();

  @override
  void initState() {

    for (var i = 0; i < widget.items.length; i++) {
      if (widget.items[i].isSelected) {
        controller.selectIndex(i);
        break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GroupButton<SpinnerItem>(
      controller: controller,
      buttons: widget.items,
      buttonBuilder: widget.buttonBuilder ??
          (selected, value, context) {
            return SizedBox(
              width: 0.4.sw,
              height: 40.0.h,
              child: DrawableText(
                text: value.name ?? '',
                maxLines: 1,
                color: selected ? AppColorManager.mainColor : AppColorManager.textColor,
                size: 16.0.spMin,
                drawableStart: Radio<bool>(
                  value: selected,
                  onChanged: (value) {},
                  groupValue: true,
                ),
              ),
            );
          },
      onSelected: widget.onSelected,
      enableDeselect: !(widget.isRadio ?? false),
      options: const GroupButtonOptions(
        crossGroupAlignment: CrossGroupAlignment.start,
        mainGroupAlignment: MainGroupAlignment.start,
      ),
      isRadio: widget.isRadio ?? false,
    );
  }
}
