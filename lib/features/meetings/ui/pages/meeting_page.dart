import 'package:go_router/go_router.dart';
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
import 'package:mms/features/agendas/ui/widgets/agenda_tree_widget.dart';
import 'package:mms/features/attendees/ui/widgets/attendees_list_widget.dart';
import 'package:mms/features/committees/ui/widgets/drawer_btn_widget.dart';
import 'package:mms/features/meetings/ui/widgets/discussions_tree.dart';
import 'package:mms/core/widgets/in_app_notification.dart';
import 'package:mms/features/meeting_hub/bloc/meeting_hub_cubit/meeting_hub_cubit.dart';
import 'package:mms/features/meeting_hub/ui/widgets/hub_widgets.dart';
import 'package:mms/features/agenda_request/bloc/my_agenda_requests_cubit/my_agenda_requests_cubit.dart';
import 'package:mms/features/agenda_request/ui/widgets/agenda_requests_section.dart';
import 'package:mms/features/interest/bloc/meeting_interests_cubit/meeting_interests_cubit.dart';
import 'package:mms/features/meeting_live/bloc/meeting_live_cubit/meeting_live_cubit.dart';
import 'package:mms/features/meeting_live/ui/widgets/meeting_live_panel.dart';
import 'package:mms/features/check_in/ui/widgets/check_in_card.dart';
import 'package:mms/features/check_in/ui/widgets/check_in_code_entry.dart';
import 'package:mms/features/quorum/bloc/quorum_cubit/quorum_cubit.dart';
import 'package:mms/features/quorum/ui/widgets/quorum_card.dart';
import 'package:mms/features/agenda_request/bloc/review_agenda_requests_cubit/review_agenda_requests_cubit.dart';
import 'package:mms/features/agenda_request/ui/widgets/review_requests_section.dart';
import 'package:mms/features/hall_service/bloc/hall_services_cubit/hall_services_cubit.dart';
import 'package:mms/features/hall_service/ui/widgets/hall_services_section.dart';
import 'package:mms/features/absence/ui/widgets/absence_requests_section.dart';
import 'package:mms/services/pip.dart';

import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';
import 'package:mms/features/room/bloc/room_cubit/room_cubit.dart';
import 'package:mms/features/room/ui/pages/live_kit_page.dart';
import 'package:mms/features/meetings/bloc/add_absence_cubit/add_absence_cubit.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> with WidgetsBindingObserver {
  MeetingCubit get _meetingCubit => context.read<MeetingCubit>();

  MeetingHubCubit get _hubCubit => context.read<MeetingHubCubit>();

  MeetingLiveCubit get _liveCubit => context.read<MeetingLiveCubit>();

  /// The live state is followed only while the meeting is running.
  void _syncLive(Meeting meeting) {
    meeting.status == MeetingStatus.running ? _liveCubit.start(meeting.id) : _liveCubit.stop();
    // Outside the live panel, refresh the quorum with every reload (attendance may have changed).
    if (QuorumCard.showsFor(meeting)) context.read<QuorumCubit>().getData(meetingId: meeting.id);
    // Secretary tools.
    if (ReviewRequestsSection.showsFor(meeting)) {
      context.read<ReviewAgendaRequestsCubit>().getData(meetingId: meeting.id);
    }
    if (HallServicesSection.showsFor(meeting)) context.read<HallServicesCubit>().getData(meetingId: meeting.id);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    PipService.init();
    // The call may already be connected when the page opens (the room is app-wide).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _syncPip(context.read<RoomCubit>().state);
    });
  }

  /// PiP is armed only while this page is open and the online call is connected.
  Future<void> _syncPip(RoomInitial room) async {
    final shouldArm = room.result.connectionState.isConnected;
    if (shouldArm == PipService.isArmed) return;
    shouldArm ? await PipService.arm() : await PipService.disarm();
    if (mounted) setState(() {}); // back-button behaviour depends on it
  }

  @override
  void dispose() {
    InAppNotification.hide();
    PipService.disarm();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case .paused:
        // Keep live updates while the call can run in PiP; otherwise the OS
        // would drop the socket anyway, so close it and resync on resume.
        if (!PipService.isArmed) await _hubCubit.pause();
      case .resumed:
        await _hubCubit.resume();
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MeetingCubit, MeetingInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            AppProvider.setMeeting = state.result;
            _syncLive(state.result);
          },
        ),
        BlocListener<AddAbsenceCubit, AddAbsenceInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            context.read<MeetingCubit>().getData(newData: true);
          },
        ),
        // Arm / disarm PiP with the online call.
        BlocListener<RoomCubit, RoomInitial>(listener: (context, state) => _syncPip(state)),
        // Live update received: apply it and show an in-app banner.
        BlocListener<MeetingHubCubit, MeetingHubInitial>(
          listenWhen: (p, c) => p.messageId != c.messageId && c.lastMessage != null,
          listener: (context, state) {
            final message = state.lastMessage!;
            if (message.event == SocketEvents.liveStateUpdated) {
              _liveCubit.onLiveUpdated();
              return;
            }
            _meetingCubit.applyHubMessage(message);
            showHubNotification(context, message);
          },
        ),
        // Reconnected / resumed: refetch what was missed.
        BlocListener<MeetingHubCubit, MeetingHubInitial>(
          listenWhen: (p, c) => p.resyncId != c.resyncId,
          listener: (context, state) {
            _meetingCubit.getData(newData: true);
            _liveCubit.getData();
            context.read<MeetingInterestsCubit>().getData();
            context.read<MyAgendaRequestsCubit>().getData();
          },
        ),
      ],
      child: BlocBuilder<RoomCubit, RoomInitial>(
        builder: (context, state) {
          return PopScope(
            // During a call, back minimises the meeting into PiP instead of leaving it.
            canPop: !PipService.canEnter,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              final entered = await PipService.enter();
              if (!entered && context.mounted) Navigator.of(context).pop(result);
            },
            child: Scaffold(
                    appBar: AppBarWidget(
                      titleText: S.of(context).meeting,
                      actions: const [ ActionBarMemberWidget()],
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
                                        if (CheckInCard.showsFor(item)) ...[
                                          16.0.verticalSpace,
                                          CheckInCard(meeting: item),
                                        ],
                                        if (CheckInCodeEntry.showsFor(item)) ...[
                                          16.0.verticalSpace,
                                          CheckInCodeEntry(meeting: item),
                                        ],
                                        if (QuorumCard.showsFor(item)) QuorumCard(meeting: item),
                                        if (isRunning) ...[
                                          16.0.verticalSpace,
                                          const MeetingLivePanel(),
                                        ],
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
                                        AgendaTreeWidget(
                                          agendas: item.agendaItems,
                                          canDeclareInterest: item.status != MeetingStatus.archived &&
                                              item.status != MeetingStatus.canceled,
                                        ),
                                        AgendaRequestsSection(meeting: item),
                                        if (AbsenceRequestsSection.showsFor(item)) AbsenceRequestsSection(meeting: item),
                                        if (ReviewRequestsSection.showsFor(item)) ReviewRequestsSection(meeting: item),
                                        if (HallServicesSection.showsFor(item)) HallServicesSection(meeting: item),
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

  /// Status pill of the online panel, derived from the room state only.
  (String, Color, Color) _status(BuildContext context, RoomInitial room) {
    final local = room.result.localParticipant;
    if (!room.result.connectionState.isConnected || local == null) {
      return (S.of(context).notConnected, PollStatus.closed.colors.bg, AppColorManager.neutral700);
    }
    if (local.permissions.isSuspend) {
      return (S.of(context).suspended, AppColorManager.warningSoft, AppColorManager.warningText);
    }
    if (!local.permissions.canPublish) {
      return (S.of(context).listenOnly, AppColorManager.warningSoft, AppColorManager.warningText);
    }
    return (S.of(context).connected, AppColorManager.successSoft, AppColorManager.successText);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingCubit, MeetingInitial>(
      builder: (context, state) {
        final from = state.result.fromDate;
        // The chair and the secretary get the host token (mute, remove, share).
        final isHost = state.result.callerMembershipType?.isLead ?? false;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isOpen)
              // Collapsed: dark "meeting is live" bar.
              Container(
                padding: EdgeInsets.fromLTRB(20.0.w, 14.0.h, 20.0.w, 20.0.h),
                decoration: BoxDecoration(
                  color: AppColorManager.primary900,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
                  boxShadow: MyStyle.elevationTop,
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    children: [
                      Container(
                        width: 44.0.r,
                        height: 44.0.r,
                        alignment: .center,
                        decoration: BoxDecoration(
                          color: AppColorManager.primary800,
                          borderRadius: BorderRadius.circular(12.0.r),
                        ),
                        child: Container(
                          width: 10.0.r,
                          height: 10.0.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MeetingStatus.running.colors.dot,
                            boxShadow: [
                              BoxShadow(
                                color: MeetingStatus.running.colors.dot.withValues(alpha: 0.3),
                                spreadRadius: 4.0.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                      12.0.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            DrawableText(
                              text: S.of(context).meetingRunningNow,
                              size: 15.0.sp,
                              fontWeight: .w700,
                              color: AppColorManager.neutral0,
                            ),
                            if (from != null)
                              Row(
                                children: [
                                  DrawableText(
                                    text: S.of(context).startedAt,
                                    size: 12.0.sp,
                                    color: AppColorManager.primary200,
                                  ),
                                  4.0.horizontalSpace,
                                  Directionality(
                                    textDirection: .ltr,
                                    child: DrawableText(
                                      text: from.formatTime,
                                      size: 12.0.sp,
                                      color: AppColorManager.primary200,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Material(
                        color: AppColorManager.neutral0,
                        borderRadius: BorderRadius.circular(8.0.r),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.0.r),
                          onTap: () => setState(() => isOpen = true),
                          child: Container(
                            height: 44.0.r,
                            padding: EdgeInsets.symmetric(horizontal: 18.0.w),
                            alignment: .center,
                            child: DrawableText(
                              text: isHost ? S.of(context).joinAsHost : S.of(context).join,
                              size: 15.0.sp,
                              fontWeight: .w700,
                              color: AppColorManager.primary700,
                              drawablePadding: 8.0.w,
                              drawableStart: ImageMultiType(
                                url: Icons.videocam_outlined,
                                width: 18.0.r,
                                height: 18.0.r,
                                color: AppColorManager.primary700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              // Open: header with status pill and collapse button.
              Container(
                padding: EdgeInsets.fromLTRB(20.0.w, 8.0.h, 20.0.w, 0),
                decoration: BoxDecoration(
                  color: AppColorManager.neutral0,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
                  boxShadow: MyStyle.elevationTop,
                ),
                child: BlocBuilder<RoomCubit, RoomInitial>(
                  builder: (context, room) {
                    final (label, bg, fg) = _status(context, room);
                    return Row(
                      children: [
                        Expanded(
                          child: DrawableText(
                            text: S.of(context).onlineMeeting,
                            size: 16.0.sp,
                            fontWeight: .w700,
                            color: AppColorManager.neutral900,
                          ),
                        ),
                        if (isHost) ...[
                          StatusChip(colors: MembershipType.chair.badge, label: S.of(context).host),
                          8.0.horizontalSpace,
                        ],
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
                          child: DrawableText(text: label, size: 12.0.sp, fontWeight: .w600, color: fg),
                        ),
                        IconButton(
                          tooltip: S.of(context).collapse,
                          constraints: BoxConstraints(minWidth: 44.0.r, minHeight: 44.0.r),
                          onPressed: () => setState(() => isOpen = false),
                          icon: ImageMultiType(
                            url: Icons.keyboard_arrow_down_rounded,
                            width: 24.0.r,
                            height: 24.0.r,
                            color: AppColorManager.neutral700,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            // The LiveKit panel stays mounted (same as before) and shows itself when open.
            Container(
              color: AppColorManager.neutral0,
              padding: isOpen ? EdgeInsets.fromLTRB(20.0.w, 4.0.h, 20.0.w, 20.0.h) : EdgeInsets.zero,
              child: LiveKitPage(
                isOpen: isOpen,
                link: state.result.onlineMeetingUrl,
                token: state.result.onlineMeetingToken,
              ),
            ),
          ],
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
          if (meeting.hijriDate.isNotEmpty) ...[
            6.0.verticalSpace,
            _row(Icons.event_note_outlined, _text('${S.of(context).hijriDate}: ${meeting.hijriDate}')),
          ],
          if (meeting.mode case final mode?) ...[
            6.0.verticalSpace,
            _row(mode.icon, _text(mode.label)),
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
        onTap: () => context.pushNamed(RouteName.votes, extra: context.read<MeetingCubit>()),
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
                      text: S.of(context).votesTitle,
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
