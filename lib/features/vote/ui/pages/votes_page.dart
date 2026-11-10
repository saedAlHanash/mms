import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:mms/features/poll/ui/widget/pool_widget.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/l10n.dart';
import '../../../meetings/bloc/meeting_cubit/meeting_cubit.dart';
import '../../bloc/create_vote_cubit/create_vote_cubit.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PieChart(
          PieChartData(
            sectionsSpace: 2.0.r,
            centerSpaceRadius: 100.0.r,
            borderData: FlBorderData(
                border: Border.all(
              color: AppColorManager.red,
            )),
            sections: showingSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColorManager.mainColor,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blueGrey,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: AppColorManager.ampere,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });

  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
        ),
      ),
    );
  }
}

class VotesPage extends StatelessWidget {
  const VotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).votesTitle),
      body: BlocListener<CreateVoteCubit, CreateVoteInitial>(
        listenWhen: (p, c) => c.done,
        listener: (context, state) {
          context.read<MeetingCubit>().getData(newData: true);
        },
        child: BlocBuilder<MeetingCubit, MeetingInitial>(
          builder: (context, state) {
            final myPolls = state.result.polls..removeWhere((e) => e.status == PollStatus.pending);
            final results = state.result.pollResults;
            final isEmpty = myPolls.isEmpty && results.isEmpty;
            final showSkeleton = state.loading && state.result.id.isEmpty;

            final Widget body;
            if (showSkeleton) {
              body = ListView(
                padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 32.0.h),
                children: [
                  SkeletonBox(width: 96.0.w, height: 18, radius: 6),
                  16.0.verticalSpace,
                  const SkeletonBox(height: 260, radius: 12),
                  16.0.verticalSpace,
                  const SkeletonBox(height: 220, radius: 12),
                ],
              );
            } else if (isEmpty) {
              body = ListView(
                padding: EdgeInsets.only(top: 120.0.h),
                children: [
                  EmptyStateWidget.large(
                    icon: Icons.how_to_vote_outlined,
                    title: S.of(context).noVotesForMeeting,
                    description: S.of(context).noVotesForMeetingDescription,
                  ),
                ],
              );
            } else {
              body = ListView(
                padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 32.0.h),
                children: [
                  if (myPolls.isNotEmpty) ...[
                    _SectionLabel(text: S.of(context).polls),
                    for (final poll in myPolls) ...[
                      16.0.verticalSpace,
                      PollWidget(poll: poll),
                    ],
                  ],
                  if (results.isNotEmpty) ...[
                    if (myPolls.isNotEmpty) 24.0.verticalSpace,
                    _SectionLabel(text: S.of(context).publishedResults),
                    for (final result in results) ...[
                      16.0.verticalSpace,
                      PollResultWidget(pollResult: result),
                    ],
                  ],
                ],
              );
            }

            return RefreshWidget(
              onRefresh: () {
                context.read<MeetingCubit>().getData(newData: true);
              },
              isLoading: state.loading,
              child: body,
            );
          },
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: text,
      size: 13.0.sp,
      fontWeight: .w700,
      color: AppColorManager.neutral500,
    );
  }
}
