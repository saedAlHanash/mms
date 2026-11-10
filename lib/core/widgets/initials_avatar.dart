import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/generated/assets.dart';

/// Circle with the first letter of [name]: `primary100` / `primary700`.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({super.key, required this.name, this.size = 40});

  final String name;
  final double size;

  String get _initial {
    final trimmed = name.trim();
    return trimmed.isEmpty ? '' : trimmed.characters.first.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.r,
      height: size.r,
      alignment: .center,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColorManager.primary100),
      child: DrawableText(
        text: _initial,
        size: (size * 0.4).sp,
        fontWeight: .w700,
        color: AppColorManager.primary700,
      ),
    );
  }
}

/// [CircleImageWidget] that falls back to [InitialsAvatar] when there is no
/// real photo (empty url or the default `avatar.png`).
class AppAvatar extends StatelessWidget {
  const AppAvatar({super.key, required this.url, required this.name, this.size = 40});

  final String url;
  final String name;
  final double size;

  bool get _hasPhoto => url.trim().isNotEmpty && url != Assets.imagesAvatar;

  @override
  Widget build(BuildContext context) {
    if (!_hasPhoto) return InitialsAvatar(name: name, size: size);
    return CircleImageWidget(url: url, size: size.r);
  }
}
