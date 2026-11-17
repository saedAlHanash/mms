import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/icon_tile.dart';

/// In-app (not system) notification: a banner that slides in from the top,
/// stays for a few seconds and can be dismissed by tapping or swiping up.
/// A new banner replaces the one on screen.
class InAppNotification {
  InAppNotification._();

  static OverlayEntry? _current;

  static void show(
    BuildContext context, {
    required String title,
    String? body,
    IconData icon = Icons.notifications_active_outlined,
    IconTileTone tone = .primary,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
  }) {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    hide();
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _InAppBanner(
        title: title,
        body: body,
        icon: icon,
        tone: tone,
        duration: duration,
        onTap: onTap,
        onDismissed: () {
          if (_current == entry) _current = null;
          if (entry.mounted) entry.remove();
        },
      ),
    );
    _current = entry;
    overlay.insert(entry);
  }

  /// Removes the banner currently on screen, if any.
  static void hide() {
    final entry = _current;
    _current = null;
    if (entry != null && entry.mounted) entry.remove();
  }
}

class _InAppBanner extends StatefulWidget {
  const _InAppBanner({
    required this.title,
    required this.body,
    required this.icon,
    required this.tone,
    required this.duration,
    required this.onDismissed,
    this.onTap,
  });

  final String title;
  final String? body;
  final IconData icon;
  final IconTileTone tone;
  final Duration duration;
  final VoidCallback onDismissed;
  final VoidCallback? onTap;

  @override
  State<_InAppBanner> createState() => _InAppBannerState();
}

class _InAppBannerState extends State<_InAppBanner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
    reverseDuration: const Duration(milliseconds: 200),
  );
  late final Animation<Offset> _slide = Tween(begin: const Offset(0, -1.2), end: Offset.zero)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  Timer? _timer;
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(widget.duration, _close);
  }

  Future<void> _close() async {
    if (_closing || !mounted) return;
    _closing = true;
    _timer?.cancel();
    await _controller.reverse();
    widget.onDismissed();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = widget.body;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: SlideTransition(
          position: _slide,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.0.w, 8.0.h, 16.0.w, 0),
            child: GestureDetector(
              onTap: () {
                widget.onTap?.call();
                _close();
              },
              onVerticalDragEnd: (details) {
                if ((details.primaryVelocity ?? 0) < 0) _close();
              },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(12.0.r),
                  decoration: BoxDecoration(
                    color: AppColorManager.neutral0,
                    borderRadius: BorderRadius.circular(16.0.r),
                    border: Border.all(color: AppColorManager.neutral100),
                    boxShadow: MyStyle.elevation2,
                  ),
                  child: Row(
                    children: [
                      IconTile(icon: widget.icon, size: 40, iconSize: 20, tone: widget.tone),
                      12.0.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            DrawableText(
                              text: widget.title,
                              size: 15.0.sp,
                              fontWeight: .w700,
                              color: AppColorManager.neutral900,
                              maxLines: 1,
                            ),
                            if (body != null && body.isNotEmpty)
                              DrawableText(
                                text: body,
                                size: 13.0.sp,
                                color: AppColorManager.neutral700,
                                maxLines: 2,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
