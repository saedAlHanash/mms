import 'package:drawable_text/drawable_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/agenda_request/bloc/my_agenda_requests_cubit/my_agenda_requests_cubit.dart';
import 'package:mms/features/agenda_request/data/request/create_agenda_request.dart';
import 'package:mms/generated/l10n.dart';

/// Bottom sheet to propose an agenda item: title, note, optional attachment.
class ProposeItemSheet extends StatefulWidget {
  const ProposeItemSheet({super.key, required this.meetingId});

  final String meetingId;

  static Future<void> show(
    BuildContext context, {
    required MyAgendaRequestsCubit cubit,
    required String meetingId,
  }) {
    return AppBottomSheet.show(
      context,
      child: BlocProvider.value(
        value: cubit,
        child: ProposeItemSheet(meetingId: meetingId),
      ),
    );
  }

  @override
  State<ProposeItemSheet> createState() => _ProposeItemSheetState();
}

class _ProposeItemSheetState extends State<ProposeItemSheet> {
  static const _maxBytes = 10 * 1024 * 1024;
  static const _extensions = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'jpg', 'jpeg', 'png'];

  final _title = TextEditingController();
  final _note = TextEditingController();
  PickedAttachment? _attachment;

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final files = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: _extensions);
    final file = files.firstOrNull;
    if (file == null || !mounted) return;

    // Check the size before loading the file into memory.
    if ((await file.length() ?? 0) > _maxBytes) {
      if (mounted) NoteMessage.showErrorSnackBar(message: S.of(context).attachmentTooLarge, context: context);
      return;
    }
    final bytes = await file.readAsBytes();
    if (!mounted) return;
    setState(() => _attachment = PickedAttachment(name: file.name, bytes: bytes));
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final ok = await context.read<MyAgendaRequestsCubit>().add(
      CreateAgendaRequest(
        meetingId: widget.meetingId,
        title: _title.text,
        note: _note.text,
        attachment: _attachment,
      ),
    );
    if (ok && mounted) {
      NoteMessage.showSuccessSnackBar(message: S.of(context).proposalSent, context: context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAgendaRequestsCubit, MyAgendaRequestsInitial>(
      buildWhen: (p, c) => p.sending != c.sending,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                Expanded(
                  child: DrawableText(
                    text: S.of(context).proposeItem,
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
            4.0.verticalSpace,
            DrawableText(
              text: S.of(context).proposeItemHint,
              size: 13.0.sp,
              color: AppColorManager.neutral500,
            ),
            16.0.verticalSpace,
            _Label(S.of(context).proposalTitle),
            6.0.verticalSpace,
            _Field(
              controller: _title,
              hint: S.of(context).proposalTitleHint,
              maxLength: 300,
              autofocus: true,
              onChanged: () => setState(() {}),
            ),
            14.0.verticalSpace,
            _Label(S.of(context).proposalNoteOptional),
            6.0.verticalSpace,
            _Field(
              controller: _note,
              hint: S.of(context).proposalNoteHint,
              maxLength: 1000,
              height: 96.0.h,
            ),
            14.0.verticalSpace,
            _AttachmentTile(
              attachment: _attachment,
              onPick: state.sending ? null : _pickFile,
              onRemove: state.sending ? null : () => setState(() => _attachment = null),
            ),
            20.0.verticalSpace,
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
                    text: S.of(context).sendProposal,
                    enable: _title.text.trim().isNotEmpty,
                    loading: state.sending,
                    onTap: _submit,
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

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return DrawableText(text: text, size: 14.0.sp, fontWeight: .w600, color: AppColorManager.neutral700);
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.hint,
    required this.maxLength,
    this.height,
    this.autofocus = false,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLength;

  /// Multi-line when set.
  final double? height;
  final bool autofocus;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0.r),
      borderSide: const BorderSide(color: AppColorManager.neutral200),
    );
    final multiLine = height != null;

    final field = TextField(
      controller: controller,
      autofocus: autofocus,
      expands: multiLine,
      maxLines: multiLine ? null : 1,
      maxLength: maxLength,
      buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
      textAlignVertical: TextAlignVertical.top,
      textInputAction: multiLine ? TextInputAction.newline : TextInputAction.next,
      onChanged: (_) => onChanged?.call(),
      style: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral900),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: const BorderSide(color: AppColorManager.primary500, width: 2)),
      ),
    );

    return multiLine ? SizedBox(height: height, child: field) : field;
  }
}

/// "Attach a file (optional)", or the chosen file with remove.
class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({required this.attachment, required this.onPick, required this.onRemove});

  final PickedAttachment? attachment;
  final VoidCallback? onPick;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final file = attachment;
    final radius = BorderRadius.circular(10.0.r);

    if (file == null) {
      return Material(
        color: AppColorManager.neutral25,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          onTap: onPick,
          child: Container(
            constraints: BoxConstraints(minHeight: 52.0.h),
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: AppColorManager.neutral200),
            ),
            child: Row(
              children: [
                ImageMultiType(
                  url: Icons.attach_file_rounded,
                  width: 20.0.r,
                  height: 20.0.r,
                  color: AppColorManager.primary500,
                ),
                10.0.horizontalSpace,
                Expanded(
                  child: DrawableText(
                    text: S.of(context).attachFileOptional,
                    size: 14.0.sp,
                    fontWeight: .w600,
                    color: AppColorManager.primary600,
                  ),
                ),
                DrawableText(
                  text: S.of(context).attachmentLimit,
                  size: 12.0.sp,
                  color: AppColorManager.neutral500,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsetsDirectional.only(start: 12.0.w, top: 4.0.h, bottom: 4.0.h),
      decoration: BoxDecoration(
        color: AppColorManager.primary50,
        borderRadius: radius,
      ),
      child: Row(
        children: [
          ImageMultiType(
            url: Icons.insert_drive_file_outlined,
            width: 20.0.r,
            height: 20.0.r,
            color: AppColorManager.primary600,
          ),
          10.0.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                DrawableText(
                  text: file.name,
                  size: 14.0.sp,
                  fontWeight: .w600,
                  color: AppColorManager.neutral900,
                  maxLines: 1,
                ),
                Directionality(
                  textDirection: .ltr,
                  child: DrawableText(text: file.sizeLabel, size: 12.0.sp, color: AppColorManager.neutral500),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: S.of(context).removeAttachment,
            constraints: BoxConstraints(minWidth: 44.0.r, minHeight: 44.0.r),
            onPressed: onRemove,
            icon: ImageMultiType(
              url: Icons.close_rounded,
              width: 20.0.r,
              height: 20.0.r,
              color: AppColorManager.neutral700,
            ),
          ),
        ],
      ),
    );
  }
}
