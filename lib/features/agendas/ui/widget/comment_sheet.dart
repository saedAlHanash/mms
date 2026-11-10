import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/agendas/bloc/add_comment_cubit/add_comment_cubit.dart';
import 'package:mms/generated/l10n.dart';

/// Bottom sheet to add a comment on an agenda item or a discussion.
/// Uses the existing [AddCommentCubit]; closes itself when the comment is sent.
class CommentSheet extends StatefulWidget {
  const CommentSheet({
    super.key,
    required this.contextLabel,
    required this.title,
    this.number,
  });

  /// "Agenda item" / "Discussion".
  final String contextLabel;
  final String title;

  /// Agenda numbering shown in the context card (null for discussions).
  final String? number;

  static Future<void> show(
    BuildContext context, {
    required AddCommentCubit cubit,
    required String contextLabel,
    required String title,
    String? number,
  }) {
    return AppBottomSheet.show(
      context,
      child: BlocProvider.value(
        value: cubit,
        child: CommentSheet(contextLabel: contextLabel, title: title, number: number),
      ),
    );
  }

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final _controller = TextEditingController();

  AddCommentCubit get cubit => context.read<AddCommentCubit>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: const BorderSide(color: AppColorManager.neutral200),
    );

    return BlocConsumer<AddCommentCubit, AddCommentInitial>(
      listenWhen: (p, c) => !p.done && c.done,
      listener: (context, state) => Navigator.pop(context),
      builder: (context, state) {
        return Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                Expanded(
                  child: DrawableText(
                    text: S.of(context).addComment,
                    size: 18.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral900,
                  ),
                ),
                IconButton(
                  tooltip: S.of(context).close,
                  constraints: BoxConstraints(minWidth: 44.0.r, minHeight: 44.0.r),
                  onPressed: () => Navigator.pop(context),
                  icon: ImageMultiType(
                    url: Icons.close_rounded,
                    width: 22.0.r,
                    height: 22.0.r,
                    color: AppColorManager.neutral700,
                  ),
                ),
              ],
            ),
            8.0.verticalSpace,
            // Context card.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
              decoration: BoxDecoration(
                color: AppColorManager.neutral25,
                border: Border.all(color: AppColorManager.neutral50),
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: Row(
                children: [
                  if (widget.number != null) ...[
                    AgendaNumberBox(number: widget.number!),
                    10.0.horizontalSpace,
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        DrawableText(
                          text: widget.contextLabel,
                          size: 12.0.sp,
                          color: AppColorManager.neutral500,
                        ),
                        DrawableText(
                          text: widget.title,
                          size: 14.0.sp,
                          fontWeight: .w600,
                          color: AppColorManager.neutral900,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            16.0.verticalSpace,
            DrawableText(
              text: S.of(context).yourComment,
              size: 14.0.sp,
              fontWeight: .w600,
              color: AppColorManager.neutral700,
            ),
            6.0.verticalSpace,
            SizedBox(
              height: 112.0.h,
              child: TextField(
                controller: _controller,
                autofocus: true,
                expands: true,
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
                onChanged: (value) {
                  cubit.setText = value;
                  setState(() {});
                },
                style: TextStyle(fontSize: 16.0.sp, height: 26 / 16, color: AppColorManager.neutral900),
                decoration: InputDecoration(
                  hintText: S.of(context).writeYourComment,
                  hintStyle: TextStyle(fontSize: 16.0.sp, color: AppColorManager.neutral500),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border.copyWith(
                    borderSide: const BorderSide(color: AppColorManager.primary500, width: 2),
                  ),
                ),
              ),
            ),
            12.0.verticalSpace,
            DrawableText(
              text: S.of(context).commentHint,
              size: 13.0.sp,
              color: AppColorManager.neutral500,
            ),
            16.0.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    width: double.infinity,
                    variant: .outline,
                    text: S.of(context).cancel,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                8.0.horizontalSpace,
                Expanded(
                  flex: 2,
                  child: MyButton(
                    width: double.infinity,
                    text: S.of(context).addComment,
                    enable: _controller.text.trim().isNotEmpty,
                    loading: state.statuses.loading,
                    onTap: () => cubit.addComment(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// 28 square with the agenda number (`primary50` / `primary700`).
class AgendaNumberBox extends StatelessWidget {
  const AgendaNumberBox({super.key, required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.0.r,
      height: 28.0.r,
      alignment: .center,
      decoration: BoxDecoration(
        color: AppColorManager.primary50,
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: DrawableText(
        text: number,
        size: 14.0.sp,
        fontWeight: .w700,
        color: AppColorManager.primary700,
      ),
    );
  }
}

/// 44×44 "add comment" button (`primary50` / `primary600`).
class AddCommentButton extends StatelessWidget {
  const AddCommentButton({super.key, required this.onTap, this.loading = false});

  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox(
        width: 44.0.r,
        height: 44.0.r,
        child: Center(
          child: SizedBox(
            width: 24.0.r,
            height: 24.0.r,
            child: const CircularProgressIndicator(strokeWidth: 2, color: AppColorManager.primary500),
          ),
        ),
      );
    }

    return Tooltip(
      message: S.of(context).addComment,
      child: Material(
        color: AppColorManager.primary50,
        borderRadius: BorderRadius.circular(12.0.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0.r),
          onTap: onTap,
          child: SizedBox(
            width: 44.0.r,
            height: 44.0.r,
            child: Center(
              child: ImageMultiType(
                url: Icons.add_comment_outlined,
                width: 20.0.r,
                height: 20.0.r,
                color: AppColorManager.primary600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
