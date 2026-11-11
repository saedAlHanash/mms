import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';

/// Shown when no participant is selected: 72 circle (`primary800`) with the
/// existing "video off" icon. Scales down in small boxes.
class NoVideoWidget extends StatelessWidget {
  const NoVideoWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            final size = math.min(72.0.r, math.min(constraints.maxHeight, constraints.maxWidth) * 0.8);
            return Container(
              width: size,
              height: size,
              alignment: .center,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.primary800),
              child: ImageMultiType(
                url: Icons.videocam_off_outlined,
                width: size * 0.42,
                height: size * 0.42,
                color: AppColorManager.neutral0,
              ),
            );
          },
        ),
      );
}
