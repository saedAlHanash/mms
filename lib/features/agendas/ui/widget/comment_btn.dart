import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/features/agendas/data/response/agendas_response.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../generated/assets.dart';
import '../../bloc/add_comment_cubit/add_comment_cubit.dart';

class CommentBtn extends StatefulWidget {
  const CommentBtn({super.key, required this.agenda, this.deep = 0});

  final Agenda agenda;
  final int deep;

  @override
  State<CommentBtn> createState() => _CommentBtnState();
}

class _CommentBtnState extends State<CommentBtn> {
  var addComment = false;

  AddCommentCubit get cubit => context.read<AddCommentCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCommentCubit, AddCommentInitial>(
      listenWhen: (p, c) =>
          c.statuses.done && c.request.agendaItemId == widget.agenda.id,
      listener: (context, state) {
        setState(() {
          widget.agenda.comments.add(state.getAddedComment);
          addComment = false;
          context.read<MeetingCubit>().addComment(
                comment: state.getAddedComment,
                agendaId: widget.agenda.id,
              );
        });
      },
      child: (!widget.agenda.haveMyComment && !addComment)
          ? BlocBuilder<AddCommentCubit, AddCommentInitial>(
              buildWhen: (p, c) => c.request.agendaItemId == widget.agenda.id,
              builder: (context, state) {
                if (state.statuses.loading) {
                  return SizedBox(
                    height: 24.0.r,
                    width: 24.0.r,
                    child: MyStyle.loadingWidget(),
                  );
                }
                return InkWell(
                  onTap: () {
                    cubit.setAgendaId = widget.agenda.id;
                    NoteMessage.showBlurDialog(
                      context,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const DrawableText(
                                text: 'Add Comment to this agenda'),
                            10.0.verticalSpace,
                            MyTextFormOutLineWidget(
                              label: 'add Comment',
                              onChanged: (p0) {
                                cubit.setText = p0;
                              },
                            ),
                            MyButton(
                              onTap: () {
                                cubit.addComment();
                                Navigator.pop(context);
                              },
                              width: 0.3.sw,
                              text: 'Add',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 40.0.r,
                    width: 40.0.r,
                    padding: const EdgeInsets.all(10.0).r,
                    decoration: BoxDecoration(
                      color: AppColorManager.mainColor,
                      borderRadius: BorderRadius.circular(12.0.r),
                    ),
                    child: const ImageMultiType(
                      url: Assets.iconsComment,
                    ),
                  ),
                );
              },
            )
          : 0.0.verticalSpace,
    );
  }
}
