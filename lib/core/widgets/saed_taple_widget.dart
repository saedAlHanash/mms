import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';
import 'my_card_widget.dart';

class SaedTableWidget extends StatelessWidget {
  const SaedTableWidget({
    super.key,
    required this.title,
    required this.data,
    this.fullSizeIndex,
    this.fullHeight,
    this.filters,
    this.onTapRecord,
  });

  final List<dynamic> title;
  final List<int>? fullSizeIndex;
  final Widget? filters;
  final Iterable<List<dynamic>> data;
  final double? fullHeight;
  final Function(List<dynamic> e)? onTapRecord;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0).r,
      radios: 15.0.r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.0.verticalSpace,
          TitleWidget(title: title),
          10.0.verticalSpace,
          for (final e in data) ...[
            const Divider(height: 0),
            if (onTapRecord != null)
              InkWell(
                onTap: () => onTapRecord!.call(e),
                child: CellWidget(e: e),
              )
            else
              CellWidget(e: e)
          ],
          15.0.verticalSpace,
          const Divider(),
        ],
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget({super.key, required this.e});

  final List e;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0).h,
      child: Row(
        children: e.mapIndexed(
          (i, e) {
            final widget = e is String
                ? DrawableText(
                    selectable: true,
                    size: 14.0.sp,
                    maxLines: 2,
                    matchParent: true,
                    textAlign: TextAlign.center,
                    text: e.isEmpty ? '-' : e,
                    color: Colors.black,
                  )
                : e is Widget
                    ? e
                    : Container(
                        height: 5,
                        color: Colors.red,
                      );

            return Expanded(child: widget);
          },
        ).toList(),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title});

  final List title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: title.mapIndexed(
        (i, e) {
          final widget = e is String
              ? DrawableText(
                  maxLines: 2,
                  matchParent: true,
                  textAlign: TextAlign.center,
                  text: e,
                  color: Colors.black,
                  fontFamily: FontManager.cairoBold.name,
                )
              : title is Widget
                  ? title as Widget
                  : Container(
                      color: Colors.red,
                      height: 10,
                    );

          return e is Widget ? widget : Expanded(child: widget);
        },
      ).toList(),
    );
  }
}
