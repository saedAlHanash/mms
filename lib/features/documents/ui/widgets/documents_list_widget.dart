import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/helper/launcher_helper.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/features/documents/data/response/documents_response.dart';
import 'package:mms/generated/l10n.dart';

/// Vertical list of committee documents inside one card.
class DocumentsListWidget extends StatelessWidget {
  const DocumentsListWidget({super.key, required this.documents});

  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    if (documents.isEmpty) {
      return EmptyStateWidget.inline(
        icon: Icons.description_outlined,
        title: S.of(context).noDocumentsYet,
        description: S.of(context).noDocumentsYetDescription,
      );
    }

    final children = <Widget>[];
    for (var i = 0; i < documents.length; i++) {
      if (i > 0) {
        children.add(Padding(
          padding: EdgeInsetsDirectional.only(start: 66.0.w),
          child: const Divider(height: 1, color: AppColorManager.neutral50),
        ));
      }
      children.add(_DocumentRow(document: documents[i]));
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: AppColorManager.neutral100),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: Column(children: children),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({required this.document});

  final Document document;

  @override
  Widget build(BuildContext context) {
    final published = document.isPublished;

    return Container(
      constraints: BoxConstraints(minHeight: 64.0.h),
      padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 10.0.h),
      child: Row(
        children: [
          IconTile(
            icon: Icons.description_outlined,
            size: 40,
            iconSize: 20,
            tone: published ? .primary : .neutral,
          ),
          12.0.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                DrawableText(
                  text: document.name,
                  size: 15.0.sp,
                  fontWeight: .w600,
                  color: AppColorManager.neutral900,
                  maxLines: 1,
                ),
                DrawableText(
                  text: published ? S.of(context).published : S.of(context).unpublished,
                  size: 13.0.sp,
                  fontWeight: .w600,
                  color: published ? AppColorManager.successText : AppColorManager.neutral500,
                  drawablePadding: 6.0.w,
                  drawableStart: Container(
                    width: 7.0.r,
                    height: 7.0.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: published ? AppColorManager.success : Colors.transparent,
                      border: published ? null : Border.all(color: AppColorManager.neutral500, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          8.0.horizontalSpace,
          Tooltip(
            message: S.of(context).download,
            child: Material(
              color: published ? AppColorManager.primary50 : AppColorManager.neutral50,
              borderRadius: BorderRadius.circular(10.0.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0.r),
                onTap: published ? () => LauncherHelper.openPage(document.media.savedPath) : null,
                child: SizedBox(
                  width: 44.0.r,
                  height: 44.0.r,
                  child: Center(
                    child: ImageMultiType(
                      url: Icons.download_rounded,
                      width: 20.0.r,
                      height: 20.0.r,
                      color: published ? AppColorManager.primary600 : AppColorManager.neutral300,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
