import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key, required this.comments});

  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) return 0.0.verticalSpace;
    return MyCardWidget(
      cardColor: AppColorManager.lightGray,
      margin: const EdgeInsets.only(top: 10.0).r,
      radios: 0,
      child: Column(
        children: comments
            .mapIndexed((i, e) => Column(
                  children: [
                    if (i != 0) 20.0.verticalSpace,
                    DrawableText(
                      text: '(${e.party.name})  ${e.text}',
                      matchParent: true,
                      drawablePadding: 10.0.w,
                      drawableStart: ImageMultiType(
                        url: Assets.iconsComment,
                        color: e.isMyComment
                            ? AppColorManager.mainColor
                            : Colors.black,
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
