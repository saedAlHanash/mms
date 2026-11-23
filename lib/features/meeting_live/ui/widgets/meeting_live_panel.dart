import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/meeting_live/bloc/meeting_live_cubit/meeting_live_cubit.dart';
import 'package:mms/features/meeting_live/data/response/meeting_live_response.dart';
import 'package:mms/features/meeting_live/ui/widgets/live_clock.dart';
import 'package:mms/features/meeting_live/ui/widgets/live_controls.dart';
import 'package:mms/features/quorum/data/response/quorum_response.dart';
import 'package:mms/generated/l10n.dart';

/// "Live" card of a running meeting: the item on screen with its clock, who is
/// speaking, the queue, the quorum, and asking for / withdrawing the floor.
class MeetingLivePanel extends StatelessWidget {
  const MeetingLivePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingLiveCubit, MeetingLiveInitial>(
      builder: (context, state) {
        final live = state.result;

        if (live.isEmpty) {
          // First load only; an error before any state hides the card.
          if (state.statuses == CubitStatuses.error) return const SizedBox.shrink();
          return MyCardWidget(
            tone: .soft,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SkeletonBox(width: 120.0.w),
                12.0.verticalSpace,
                SkeletonBox(height: 28.0.h),
                12.0.verticalSpace,
                SkeletonBox(height: 44.0.h),
              ],
            ),
          );
        }

        return MyCardWidget(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              _Header(quorum: live.quorum, canControl: live.canControl),
              14.0.verticalSpace,
              _CurrentItem(item: live.currentItem, since: state.fetchedAt),
              if (live.canControl) LiveItemControls(live: live, sending: state.sending),
              const _Divider(),
              _Speaking(speaker: live.speaking, since: state.fetchedAt),
              if (live.waiting.isNotEmpty) ...[
                const _Divider(),
                _Queue(waiting: live.waiting, canControl: live.canControl, sending: state.sending),
              ],
              if (live.canControl) LiveSpeakerControls(live: live, sending: state.sending),
              16.0.verticalSpace,
              _FloorActions(live: live, sending: state.sending),
            ],
          ),
        );
      },
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: const Divider(height: 1, color: AppColorManager.neutral100),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return DrawableText(text: text, size: 12.0.sp, fontWeight: .w600, color: AppColorManager.neutral500);
  }
}

/// "Live now" + quorum chip.
class _Header extends StatelessWidget {
  const _Header({required this.quorum, required this.canControl});

  final MeetingQuorum? quorum;
  final bool canControl;

  @override
  Widget build(BuildContext context) {
    final q = quorum;
    return Row(
      children: [
        Expanded(
          child: StatusChip(
            colors: MeetingStatus.running.colors,
            label: S.of(context).liveNow,
            glow: true,
          ),
        ),
        if (canControl) ...[
          StatusChip(colors: MembershipType.chair.badge, label: S.of(context).liveControls),
          6.0.horizontalSpace,
        ],
        if (q != null && q.hasRule)
          StatusChip(
            colors: q.met ? PollOutcome.passed.colors : PollOutcome.tied.colors,
            label: q.met
                ? S.of(context).quorumMet(q.present, q.required)
                : S.of(context).quorumNotMet(q.present, q.required),
          ),
      ],
    );
  }
}

/// The agenda item on screen and its timer.
class _CurrentItem extends StatelessWidget {
  const _CurrentItem({required this.item, required this.since});

  final LiveItem? item;
  final DateTime since;

  @override
  Widget build(BuildContext context) {
    final current = item;
    if (current == null) {
      return DrawableText(
        text: S.of(context).liveNoItem,
        size: 14.0.sp,
        color: AppColorManager.neutral500,
      );
    }

    final timer = current.timer;
    return Row(
      crossAxisAlignment: .center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              _Label(S.of(context).liveCurrentItem),
              4.0.verticalSpace,
              DrawableText(
                text: current.title,
                size: 16.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral900,
                maxLines: 3,
              ),
            ],
          ),
        ),
        12.0.horizontalSpace,
        Column(
          crossAxisAlignment: .end,
          children: [
            LiveClock(
              seconds: timer.countsUp ? timer.elapsedSeconds : timer.remainingSeconds,
              since: since,
              running: timer.running,
              countUp: timer.countsUp,
            ),
            if (!timer.running)
              DrawableText(text: S.of(context).livePaused, size: 12.0.sp, color: AppColorManager.neutral500),
          ],
        ),
      ],
    );
  }
}

/// Who has the floor, with their remaining time.
class _Speaking extends StatelessWidget {
  const _Speaking({required this.speaker, required this.since});

  final LiveSpeaker? speaker;
  final DateTime since;

  @override
  Widget build(BuildContext context) {
    final current = speaker;
    if (current == null) {
      return DrawableText(
        text: S.of(context).liveNobodySpeaking,
        size: 14.0.sp,
        color: AppColorManager.neutral500,
      );
    }

    final isMe = current.partyId == AppProvider.getParty.id;
    return Row(
      children: [
        InitialsAvatar(name: current.name, size: 40),
        12.0.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              _Label(S.of(context).liveSpeaking),
              DrawableText(
                text: isMe ? '${current.name} (${S.of(context).you})' : current.name,
                size: 15.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral900,
                maxLines: 1,
              ),
            ],
          ),
        ),
        if (current.remainingSeconds case final remaining?)
          LiveClock(seconds: remaining, since: since, running: true, size: 20),
      ],
    );
  }
}

/// Waiting requests: points of order first (the server orders them).
class _Queue extends StatelessWidget {
  const _Queue({required this.waiting, required this.canControl, required this.sending});

  final List<LiveSpeaker> waiting;
  final bool canControl;
  final bool sending;

  @override
  Widget build(BuildContext context) {
    final myId = AppProvider.getParty.id;
    return Column(
      crossAxisAlignment: .start,
      children: [
        _Label(S.of(context).liveQueue(waiting.length)),
        8.0.verticalSpace,
        for (var i = 0; i < waiting.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: 6.0.h),
            child: Row(
              children: [
                SizedBox(
                  width: 24.0.w,
                  child: DrawableText(
                    text: '${i + 1}',
                    size: 13.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral500,
                  ),
                ),
                Expanded(
                  child: DrawableText(
                    text: waiting[i].partyId == myId
                        ? '${waiting[i].name} (${S.of(context).you})'
                        : waiting[i].name,
                    size: 14.0.sp,
                    fontWeight: waiting[i].partyId == myId ? .w700 : .w400,
                    color: AppColorManager.neutral700,
                    maxLines: 1,
                  ),
                ),
                if (waiting[i].isPointOfOrder)
                  StatusChip(colors: PollOutcome.tied.colors, label: S.of(context).pointOfOrder),
                if (canControl) ...[
                  8.0.horizontalSpace,
                  LiveQueueActions(request: waiting[i], sending: sending),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

/// Ask for the floor / point of order, or my place in the queue with withdraw.
class _FloorActions extends StatelessWidget {
  const _FloorActions({required this.live, required this.sending});

  final MeetingLiveState live;
  final bool sending;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MeetingLiveCubit>();
    final mine = live.myRequest;

    if (mine != null && mine.state == SpeakerRequestState.speaking) {
      return _Note(icon: Icons.record_voice_over_outlined, text: S.of(context).liveYourTurn);
    }

    if (mine != null && mine.state == SpeakerRequestState.waiting) {
      return Row(
        children: [
          Expanded(
            child: _Note(
              icon: Icons.hourglass_top_rounded,
              text: live.myPlace > 0 ? S.of(context).liveYourPlace(live.myPlace) : S.of(context).liveRequestSent,
            ),
          ),
          8.0.horizontalSpace,
          MyButton(
            variant: .dangerSoft,
            size: .medium,
            width: 120.0.w,
            loading: sending,
            text: S.of(context).liveWithdraw,
            onTap: cubit.withdrawFloor,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: MyButton(
            size: .medium,
            loading: sending,
            text: S.of(context).liveAskToSpeak,
            startIcon: ImageMultiType(
              url: Icons.front_hand_outlined,
              width: 18.0.r,
              height: 18.0.r,
              color: AppColorManager.neutral0,
            ),
            onTap: () => cubit.requestFloor(pointOfOrder: false),
          ),
        ),
        8.0.horizontalSpace,
        Expanded(
          child: MyButton(
            variant: .outline,
            size: .medium,
            enable: !sending,
            text: S.of(context).pointOfOrder,
            onTap: () => cubit.requestFloor(pointOfOrder: true),
          ),
        ),
      ],
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: text,
      size: 14.0.sp,
      fontWeight: .w600,
      color: AppColorManager.primary700,
      drawablePadding: 8.0.w,
      drawableStart: ImageMultiType(url: icon, width: 18.0.r, height: 18.0.r, color: AppColorManager.primary700),
    );
  }
}
