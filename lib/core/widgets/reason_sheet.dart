import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/generated/l10n.dart';

/// A bottom sheet asking for a reason or note; returns the text, or null when dismissed.
class ReasonSheet extends StatefulWidget {
  const ReasonSheet({
    super.key,
    required this.title,
    required this.hint,
    required this.confirmText,
    this.description,
    this.required = true,
    this.destructive = false,
    this.maxLength = 1000,
  });

  final String title;
  final String? description;
  final String hint;
  final String confirmText;

  /// The confirm button waits for some text.
  final bool required;
  final bool destructive;
  final int maxLength;

  static Future<String?> show(
    BuildContext context, {
    required String title,
    required String hint,
    required String confirmText,
    String? description,
    bool required = true,
    bool destructive = false,
    int maxLength = 1000,
  }) {
    return AppBottomSheet.show<String>(
      context,
      child: ReasonSheet(
        title: title,
        description: description,
        hint: hint,
        confirmText: confirmText,
        required: required,
        destructive: destructive,
        maxLength: maxLength,
      ),
    );
  }

  @override
  State<ReasonSheet> createState() => _ReasonSheetState();
}

class _ReasonSheetState extends State<ReasonSheet> {
  final _controller = TextEditingController();

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
    final hasText = _controller.text.trim().isNotEmpty;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: DrawableText(
                text: widget.title,
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
        if (widget.description case final description?) ...[
          4.0.verticalSpace,
          DrawableText(text: description, size: 13.0.sp, color: AppColorManager.neutral500),
        ],
        14.0.verticalSpace,
        SizedBox(
          height: 112.0.h,
          child: TextField(
            controller: _controller,
            autofocus: true,
            expands: true,
            maxLines: null,
            maxLength: widget.maxLength,
            buildCounter: (_, {required currentLength, required isFocused, required maxLength}) => null,
            textAlignVertical: TextAlignVertical.top,
            onChanged: (_) => setState(() {}),
            style: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral900),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: MyStyle.bodyLg.copyWith(color: AppColorManager.neutral500),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.0.h),
              border: border,
              enabledBorder: border,
              focusedBorder: border.copyWith(borderSide: const BorderSide(color: AppColorManager.primary500, width: 2)),
            ),
          ),
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
                variant: widget.destructive ? .danger : .primary,
                text: widget.confirmText,
                enable: !widget.required || hasText,
                onTap: () => Navigator.pop(context, _controller.text.trim()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
