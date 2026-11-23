import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/circulation/data/response/circulation_response.dart';
import 'package:mms/generated/l10n.dart';

/// "Closes in 2d 5h" (ticks every 30s), "Deadline passed", or "No deadline".
class DeadlineCountdown extends StatefulWidget {
  const DeadlineCountdown({super.key, required this.deadline, required this.passed, this.size = 13});

  final DateTime? deadline;
  final bool passed;
  final double size;

  @override
  State<DeadlineCountdown> createState() => _DeadlineCountdownState();
}

class _DeadlineCountdownState extends State<DeadlineCountdown> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.deadline != null && !widget.passed) {
      _timer = Timer.periodic(const Duration(seconds: 30), (_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _left(BuildContext context, Duration d) {
    final s = S.of(context);
    if (d.inDays > 0) return s.closesInDaysHours(d.inDays, d.inHours % 24);
    if (d.inHours > 0) return s.closesInHoursMinutes(d.inHours, d.inMinutes % 60);
    return s.closesInMinutes(d.inMinutes < 1 ? 1 : d.inMinutes);
  }

  @override
  Widget build(BuildContext context) {
    final deadline = widget.deadline;
    final left = deadline?.difference(DateTime.now());
    final passed = widget.passed || (left != null && left.isNegative);
    // Under a day left: amber.
    final urgent = !passed && left != null && left.inHours < 24;

    final (text, color, icon) = deadline == null
        ? (S.of(context).noDeadline, AppColorManager.neutral500, Icons.all_inclusive_rounded)
        : passed
        ? (S.of(context).deadlinePassed, AppColorManager.dangerText, Icons.timer_off_outlined)
        : (
            _left(context, left!),
            urgent ? AppColorManager.warningText : AppColorManager.neutral700,
            Icons.timer_outlined,
          );

    return DrawableText(
      text: text,
      size: widget.size.sp,
      fontWeight: .w600,
      color: color,
      drawablePadding: 4.0.w,
      drawableStart: ImageMultiType(url: icon, width: (widget.size + 3).r, height: (widget.size + 3).r, color: color),
    );
  }
}

/// List item of a circulation.
class CirculationCard extends StatelessWidget {
  const CirculationCard({super.key, required this.item, required this.onTap});

  final Circulation item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final awaits = item.awaitsMyVote;
    final radius = BorderRadius.circular(14.0.r);

    return Material(
      color: AppColorManager.neutral0,
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.all(14.0.r),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: awaits ? AppColorManager.primary300 : AppColorManager.neutral100,
              width: awaits ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Row(
                children: [
                  StatusChip(colors: item.status.colors, label: item.status.label),
                  if (item.outcome case final outcome?) ...[
                    6.0.horizontalSpace,
                    StatusChip(colors: outcome.colors, label: outcome.label),
                  ],
                  const Spacer(),
                  if (item.numberLabel.isNotEmpty)
                    Directionality(
                      textDirection: .ltr,
                      child: DrawableText(
                        text: '#${item.numberLabel}',
                        size: 13.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.neutral500,
                      ),
                    ),
                ],
              ),
              10.0.verticalSpace,
              DrawableText(
                text: item.title,
                size: 15.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral900,
                maxLines: 2,
              ),
              if (item.statement.isNotEmpty) ...[
                4.0.verticalSpace,
                DrawableText(text: item.statement, size: 13.0.sp, color: AppColorManager.neutral500, maxLines: 2),
              ],
              12.0.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: item.status == CirculationStatus.open
                        ? DeadlineCountdown(deadline: item.deadline, passed: item.deadlinePassed)
                        : DrawableText(
                            text: S.of(context).votesCount(item.voters - item.pending, item.voters),
                            size: 13.0.sp,
                            color: AppColorManager.neutral500,
                          ),
                  ),
                  if (awaits)
                    StatusChip(
                      colors: const StatusColors(
                        dot: AppColorManager.primary500,
                        bg: AppColorManager.primary50,
                        fg: AppColorManager.primary700,
                      ),
                      label: S.of(context).awaitingYourVote,
                      glow: true,
                    )
                  else if (item.myChoice case final choice?)
                    StatusChip(colors: choice.colors, label: S.of(context).yourVoteIs(choice.label)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Approval weight against the half-of-all-weight line, and the counts.
class CirculationTally extends StatelessWidget {
  const CirculationTally({super.key, required this.item});

  final Circulation item;

  @override
  Widget build(BuildContext context) {
    final total = item.totalWeight <= 0 ? 1.0 : item.totalWeight;
    final ratio = (item.approveWeight / total).clamp(0.0, 1.0);
    final passing = item.approveWeight * 2 > item.totalWeight;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: DrawableText(
                text: S.of(context).approvalWeight,
                size: 13.0.sp,
                fontWeight: .w600,
                color: AppColorManager.neutral700,
              ),
            ),
            Directionality(
              textDirection: .ltr,
              child: DrawableText(
                text: '${(ratio * 100).round()}%',
                size: 14.0.sp,
                fontWeight: .w700,
                color: passing ? AppColorManager.successText : AppColorManager.neutral900,
              ),
            ),
          ],
        ),
        8.0.verticalSpace,
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return SizedBox(
              height: 14.0.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    top: 3.0.h,
                    bottom: 3.0.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: ratio,
                        backgroundColor: AppColorManager.neutral100,
                        color: passing ? AppColorManager.success : AppColorManager.primary500,
                      ),
                    ),
                  ),
                  // The 50% line it has to pass.
                  PositionedDirectional(
                    start: width / 2 - 1,
                    top: 0,
                    bottom: 0,
                    child: Container(width: 2, color: AppColorManager.neutral700),
                  ),
                ],
              ),
            );
          },
        ),
        4.0.verticalSpace,
        DrawableText(
          text: S.of(context).approvalNeedsHalf,
          size: 12.0.sp,
          color: AppColorManager.neutral500,
        ),
        14.0.verticalSpace,
        Row(
          children: [
            _Count(label: CirculationChoice.approve.label, value: item.approved, color: AppColorManager.successText),
            _Count(label: CirculationChoice.reject.label, value: item.rejected, color: AppColorManager.dangerText),
            _Count(label: CirculationChoice.abstain.label, value: item.abstained, color: AppColorManager.neutral700),
            _Count(label: S.of(context).notVotedYet, value: item.pending, color: AppColorManager.neutral500),
          ],
        ),
      ],
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.label, required this.value, required this.color});

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          DrawableText(text: '$value', size: 20.0.sp, fontWeight: .w700, color: color),
          DrawableText(text: label, size: 12.0.sp, color: AppColorManager.neutral500, textAlign: .center),
        ],
      ),
    );
  }
}
