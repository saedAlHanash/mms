import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:mms/core/widgets/spinner_widget.dart';

import 'package:mms/core/strings/app_color_manager.dart';

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
              width: 1.0.sw,
              height: 40.0.h,
              child: DrawableText(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                text: value.name ?? '',
                maxLines: 1,
                matchParent: true,
                color: selected ? AppColorManager.primary700 : AppColorManager.neutral700,
                size: 16.0.sp,
                drawablePadding: 10.0.w,
                drawableStart: _RadioDot(selected: selected),
              ),
            );
          },
      onSelected: widget.onSelected,
      options: const GroupButtonOptions(
        crossGroupAlignment: CrossGroupAlignment.start,
        mainGroupAlignment: MainGroupAlignment.start,
      ),
      isRadio: widget.isRadio ?? false,
    );
  }
}

/// 20px radio: selected = filled `primary500` ring with white center,
/// unselected = 2px `neutral500` ring.
class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0.r,
      height: 20.0.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColorManager.neutral0,
        border: Border.all(
          color: selected ? AppColorManager.primary500 : AppColorManager.neutral500,
          width: selected ? 6.0.r : 2.0.r,
        ),
      ),
    );
  }
}
