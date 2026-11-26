import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:mms/features/poll/ui/widgets/pool_widget.dart';

import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/vote/bloc/create_vote_cubit/create_vote_cubit.dart';

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
            // Drafts are for the chair and the secretary (marked in the card); a copy,
            // so the meeting's own list stays whole.
            final isLead = state.result.callerMembershipType?.isLead ?? false;
            final myPolls = state.result.polls.where((e) => isLead || e.status != PollStatus.pending).toList();
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
