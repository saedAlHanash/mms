import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_text_form_widget.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/poll/data/response/poll_response.dart';
import 'package:mms/features/vote/bloc/create_vote_cubit/create_vote_cubit.dart';
import 'package:mms/features/vote/data/request/create_vote_request.dart';
import 'package:mms/generated/l10n.dart';

BoxDecoration _cardDecoration() => BoxDecoration(
      color: AppColorManager.neutral0,
      border: Border.all(color: AppColorManager.neutral100),
      borderRadius: BorderRadius.circular(12.0.r),
    );

/// "Voters: n" with a people icon.
Widget _votersLine(BuildContext context, int count) {
  return Row(
    mainAxisSize: .min,
    children: [
      ImageMultiType(
        url: Icons.people_outline_rounded,
        width: 16.0.r,
        height: 16.0.r,
        color: AppColorManager.neutral500,
      ),
      6.0.horizontalSpace,
      DrawableText(text: '${S.of(context).voters}: ', size: 14.0.sp, color: AppColorManager.neutral700),
      DrawableText(text: '$count', size: 14.0.sp, fontWeight: .w700, color: AppColorManager.neutral900),
    ],
  );
}

/// Poll card: options as radio rows, no counts/percentages per option.
class PollWidget extends StatefulWidget {
  const PollWidget({super.key, required this.poll});

  final Poll poll;

  @override
  State<PollWidget> createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  var request = CreateVoteRequest();
  var enable = true;

  @override
  void initState() {
    request.pollId = widget.poll.id;
    enable = widget.poll.status == PollStatus.open;
    super.initState();
  }

  /// A new choice to object or abstain (the recorded vote isn't edited here).
  bool _showReason(String? selectedId) {
    final option = widget.poll.options.firstWhereOrNull((e) => e.id == selectedId);
    if (option == null || !option.kind.asksReason) return false;
    return request.pollOptionId != null && request.pollOptionId != widget.poll.meOptionVote?.id;
  }

  /// Safe count (no `reduce` on an empty list).
  int get _votersCount => widget.poll.options.fold(0, (sum, e) => sum + e.voters.length);

  @override
  Widget build(BuildContext context) {
    final poll = widget.poll;
    final myOption = poll.meOptionVote;
    final selectedId = request.pollOptionId ?? myOption?.id;

    return Container(
      padding: EdgeInsets.all(16.0.r),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: DrawableText(
                  text: poll.topic,
                  size: 16.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                ),
              ),
              8.0.horizontalSpace,
              StatusChip.poll(poll.status),
            ],
          ),
          12.0.verticalSpace,
          for (var i = 0; i < poll.options.length; i++) ...[
            if (i > 0) 8.0.verticalSpace,
            _OptionRow(
              option: poll.options[i],
              selected: poll.options[i].id == selectedId,
              isMyVote: poll.options[i].id == myOption?.id,
              enabled: enable,
              onTap: () => setState(() {
                request.pollOptionId = poll.options[i].id;
                if (!poll.options[i].kind.asksReason) request.reason = null;
              }),
            ),
          ],
          // Objecting or abstaining: the server may require a reason (Rules:VoteReasons).
          if (enable && _showReason(selectedId)) ...[
            12.0.verticalSpace,
            MyTextFormOutLineWidget(
              key: ValueKey('reason-$selectedId'),
              label: S.of(context).voteReason,
              hint: S.of(context).voteReasonHint,
              maxLines: 3,
              maxLength: 500,
              initialValue: request.reason,
              onChanged: (value) => request.reason = value,
            ),
          ],
          12.0.verticalSpace,
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 44.0.h),
            child: Row(
              children: [
                Expanded(child: _votersLine(context, _votersCount)),
                _footerAction(context, myOption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerAction(BuildContext context, Option? myOption) {
    if (!enable) {
      return DrawableText(
        text: S.of(context).votingEnded,
        size: 13.0.sp,
        color: AppColorManager.neutral500,
      );
    }

    final hasVoted = myOption != null;
    final choseOther = request.pollOptionId != null && request.pollOptionId != myOption?.id;

    if (hasVoted && !choseOther) {
      return DrawableText(
        text: S.of(context).voteRecorded,
        size: 13.0.sp,
        fontWeight: .w600,
        color: AppColorManager.successText,
        drawablePadding: 6.0.w,
        drawableStart: ImageMultiType(
          url: Icons.check_rounded,
          width: 15.0.r,
          height: 15.0.r,
          color: AppColorManager.successText,
        ),
      );
    }

    return BlocBuilder<CreateVoteCubit, CreateVoteInitial>(
      buildWhen: (p, c) => c.mRequest.pollId == widget.poll.id,
      builder: (context, state) {
        return MyButton(
          width: 140.0.w,
          size: .medium,
          enable: request.pollOptionId != null,
          loading: state.statuses.loading && state.mRequest.pollId == widget.poll.id,
          text: hasVoted ? S.of(context).editVote : S.of(context).vote,
          onTap: () {
            if (myOption != null) {
              request.id = myOption.voteId;
            }
            context.read<CreateVoteCubit>().createVote(request: request);
          },
        );
      },
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.option,
    required this.selected,
    required this.isMyVote,
    required this.enabled,
    required this.onTap,
  });

  final Option option;
  final bool selected;
  final bool isMyVote;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final Color borderColor;
    final double borderWidth;
    final Color radioColor;

    if (!enabled) {
      background = AppColorManager.neutral25;
      borderColor = AppColorManager.neutral100;
      borderWidth = 1;
      radioColor = selected ? AppColorManager.neutral500 : AppColorManager.neutral300;
    } else if (selected) {
      background = AppColorManager.primary50;
      borderColor = AppColorManager.primary500;
      borderWidth = 2;
      radioColor = AppColorManager.primary500;
    } else {
      background = AppColorManager.neutral0;
      borderColor = AppColorManager.neutral200;
      borderWidth = 1;
      radioColor = AppColorManager.neutral500;
    }

    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0.r),
          side: BorderSide(color: borderColor, width: borderWidth),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0.r),
          onTap: enabled ? onTap : null,
          child: Container(
            constraints: BoxConstraints(minHeight: 48.0.h),
            padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 8.0.h),
            child: Row(
              children: [
                Container(
                  width: 20.0.r,
                  height: 20.0.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColorManager.neutral0,
                    border: Border.all(color: radioColor, width: selected ? 6.0.r : 2.0.r),
                  ),
                ),
                10.0.horizontalSpace,
                Expanded(
                  child: DrawableText(
                    text: option.option,
                    size: 15.0.sp,
                    fontWeight: .w600,
                    color: enabled ? AppColorManager.neutral900 : AppColorManager.neutral700,
                  ),
                ),
                if (isMyVote)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    decoration: BoxDecoration(
                      color: enabled ? AppColorManager.primary100 : PollStatus.closed.colors.bg,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: DrawableText(
                      text: S.of(context).yourVote,
                      size: 12.0.sp,
                      fontWeight: .w700,
                      color: enabled ? AppColorManager.primary700 : AppColorManager.neutral700,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Published result: donut + legend (count · percentage).
class PollResultWidget extends StatelessWidget {
  const PollResultWidget({super.key, required this.pollResult});

  final PollResult pollResult;

  @override
  Widget build(BuildContext context) {
    final results = pollResult.voteResults;
    final total = results.fold<int>(0, (sum, e) => sum + e.voteCount);
    final hasVotes = total > 0;

    int percent(int count) => hasVotes ? (count * 100 / total).round() : 0;

    final sections = hasVotes
        ? results
            .mapIndexed(
              (i, e) => PieChartSectionData(
                color: AppColorManager.getPollColorSpread(i, results.length),
                value: e.voteCount.toDouble(),
                title: '',
                radius: 18.0.r,
              ),
            )
            .toList()
        : [
            PieChartSectionData(
              color: AppColorManager.neutral100,
              value: 1,
              title: '',
              radius: 18.0.r,
            ),
          ];

    return Container(
      padding: EdgeInsets.all(16.0.r),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: DrawableText(
                  text: pollResult.topic,
                  size: 16.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.neutral900,
                ),
              ),
              if (pollResult.outcome?.outcome case final outcome?) ...[
                8.0.horizontalSpace,
                StatusChip(
                  colors: outcome.colors,
                  label: pollResult.outcome!.decidedByChair
                      ? '${outcome.label} · ${S.of(context).decidedByChair}'
                      : outcome.label,
                ),
              ],
            ],
          ),
          12.0.verticalSpace,
          Row(
            children: [
              SizedBox(
                width: 132.0.r,
                height: 132.0.r,
                child: Stack(
                  alignment: .center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 48.0.r,
                        sections: sections,
                      ),
                    ),
                    Column(
                      mainAxisSize: .min,
                      children: [
                        DrawableText(
                          text: '$total',
                          size: 26.0.sp,
                          fontWeight: .w700,
                          color: AppColorManager.neutral900,
                        ),
                        DrawableText(
                          text: S.of(context).voteUnit,
                          size: 12.0.sp,
                          color: AppColorManager.neutral500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              16.0.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    for (var i = 0; i < results.length; i++) ...[
                      if (i > 0) 8.0.verticalSpace,
                      Row(
                        children: [
                          Container(
                            width: 12.0.r,
                            height: 12.0.r,
                            decoration: BoxDecoration(
                              color: AppColorManager.getPollColorSpread(i, results.length),
                              borderRadius: BorderRadius.circular(4.0.r),
                            ),
                          ),
                          8.0.horizontalSpace,
                          Expanded(
                            child: DrawableText(
                              text: results[i].option,
                              size: 14.0.sp,
                              fontWeight: .w600,
                              color: AppColorManager.neutral900,
                            ),
                          ),
                          Directionality(
                            textDirection: .ltr,
                            child: DrawableText(
                              text: '${results[i].voteCount} · ${percent(results[i].voteCount)}%',
                              size: 14.0.sp,
                              fontWeight: .w700,
                              color: AppColorManager.neutral900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
