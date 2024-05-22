import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key, required this.agenda});

  final Agenda agenda;

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  var addComment = false;

  AddCommentCubit get cubit => context.read<AddCommentCubit>();

  @override
  void initState() {
    cubit.setLId = widget.agenda.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleText: widget.agenda.title,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
        child: Column(
          children: [
            MyCardWidget(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawableText(
                        text: widget.agenda.title,
                        size: 18.0.sp,
                        fontFamily: FontManager.cairoBold.name,
                      ),
                      10.0.verticalSpace,
                      DrawableText(
                        text: widget.agenda.description,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (!widget.agenda.haveMyComment && !addComment)
                    InkWell(
                      onTap: () => setState(() => addComment = true),
                      child: Container(
                        height: 50.0.r,
                        width: 50.0.r,
                        padding: const EdgeInsets.all(10.0).r,
                        decoration: BoxDecoration(
                          color: AppColorManager.mainColor,
                          borderRadius: BorderRadius.circular(12.0.r),
                        ),
                        child: const ImageMultiType(
                          url: Assets.iconsComment,
                        ),
                      ),
                    )
                ],
              ),
            ),
            if (addComment) 10.0.verticalSpace,
            if (addComment)
              MyTextFormOutLineWidget(
                label: 'add Comment',
                initialValue: cubit.state.request.text,
                onChanged: (p0) {
                  cubit.setText = p0;
                },
                iconWidgetLift: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<AddCommentCubit, AddCommentInitial>(
                      builder: (context, state) {
                        if (state.statuses.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return InkWell(
                          onTap: () => cubit.addComment(),
                          child: const ImageMultiType(
                            url: Icons.done,
                            color: AppColorManager.mainColor,
                          ),
                        );
                      },
                    ),
                    10.0.horizontalSpace,
                    InkWell(
                      onTap: () => setState(() => addComment = false),
                      child: const ImageMultiType(
                        url: Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.agenda.haveMyComment)
              MyCardWidget(
                margin: EdgeInsets.only(left: 40.0).w,
                child: DrawableText(
                  text: widget.agenda.myComment?.text ?? '',
                  color: Colors.black,
                  matchParent: true,
                  drawablePadding: 10.0.w,
                  drawableStart: const ImageMultiType(
                    url: Assets.iconsComment,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
