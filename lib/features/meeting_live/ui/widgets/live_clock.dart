import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';

/// A clock that ticks locally between live-state refreshes.
///
/// [seconds] is the server value at [since] (the time the state arrived).
/// While [running], it moves by one per second: down by default, or up when
/// [countUp]. Below zero it turns red and shows a minus sign (over time).
class LiveClock extends StatefulWidget {
  const LiveClock({
    super.key,
    required this.seconds,
    required this.since,
    required this.running,
    this.countUp = false,
    this.size = 28,
    this.color = AppColorManager.neutral900,
  });

  final int seconds;
  final DateTime since;
  final bool running;
  final bool countUp;
  final double size;
  final Color color;

  @override
  State<LiveClock> createState() => _LiveClockState();
}

class _LiveClockState extends State<LiveClock> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(covariant LiveClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.running != widget.running) _sync();
  }

  /// Ticks only while the timer runs.
  void _sync() {
    _timer?.cancel();
    _timer = widget.running ? Timer.periodic(const Duration(seconds: 1), (_) => setState(() {})) : null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int get _value {
    if (!widget.running) return widget.seconds;
    final passed = DateTime.now().difference(widget.since).inSeconds;
    return widget.countUp ? widget.seconds + passed : widget.seconds - passed;
  }

  static String format(int seconds) => LiveClockFormat.format(seconds);

  @override
  Widget build(BuildContext context) {
    final value = _value;
    return Directionality(
      textDirection: .ltr,
      child: DrawableText(
        text: format(value),
        size: widget.size.sp,
        fontWeight: .w700,
        color: value < 0 ? AppColorManager.danger : widget.color,
      ),
    );
  }
}

/// `mm:ss` (or `h:mm:ss`), with a minus sign when over time.
abstract final class LiveClockFormat {
  static String format(int seconds) {
    final value = seconds.abs();
    final h = value ~/ 3600;
    final m = (value % 3600) ~/ 60;
    final s = value % 60;
    String two(int n) => n.toString().padLeft(2, '0');
    final text = h > 0 ? '$h:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
    return seconds < 0 ? '-$text' : text;
  }
}
