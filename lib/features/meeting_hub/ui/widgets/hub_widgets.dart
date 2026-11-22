import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/icon_tile.dart';
import 'package:mms/core/widgets/in_app_notification.dart';
import 'package:mms/core/widgets/status_chip.dart';
import 'package:mms/features/meeting_hub/bloc/meeting_hub_cubit/meeting_hub_cubit.dart';
import 'package:mms/features/meeting_hub/data/response/hub_message_response.dart';
import 'package:mms/generated/l10n.dart';

/// Live-updates status pill for the meeting AppBar. Tap to reconnect when offline.
class HubStatusChip extends StatelessWidget {
  const HubStatusChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingHubCubit, MeetingHubInitial>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) {
        final (String label, StatusColors colors) = switch (state.status) {
          .connected => (S.of(context).liveConnected, MeetingStatus.running.colors),
          .connecting => (S.of(context).liveConnecting, MeetingStatus.postponed.colors),
          .reconnecting => (S.of(context).liveReconnecting, MeetingStatus.postponed.colors),
          .disconnected => (S.of(context).liveDisconnected, MeetingStatus.archived.colors),
        };
        final offline = state.status == .disconnected;

        return Tooltip(
          message: offline ? S.of(context).liveTapToRetry : S.of(context).liveUpdates,
          child: InkWell(
            borderRadius: BorderRadius.circular(999),
            onTap: offline ? () => context.read<MeetingHubCubit>().retry() : null,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 44.0.h),
              child: Center(
                child: StatusChip(
                  colors: colors,
                  label: label,
                  glow: state.status == .connected,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Shows an in-app banner describing a hub message.
void showHubNotification(BuildContext context, HubMessage message) {
  final data = message.data;
  final s = S.of(context);

  String text(String key) => (data[key] ?? '').toString();
  int number(String key) => int.tryParse((data[key] ?? '').toString()) ?? -1;

  final (String title, String body, IconData icon) = switch (message.event) {
    // Live state changes often (timer ticks): no banner for it.
    null || .liveStateUpdated => ('', '', Icons.notifications_none_rounded),
    .agendaItemStatusUpdated => (
        s.hubAgendaUpdated,
        s.hubAgendaUpdatedBody(text('title'), switch (number('agendaItemStatus')) {
          0 => s.agendaStatusPending,
          1 => s.agendaStatusActive,
          2 => s.agendaStatusConcluded,
          3 => s.agendaStatusDelayed,
          _ => '',
        }),
        Icons.list_alt_rounded,
      ),
    .pollStatusUpdated => (
        switch (number('status')) {
          1 => s.hubPollOpened,
          2 => s.hubPollClosed,
          _ => s.hubPollUpdated,
        },
        text('topic'),
        Icons.how_to_vote_outlined,
      ),
    .pollPublished => (s.hubPollPublished, text('topic'), Icons.pie_chart_outline_rounded),
    .decisionPublished => (s.hubDecisionPublished, text('statement'), Icons.gavel_rounded),
    .discussionStatusUpdated => (
        switch (number('status')) {
          1 => s.hubDiscussionOpened,
          2 => s.hubDiscussionClosed,
          _ => s.hubDiscussionUpdated,
        },
        text('topic'),
        Icons.forum_outlined,
      ),
  };

  if (title.isEmpty) return;
  InAppNotification.show(context, title: title, body: body, icon: icon, tone: IconTileTone.primary);
}
