import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/generated/l10n.dart';

/// Bottom space each Home tab keeps free so the floating [NewNav] does not
/// cover its last item.
double get homeNavBarSpace => 110.0.h;

/// Floating bottom navigation (3 tabs).
class NewNav extends StatefulWidget {
  const NewNav({
    super.key,
    required this.controller,
    required this.onChange,
  });

  final PageController controller;
  final Function(int) onChange;

  @override
  State<NewNav> createState() => _NewNavState();
}

class _NewNavState extends State<NewNav> {
  int selectedIndex = 0;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() => selectedIndex = widget.controller.page!.toInt());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_outlined, S.of(context).navCommittees),
      (Icons.calendar_month_outlined, S.of(context).navCalendar),
      (Icons.settings_outlined, S.of(context).navSettings),
    ];

    return SafeArea(
      top: false,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.0.w, 0, 16.0.w, 20.0.h),
        padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 8.0.h),
        decoration: BoxDecoration(
          color: AppColorManager.neutral0,
          borderRadius: BorderRadius.circular(20.0.r),
          border: Border.all(color: AppColorManager.neutral50),
          boxShadow: MyStyle.elevation2,
        ),
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: _NavItem(
                  icon: items[i].$1,
                  label: items[i].$2,
                  selected: selectedIndex == i,
                  onTap: () {
                    widget.onChange.call(i);
                    setState(() => selectedIndex = i);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0.h),
          child: Column(
            mainAxisSize: .min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56.0.w,
                height: 32.0.h,
                alignment: .center,
                decoration: BoxDecoration(
                  color: selected ? AppColorManager.primary100 : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: ImageMultiType(
                  url: icon,
                  width: 22.0.r,
                  height: 22.0.r,
                  color: selected ? AppColorManager.primary500 : AppColorManager.neutral500,
                ),
              ),
              4.0.verticalSpace,
              DrawableText(
                text: label,
                size: 12.0.sp,
                maxLines: 1,
                fontWeight: selected ? .w700 : .w600,
                color: selected ? AppColorManager.primary700 : AppColorManager.neutral500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
