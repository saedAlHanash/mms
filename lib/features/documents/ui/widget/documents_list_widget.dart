import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/helper/launcher_helper.dart';
import 'package:mms/core/widgets/my_button.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/documents_response.dart';

class DocumentsListWidget extends StatelessWidget {
  const DocumentsListWidget({super.key, required this.documents});

  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0.h,
      width: 1.0.sw,
      child: ListView.separated(
        itemCount: documents.length,
        separatorBuilder: (_, i) => 20.0.horizontalSpace,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final document = documents[i];
          return SizedBox(
            width: 250.0.w,
            height: 200.0.h,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawableText(text: document.name),
                      DrawableText(
                        text:
                            document.isPublished ? 'Published' : 'UnPublished',
                        size: 14.0.sp,
                        fontFamily: FontManager.cairoBold.name,
                        drawablePadding: 5.0.w,
                        drawableStart: Container(
                          width: 10.0.r,
                          height: 10.0.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: document.isPublished
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                      MyButton(
                        width: 220.0.w,
                        onTap: () {
                          LauncherHelper.openPage(document.media.savedPath);
                        },
                        text: S.of(context).downloadFile,
                      ),
                    ],
                  ),
                ),
                const IgnorePointer(
                  child: ImageMultiType(
                    url: Assets.iconsDocumentBackground,
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
