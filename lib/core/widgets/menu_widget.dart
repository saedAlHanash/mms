import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../util/my_style.dart';

class PopupMenuItemModel {
  final dynamic label;
  final dynamic icon;
  final Function()? onTap;

  PopupMenuItemModel({
    required this.label,
    required this.icon,
    this.onTap,
  });
}

class DynamicPopupMenu extends StatelessWidget {
  final List<PopupMenuItemModel> items;
  final dynamic icon;
  final bool loading;

  const DynamicPopupMenu({
    super.key,
    required this.items,
    this.icon,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color;
    if (loading) {
      return SizedBox(
        height: 24.0.dg,
        width: 24.0.dg,
        child: MyStyle.loadingWidget(),
      );
    }
    return PopupMenuButton<int>(
      offset: const Offset(0, 10.0),
      icon: ImageMultiType(url: icon ?? Icons.more_vert),
      onSelected: (index) {
        items[index].onTap?.call();
      },
      itemBuilder: (popupContext) {
        return List.generate(
          items.length,
          (index) {
            final item = items[index];
            final isEnabled = item.onTap != null;

            final Widget itemIcon = ImageMultiType(
              url: item.icon,
              width: 20.0.r,
              color: iconColor,
            );

            final Widget childWidget;
            if (item.label is Widget) {
              childWidget = Row(
                children: [
                  itemIcon,
                  10.0.horizontalSpace,
                  item.label,
                ],
              );
            } else {
              childWidget = DrawableText(
                text: item.label.toString(),
                drawablePadding: 10.0.w,
                drawableStart: itemIcon,
              );
            }

            return PopupMenuItem<int>(
                value: index,
                enabled: isEnabled,
                child: DefaultTextStyle(
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: isEnabled ? theme.textTheme.bodyMedium!.color : theme.disabledColor,
                  ),
                  child: Opacity(
                    opacity: isEnabled ? 1 : 0.5,
                    child: childWidget,
                  ),
                ));
          },
        );
      },
    );
  }
}
