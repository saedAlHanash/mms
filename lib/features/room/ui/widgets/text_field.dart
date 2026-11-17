import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';

class LKTextField extends StatelessWidget {
  final String label;
  final TextEditingController? ctrl;
  const LKTextField({
    required this.label,
    this.ctrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DrawableText(
              text: label,
              size: 16.0.sp,
              fontWeight: .w700,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColorManager.neutral0.withValues(alpha: .3),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: ctrl,
              decoration: const InputDecoration.collapsed(
                hintText: '',
              ),
              keyboardType: TextInputType.url,
              autocorrect: false,
            ),
          ),
        ],
      );
}
