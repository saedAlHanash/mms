import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:intl/intl.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/features/agendas/ui/widget/agenda_tree_widget.dart';
import 'package:mms/features/attendees/ui/widget/attendees_list_widget.dart';
import 'package:mms/features/committees/ui/widget/drawer_btn_widget.dart';
import 'package:mms/features/meetings/ui/widget/discussions_tree.dart';
import 'package:mms/services/pip.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../../room/bloc/room_cubit/room_cubit.dart';
import '../../../room/ui/pages/live_kit_page.dart';
import '../../../room/ui/widget/video_widget.dart';
import '../../bloc/add_absence_cubit/add_absence_cubit.dart';
import '../../bloc/meeting_cubit/meeting_cubit.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    PipService.initial();
    super.initState();
  }

  @override
  void dispose() {
    PipService.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    PipService.didChangeAppLifecycleState(state).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MeetingCubit, MeetingInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            AppProvider.setMeeting = state.result;
          },
        ),
        BlocListener<AddAbsenceCubit, AddAbsenceInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            context.read<MeetingCubit>().getData(newData: true);
          },
        ),
        BlocListener<RoomCubit, RoomInitial>(listenWhen: (p, c) => c.done, listener: (context, state) {}),
      ],
      child: BlocBuilder<RoomCubit, RoomInitial>(
        builder: (context, state) {
          return PopScope(
            canPop: !PipService.isSetUp,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) PipService.start();
            },
            child: PipService.isPipActive
                ? Scaffold(body: const VideoRemoteWidget())
                : Scaffold(
                    appBar: AppBarWidget(
                      titleText: S.of(context).meeting,
                      backBtn: PipService.isSetUp ? 0.0.verticalSpace : const BackBtnWidget(),
                      actions: const [ActionBarMemberWidget()],
                    ),
                    endDrawer: Drawer(
                      width: 320.0.w,
                      backgroundColor: AppColorManager.neutral0,
                      surfaceTintColor: AppColorManager.neutral0,
                      shape: const RoundedRectangleBorder(),
                      child: BlocBuilder<MeetingCubit, MeetingInitial>(
                        builder: (context, state) {
                          return AttendeesListWidget(meeting: state.result);
                        },
                      ),
                    ),
                    body: BlocBuilder<MeetingCubit, MeetingInitial>(
                      builder: (context, state) {
                        final item = state.result;
                        final isRunning = item.status == MeetingStatus.running;
                        final showSkeleton = state.loading && item.id.isEmpty;

                        return Stack(
                          children: [
                            RefreshWidget(
                              onRefresh: () => context.read<MeetingCubit>().getData(newData: true),
                              isLoading: state.loading,
                              child: showSkeleton
                                  ? const _MeetingSkeleton()
                                  : ListView(
                                      padding: EdgeInsets.fromLTRB(
                                        20.0.w,
                                        16.0.h,
                                        20.0.w,
                                        isRunning ? 120.0.h : 32.0.h,
                                      ),
                                      children: [
                                        _MeetingInfoCard(meeting: item),
                                        // const AbsentWidget(),
                                        24.0.verticalSpace,
                                        _VotesCard(pending: item.countPollsNotVotes),
                                        24.0.verticalSpace,
                                        SectionHeader(
                                          title: S.of(context).agendas,
                                          trailing: item.agendaItems.isEmpty
                                              ? null
                                              : S.of(context).itemsCount(item.agendaItems.length),
                                        ),
                                        10.0.verticalSpace,
                                        AgendaTreeWidget(agendas: item.agendaItems),
                                        if (item.discussions.isNotEmpty) ...[
                                          24.0.verticalSpace,
                                          SectionHeader(
                                            title: S.of(context).discussions,
                                            trailing: S.of(context).discussionsCount(item.discussions.length),
                                          ),
                                          10.0.verticalSpace,
                                          DiscussionsTree(discussions: item.discussions),
                                        ],
                                        // GoalListWidget(goals: item.goals),
                                      ],
                                    ),
                            ),
                            if (isRunning)
                              Align(alignment: Alignment.bottomCenter, child: _VideoCall()),
                          ],
                        );
                      },
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class _VideoCall extends StatefulWidget {
  const _VideoCall();

  @override
  State<_VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<_VideoCall> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingCubit, MeetingInitial>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)).r,
                    color: AppColorManager.cardColor,
                  ),
                  child: DrawableText(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0).r,
                    text: 'Online Meeting',
                    matchParent: true,
                    drawableEnd: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(isOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
                    ),
                  ),
                ),
              ),
              LiveKitPage(isOpen: isOpen, link: state.result.onlineMeetingUrl, token: state.result.onlineMeetingToken),
            ],
          ),
        );
      },
    );
  }
}

/// Committee + status, title, date / time / place.
class _MeetingInfoCard extends StatelessWidget {
  const _MeetingInfoCard({required this.meeting});

  final Meeting meeting;

  Widget _row(IconData icon, Widget child) {
    return Row(
      children: [
        ImageMultiType(url: icon, width: 17.0.r, height: 17.0.r, color: AppColorManager.neutral500),
        8.0.horizontalSpace,
        Flexible(child: child),
      ],
    );
  }

  Widget _text(String text, {bool ltr = false}) {
    final widget = DrawableText(text: text, size: 14.0.sp, color: AppColorManager.neutral700);
    return ltr ? Directionality(textDirection: .ltr, child: widget) : widget;
  }

  /// "Monday 2026/11/09" (weekday localized, date in Latin digits).
  Widget _dayRow(BuildContext context, IconData icon, DateTime date, {String? prefix, bool withTime = false}) {
    final locale = Localizations.localeOf(context).languageCode;
    return _row(
      icon,
      Row(
        mainAxisSize: .min,
        children: [
          Flexible(child: _text('${prefix == null ? '' : '$prefix '}${DateFormat.EEEE(locale).format(date)}')),
          6.0.horizontalSpace,
          _text(withTime ? date.formatDateTime : date.formatDate, ltr: true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final from = meeting.fromDate;
    final to = meeting.toDate;
    final sameDay = from != null && to != null && from.year == to.year && from.month == to.month && from.day == to.day;

    return MyCardWidget(
      tone: .soft,
      padding: EdgeInsets.all(16.0.r),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Expanded(
                child: DrawableText(
                  text: meeting.committeeName,
                  size: 13.0.sp,
                  fontWeight: .w600,
                  color: AppColorManager.primary600,
                  maxLines: 1,
                ),
              ),
              8.0.horizontalSpace,
              StatusChip.meeting(meeting.status),
            ],
          ),
          8.0.verticalSpace,
          DrawableText(
            text: meeting.title,
            size: 20.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
            matchParent: true,
          ),
          8.0.verticalSpace,
          if (from != null && (to == null || sameDay)) ...[
            _dayRow(context, Icons.calendar_today_outlined, from),
            6.0.verticalSpace,
            _row(
              Icons.access_time_rounded,
              _text('${from.formatTime}${to == null ? '' : ' – ${to.formatTime}'}', ltr: true),
            ),
          ] else if (from != null && to != null) ...[
            _dayRow(context, Icons.not_started_outlined, from, prefix: S.of(context).fromLabel, withTime: true),
            6.0.verticalSpace,
            _dayRow(context, Icons.event_available_outlined, to, prefix: S.of(context).toLabel, withTime: true),
          ],
          if (meeting.meetingPlace.isNotEmpty) ...[
            6.0.verticalSpace,
            _row(Icons.place_outlined, _text(meeting.meetingPlace)),
          ],
        ],
      ),
    );
  }
}

/// Whole card opens the votes page.
class _VotesCard extends StatelessWidget {
  const _VotesCard({required this.pending});

  final int pending;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColorManager.primary50,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColorManager.primary100),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0.r),
        onTap: () => Navigator.pushNamed(context, RouteName.votes, arguments: context.read<MeetingCubit>()),
        child: Padding(
          padding: EdgeInsets.all(14.0.r),
          child: Row(
            children: [
              Container(
                width: 44.0.r,
                height: 44.0.r,
                alignment: .center,
                decoration: BoxDecoration(
                  color: AppColorManager.primary500,
                  borderRadius: BorderRadius.circular(12.0.r),
                ),
                child: ImageMultiType(
                  url: Icons.how_to_vote_outlined,
                  width: 22.0.r,
                  height: 22.0.r,
                  color: AppColorManager.neutral0,
                ),
              ),
              12.0.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: [
                    DrawableText(
                      text: S.of(context).votes,
                      size: 16.0.sp,
                      fontWeight: .w700,
                      color: AppColorManager.neutral900,
                    ),
                    DrawableText(
                      text: pending > 0 ? S.of(context).votesPending(pending) : S.of(context).noVotesPending,
                      size: 13.0.sp,
                      color: AppColorManager.primary700,
                    ),
                  ],
                ),
              ),
              if (pending > 0) ...[
                CountBadge(count: pending, size: 24),
                8.0.horizontalSpace,
              ],
              ImageMultiType(
                url: Icons.arrow_forward_ios_rounded,
                width: 18.0.r,
                height: 18.0.r,
                color: AppColorManager.neutral500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeetingSkeleton extends StatelessWidget {
  const _MeetingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 32.0.h),
      children: [
        const SkeletonBox(height: 182, radius: 16),
        24.0.verticalSpace,
        const SkeletonBox(height: 72, radius: 12),
        24.0.verticalSpace,
        SkeletonBox(width: 120.0.w, height: 20, radius: 6),
        10.0.verticalSpace,
        const SkeletonBox(height: 240, radius: 12),
      ],
    );
  }
}
