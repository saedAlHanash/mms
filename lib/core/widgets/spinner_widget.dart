import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../strings/app_color_manager.dart';

class SpinnerWidget<T> extends StatefulWidget {
  const SpinnerWidget({
    super.key,
    required this.items,
    this.hint,
    this.hintText,
    this.hintLabel,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sendFirstItem,
    this.expanded,
    this.isOverButton,
    this.decoration,
  });

  final List<SpinnerItem> items;
  final Widget? hint;
  final String? hintText;
  final String? hintLabel;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final bool? isOverButton;
  final BoxDecoration? decoration;

  @override
  State<SpinnerWidget<T>> createState() => SpinnerWidgetState<T>();
}

class SpinnerWidgetState<T> extends State<SpinnerWidget<T>> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.hintLabel != null)
          DrawableText(
            text: widget.hintLabel ?? '',
            color: AppColorManager.grey,
            size: 14.0.sp,
            matchParent: true,
            padding: const EdgeInsets.symmetric(horizontal: 12.0).r,
            fontFamily: FontManager.cairo.name,
          ),
        DropdownButton2(
          items: widget.items.map(
            (item) {
              return DropdownMenuItem(
                value: item,
                child: DrawableText(
                  selectable: false,
                  text: item.name ?? '',
                  padding: (item.icon == null)
                      ? const EdgeInsets.symmetric(horizontal: 10.0).w
                      : EdgeInsets.only(left: 10.0.w),
                  color: (item.id != -1)
                      ? (item.enable)
                          ? Colors.black
                          : AppColorManager.grey.withOpacity(0.7)
                      : AppColorManager.grey.withOpacity(0.7),
                  drawableStart: item.icon,
                  drawablePadding: 15.0.w,
                ),
              );
            },
          ).toList(),
          value: widget.items.firstWhereOrNull((e) => e.isSelected),
          hint: (widget.hintText != null)
              ? DrawableText(
                  text: widget.hintText!,
                  color: Colors.grey,
                  size: 14.0.sp,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                )
              : widget.hint,
          onChanged: (value) {

            if (widget.onChanged != null) widget.onChanged!(value!);
            if (!(value!).enable) return;

            for (final e in widget.items) {
              e.isSelected = false;
              if (e.id == value.id) {

                e.isSelected = true;
              }
            }
            setState(() {});
          },
          buttonStyleData: ButtonStyleData(
            width: widget.width ?? 0.9.sw,
            height: 51.0.h,
            decoration: widget.decoration ??
                BoxDecoration(
                  color: AppColorManager.f9,
                  borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
                ),
            elevation: 0,
          ),
          dropdownStyleData: DropdownStyleData(
            width: widget.dropdownWidth,
            maxHeight: 300.0.h,
            elevation: 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            isOverButton: widget.isOverButton ?? false,
          ),
          iconStyleData: IconStyleData(
            icon: Row(
              children: [
                ImageMultiType(
                  url: Icons.expand_more,
                  height: 18.0.r,
                  width: 18.0.r,
                ),
                18.0.horizontalSpace,
              ],
            ),
            iconSize: 35.0.spMin,
          ),
          isExpanded: widget.expanded ?? false,
          customButton: widget.customButton,
          underline: 0.0.verticalSpace,
        ),
      ],
    );
  }
}

class SpinnerOutlineTitle extends StatelessWidget {
  const SpinnerOutlineTitle({
    super.key,
    required this.items,
    this.hint,
    this.onChanged,
    this.customButton,
    this.width,
    this.dropdownWidth,
    this.sendFirstItem,
    this.expanded,
    this.decoration,
    this.label = '',
  });

  final List<SpinnerItem> items;
  final Widget? hint;
  final Widget? customButton;
  final Function(SpinnerItem spinnerItem)? onChanged;
  final double? width;
  final double? dropdownWidth;
  final bool? sendFirstItem;
  final bool? expanded;
  final BoxDecoration? decoration;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawableText(
          selectable: false,
          text: label,
          color: AppColorManager.black,
          padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
          size: 18.0.sp,
        ),
        3.0.verticalSpace,
        SpinnerWidget(
          items: items,
          hint: hint,
          onChanged: onChanged,
          customButton: customButton,
          width: width,
          dropdownWidth: dropdownWidth,
          sendFirstItem: sendFirstItem,
          expanded: expanded,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0.r),
            border: Border.all(color: AppColorManager.grey, width: 1.0.r),
          ),
        )
      ],
    );
  }
}

class SpinnerItem {
  SpinnerItem({
    this.name,
    this.id = -2,
    this.isSelected = false,
    this.item,
    this.icon,
    this.enable = true,
  });

  String? name;
  int id;
  bool isSelected;
  bool enable;
  dynamic item;
  Widget? icon;

//<editor-fold desc="Data Methods">

  SpinnerItem copyWith({
    String? name,
    int? id,
    bool? isSelected,
    bool? enable,
    dynamic item,
  }) {
    return SpinnerItem(
      name: name ?? this.name,
      id: id ?? this.id,
      isSelected: isSelected ?? this.isSelected,
      enable: enable ?? this.enable,
      item: item ?? this.item,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'isSelected': isSelected,
      'enable': enable,
      'item': item,
    };
  }

  factory SpinnerItem.fromMap(Map<String, dynamic> map) {
    return SpinnerItem(
      name: map['name'] as String,
      id: map['id'] as int,
      isSelected: map['isSelected'] as bool,
      enable: map['enable'] as bool,
      item: map['item'] as dynamic,
    );
  }

//</editor-fold>
}
