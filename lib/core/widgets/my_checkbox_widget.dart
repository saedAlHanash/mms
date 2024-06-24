import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/widgets/spinner_widget.dart';

import '../../generated/assets.dart';
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
              width: 1.0.sw,
              height: 40.0.h,
              child: DrawableText(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                text: value.name ?? '',
                maxLines: 1,
                matchParent: true,
                color: selected
                    ? AppColorManager.mainColor
                    : AppColorManager.textColor,
                size: 16.0.spMin,
                drawablePadding: 5.0.w,
                drawableStart: ImageMultiType(
                  url: selected
                      ? Assets.iconsRadioSelected
                      : Assets.iconsRadioNotSelect,
                ),
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
