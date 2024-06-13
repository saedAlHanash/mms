import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_expansion/item_expansion.dart';
import 'package:mms/core/widgets/my_expansion/my_expansion_widget.dart';
import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/agendas/ui/widget/comment_btn.dart';
import 'package:mms/features/agendas/ui/widget/comment_list.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key, required this.agenda});

  final Agenda agenda;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: agenda.title,
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 150.0).r,
        child: _Item(agenda: agenda, deep: 0),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.agenda, required this.deep});

  final Agenda agenda;
  final int deep;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (deep * 10).horizontalSpace,
        Expanded(
          child: MyExpansionWidget(
            margin: const EdgeInsets.symmetric(vertical: 8.0).h,
            decoration: BoxDecoration(
              color: AppColorManager.getColor(deep),
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            items: [
              ItemExpansion(
                isExpanded: deep == 0,
                header: ListTile(
                  contentPadding: EdgeInsetsDirectional.only(start: 20.0.w),
                  title: DrawableText(
                    text: agenda.title,
                    size: 18.0.sp,
                    fontFamily: FontManager.cairoBold.name,
                  ),
                  subtitle: DrawableText(
                    text: agenda.description,
                    color: Colors.grey,
                  ),
                  trailing: CommentBtn(agenda: agenda),
                ),
                body: BlocBuilder<AddCommentCubit, AddCommentInitial>(
                  buildWhen: (p, c) =>
                      c.statuses.done && c.request.agendaItemId == agenda.id,
                  builder: (context, state) {
                    return Column(
                      children: [
                        CommentList(comments: agenda.comments),
                        for (var e in agenda.childrenItems)
                          _Item(agenda: e, deep: deep + 1)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
