import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/meeting_live/bloc/meeting_live_cubit/meeting_live_cubit.dart';
import 'package:mms/features/meeting_live/data/response/meeting_live_response.dart';
import 'package:mms/features/meeting_live/ui/widgets/live_clock.dart';
import 'package:mms/generated/l10n.dart';

/// A round 44 tap target with an icon (and a tooltip for its meaning).
class LiveIconButton extends StatelessWidget {
  const LiveIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.filled = false,
    this.danger = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final bool filled;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    final (bg, fg, border) = filled
        ? (AppColorManager.primary500, AppColorManager.neutral0, AppColorManager.primary500)
        : danger
        ? (AppColorManager.dangerSoft, AppColorManager.danger, AppColorManager.dangerSoft)
        : (AppColorManager.neutral0, AppColorManager.neutral700, AppColorManager.neutral100);

    return Tooltip(
      message: tooltip,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: Material(
          color: bg,
          shape: CircleBorder(side: BorderSide(color: border)),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: SizedBox(
              width: 44.0.r,
              height: 44.0.r,
              child: Center(
                child: ImageMultiType(url: icon, width: 20.0.r, height: 20.0.r, color: fg),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Timer and screen controls under the item on screen.
class LiveItemControls extends StatelessWidget {
  const LiveItemControls({super.key, required this.live, required this.sending});

  final MeetingLiveState live;
  final bool sending;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MeetingLiveCubit>();
    final item = live.currentItem;
    final s = S.of(context);

    if (item == null) {
      return Padding(
        padding: EdgeInsets.only(top: 12.0.h),
        child: MyButton(
          variant: .tonal,
          size: .medium,
          width: double.infinity,
          enable: !sending && live.items.isNotEmpty,
          text: s.livePickItem,
          startIcon: ImageMultiType(
            url: Icons.cast_rounded,
            width: 18.0.r,
            height: 18.0.r,
            color: AppColorManager.primary700,
          ),
          onTap: () => _pickItem(context, live),
        ),
      );
    }

    final running = item.timer.running;
    VoidCallback? when(VoidCallback f) => sending ? null : f;

    return Padding(
      padding: EdgeInsets.only(top: 12.0.h),
      child: Row(
        children: [
          LiveIconButton(
            icon: running ? Icons.pause_rounded : Icons.play_arrow_rounded,
            tooltip: running ? s.livePause : s.liveStart,
            filled: true,
            onTap: when(() => cubit.setTimer(running ? LiveTimerAction.pause : LiveTimerAction.start)),
          ),
          8.0.horizontalSpace,
          LiveIconButton(
            icon: Icons.replay_rounded,
            tooltip: s.liveReset,
            onTap: when(() {
              NoteMessage.showCheckDialog(
                context,
                text: s.liveResetTitle,
                description: s.liveResetDescription,
                textButton: s.liveReset,
                image: Icons.replay_rounded,
                onConfirm: () => cubit.setTimer(LiveTimerAction.reset),
              );
            }),
          ),
          8.0.horizontalSpace,
          LiveIconButton(
            icon: Icons.remove_rounded,
            tooltip: s.liveMinusMinute,
            onTap: when(() => cubit.setTimer(LiveTimerAction.addTime, seconds: -60)),
          ),
          8.0.horizontalSpace,
          LiveIconButton(
            icon: Icons.add_rounded,
            tooltip: s.livePlusMinute,
            onTap: when(() => cubit.setTimer(LiveTimerAction.addTime, seconds: 60)),
          ),
          const Spacer(),
          MyButton(
            variant: .text,
            size: .medium,
            enable: !sending,
            text: s.liveChangeItem,
            onTap: () => _pickItem(context, live),
          ),
        ],
      ),
    );
  }

  static Future<void> _pickItem(BuildContext context, MeetingLiveState live) async {
    final cubit = context.read<MeetingLiveCubit>();
    final picked = await AppBottomSheet.show<_Pick>(context, child: _ItemsSheet(live: live));
    if (picked == null) return;
    await cubit.setCurrentItem(picked.id);
  }
}

/// Result of [_ItemsSheet]: an item id, or null to clear the screen.
class _Pick {
  const _Pick(this.id);

  final String? id;
}

class _ItemsSheet extends StatelessWidget {
  const _ItemsSheet({required this.live});

  final MeetingLiveState live;

  @override
  Widget build(BuildContext context) {
    final currentId = live.currentItem?.id;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          DrawableText(
            text: S.of(context).livePickItemTitle,
            size: 17.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
          ),
          12.0.verticalSpace,
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: live.items.length,
              separatorBuilder: (_, _) => const Divider(height: 1, color: AppColorManager.neutral100),
              itemBuilder: (context, i) {
                final item = live.items[i];
                final selected = item.id == currentId;
                return InkWell(
                  onTap: () => Navigator.of(context).pop(_Pick(item.id)),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 52.0.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: DrawableText(
                              text: item.title,
                              size: 14.0.sp,
                              fontWeight: selected ? .w700 : .w500,
                              color: selected ? AppColorManager.primary700 : AppColorManager.neutral900,
                              maxLines: 2,
                            ),
                          ),
                          8.0.horizontalSpace,
                          DrawableText(
                            text: LiveClockFormat.format(
                              item.timer.countsUp ? item.timer.elapsedSeconds : item.timer.remainingSeconds,
                            ),
                            size: 13.0.sp,
                            color: AppColorManager.neutral500,
                          ),
                          if (selected) ...[
                            8.0.horizontalSpace,
                            ImageMultiType(
                              url: Icons.check_circle_rounded,
                              width: 20.0.r,
                              height: 20.0.r,
                              color: AppColorManager.primary500,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (currentId != null) ...[
            12.0.verticalSpace,
            MyButton(
              variant: .dangerSoft,
              size: .medium,
              width: double.infinity,
              text: S.of(context).liveClearScreen,
              onTap: () => Navigator.of(context).pop(const _Pick(null)),
            ),
          ],
        ],
      ),
    );
  }
}

/// Next / end speaker and the time per speaker.
class LiveSpeakerControls extends StatelessWidget {
  const LiveSpeakerControls({super.key, required this.live, required this.sending});

  final MeetingLiveState live;
  final bool sending;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MeetingLiveCubit>();
    final s = S.of(context);
    final limit = live.speakerLimitSeconds;

    return Padding(
      padding: EdgeInsets.only(top: 12.0.h),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: MyButton(
                  size: .medium,
                  enable: !sending && live.waiting.isNotEmpty,
                  text: s.liveNextSpeaker,
                  startIcon: ImageMultiType(
                    url: Icons.skip_next_rounded,
                    width: 18.0.r,
                    height: 18.0.r,
                    color: AppColorManager.neutral0,
                  ),
                  onTap: cubit.nextSpeaker,
                ),
              ),
              if (live.speaking != null) ...[
                8.0.horizontalSpace,
                Expanded(
                  child: MyButton(
                    variant: .dangerSoft,
                    size: .medium,
                    enable: !sending,
                    text: s.liveEndSpeaker,
                    onTap: cubit.endSpeaker,
                  ),
                ),
              ],
            ],
          ),
          8.0.verticalSpace,
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: MyButton(
              variant: .text,
              size: .small,
              enable: !sending,
              text: s.liveSpeakerLimit(limit == 0 ? s.liveNoLimit : LiveClockFormat.format(limit)),
              startIcon: ImageMultiType(
                url: Icons.timer_outlined,
                width: 16.0.r,
                height: 16.0.r,
                color: AppColorManager.primary500,
              ),
              onTap: () async {
                final seconds = await AppBottomSheet.show<int>(context, child: _LimitSheet(current: limit));
                if (seconds != null && seconds != limit) await cubit.setSpeakerLimit(seconds);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LimitSheet extends StatelessWidget {
  const _LimitSheet({required this.current});

  final int current;

  static const _options = [60, 120, 180, 300, 600, 0];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        DrawableText(
          text: s.liveSpeakerLimitTitle,
          size: 17.0.sp,
          fontWeight: .w700,
          color: AppColorManager.neutral900,
        ),
        4.0.verticalSpace,
        DrawableText(text: s.liveSpeakerLimitHint, size: 13.0.sp, color: AppColorManager.neutral500),
        16.0.verticalSpace,
        Wrap(
          spacing: 8.0.w,
          runSpacing: 8.0.h,
          children: [
            for (final seconds in _options)
              ChoiceChip(
                label: DrawableText(
                  text: seconds == 0 ? s.liveNoLimit : s.liveMinutes(seconds ~/ 60),
                  size: 13.0.sp,
                  fontWeight: .w600,
                  color: seconds == current ? AppColorManager.neutral0 : AppColorManager.neutral700,
                ),
                selected: seconds == current,
                showCheckmark: false,
                onSelected: (_) => Navigator.of(context).pop(seconds),
                selectedColor: AppColorManager.primary500,
                backgroundColor: AppColorManager.neutral25,
                side: BorderSide(
                  color: seconds == current ? AppColorManager.primary500 : AppColorManager.neutral100,
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
          ],
        ),
      ],
    );
  }
}

/// Give the floor / skip on a waiting request.
class LiveQueueActions extends StatelessWidget {
  const LiveQueueActions({super.key, required this.request, required this.sending});

  final LiveSpeaker request;
  final bool sending;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MeetingLiveCubit>();
    return Row(
      mainAxisSize: .min,
      children: [
        LiveIconButton(
          icon: Icons.mic_none_rounded,
          tooltip: S.of(context).liveGiveFloor,
          onTap: sending ? null : () => cubit.giveFloor(request.id),
        ),
        6.0.horizontalSpace,
        LiveIconButton(
          icon: Icons.close_rounded,
          tooltip: S.of(context).liveSkip,
          danger: true,
          onTap: sending ? null : () => cubit.skipSpeaker(request.id),
        ),
      ],
    );
  }
}
