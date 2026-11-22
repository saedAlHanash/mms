import 'package:go_router/go_router.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/dashed_border.dart';
import 'package:mms/core/widgets/initials_avatar.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/features/attendees/data/response/attendee_response.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';
import 'package:mms/features/meetings/bloc/my_guest_suggestions_cubit/my_guest_suggestions_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';

/// Meeting drawer: attendees, guests and suggested guests in one scroll list,
/// with the "suggest a guest" button pinned at the bottom.
class AttendeesListWidget extends StatelessWidget {
  const AttendeesListWidget({super.key, required this.meeting});

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 64.0.h,
            padding: EdgeInsetsDirectional.only(start: 16.0.w, end: 8.0.w),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColorManager.neutral50)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: DrawableText(
                    text: S.of(context).attendeesAndGuests,
                    size: 18.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral900,
                  ),
                ),
                IconButton(
                  tooltip: S.of(context).close,
                  constraints: BoxConstraints(minWidth: 44.0.r, minHeight: 44.0.r),
                  onPressed: () => Navigator.pop(context),
                  icon: ImageMultiType(
                    url: Icons.close_rounded,
                    width: 22.0.r,
                    height: 22.0.r,
                    color: AppColorManager.neutral700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 8.0.h),
              children: [
                _SectionTitle(text: '${S.of(context).attendees} (${meeting.attendeesList.length})'),
                ...meeting.attendeesList.map((e) => _AttendeeRow(item: e)),
                if (meeting.guestsList.isNotEmpty) ...[
                  _SectionTitle(text: '${S.of(context).guests} (${meeting.guestsList.length})'),
                  ...meeting.guestsList.map((e) => _GuestRow(guest: e)),
                ],
                if (meeting.guestSuggestions.isNotEmpty) ...[
                  _SectionTitle(text: '${S.of(context).suggestedGuests} (${meeting.guestSuggestions.length})'),
                  ...meeting.guestSuggestions.map((e) => _GuestRow(guest: e, suggested: true)),
                ],
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0.r),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColorManager.neutral50)),
            ),
            child: MyButton(
              width: double.infinity,
              startIcon: ImageMultiType(
                url: Icons.person_add_alt_1_outlined,
                width: 20.0.r,
                height: 20.0.r,
                color: AppColorManager.neutral0,
              ),
              onTap: () {
                context.pushNamed<bool>(RouteName.addGuest).then((value) {
                  if (value is bool && value && context.mounted) {
                    context.read<MeetingCubit>().getData(newData: true);
                    context.read<MyGuestSuggestionsCubit>().getData();
                  }
                });
              },
              text: S.of(context).suggestingGuest,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0.w, 14.0.h, 16.0.w, 4.0.h),
      child: DrawableText(
        text: text,
        size: 13.0.sp,
        fontWeight: .w700,
        color: AppColorManager.neutral500,
      ),
    );
  }
}

/// Row shell: 40 avatar + name (+ "You") + second line (+ trailing).
class _PersonRow extends StatelessWidget {
  const _PersonRow({
    required this.avatar,
    required this.name,
    required this.subtitle,
    this.isMe = false,
    this.trailing,
  });

  final Widget avatar;
  final String name;
  final Widget subtitle;
  final bool isMe;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 60.0.h),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
      child: Row(
        children: [
          avatar,
          12.0.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: DrawableText(
                        text: name,
                        size: 15.0.sp,
                        fontWeight: .w600,
                        color: AppColorManager.neutral900,
                        maxLines: 1,
                      ),
                    ),
                    if (isMe) ...[
                      8.0.horizontalSpace,
                      _Pill(text: S.of(context).you),
                    ],
                  ],
                ),
                subtitle,
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class _AttendeeRow extends StatelessWidget {
  const _AttendeeRow({required this.item});

  final Attendee item;

  @override
  Widget build(BuildContext context) {
    // The check-in time when there is one, else the recorded attendance time.
    final time = item.checkedInAt ?? item.attendanceDate;
    final recorded = item.hasAttended && time != null;

    final Widget subtitle = recorded
        ? Row(
            mainAxisSize: .min,
            children: [
              ImageMultiType(
                url: Icons.check_rounded,
                width: 15.0.r,
                height: 15.0.r,
                color: AppColorManager.successText,
              ),
              5.0.horizontalSpace,
              DrawableText(
                text: S.of(context).attendanceRecorded,
                size: 13.0.sp,
                fontWeight: .w600,
                color: AppColorManager.successText,
              ),
              5.0.horizontalSpace,
              Directionality(
                textDirection: .ltr,
                child: DrawableText(
                  text: time.formatTime,
                  size: 13.0.sp,
                  fontWeight: .w600,
                  color: AppColorManager.successText,
                ),
              ),
            ],
          )
        : DrawableText(
            text: S.of(context).attendanceNotRecorded,
            size: 13.0.sp,
            color: AppColorManager.neutral500,
          );

    return _PersonRow(
      avatar: InitialsAvatar(name: item.fullName, size: 40),
      name: item.fullName,
      isMe: item.partyId == AppProvider.getParty.id,
      subtitle: subtitle,
    );
  }
}

class _GuestRow extends StatelessWidget {
  const _GuestRow({required this.guest, this.suggested = false});

  final Guest guest;
  final bool suggested;

  @override
  Widget build(BuildContext context) {
    final initial = guest.name.trim().isEmpty ? '' : guest.name.trim().characters.first;

    final circle = Container(
      width: 40.0.r,
      height: 40.0.r,
      alignment: .center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: suggested ? AppColorManager.neutral0 : AppColorManager.neutral50,
      ),
      child: DrawableText(
        text: initial,
        size: 15.0.sp,
        fontWeight: .w700,
        color: AppColorManager.neutral700,
      ),
    );

    return _PersonRow(
      avatar: suggested ? DashedBorder(color: AppColorManager.neutral300, radius: 999, child: circle) : circle,
      name: guest.name,
      subtitle: Directionality(
        textDirection: .ltr,
        child: DrawableText(text: guest.phone, size: 13.0.sp, color: AppColorManager.neutral500),
      ),
      trailing: suggested
          ? BlocBuilder<MyGuestSuggestionsCubit, MyGuestSuggestionsInitial>(
              builder: (context, state) {
                // My own suggestion: withdraw instead of the "suggested" pill.
                final mine = context.read<MyGuestSuggestionsCubit>().mineFor(guest);
                if (mine != null) {
                  return MyButton(
                    variant: .dangerSoft,
                    size: .medium,
                    width: 88.0.w,
                    loading: state.deletingId == mine.id,
                    text: S.of(context).withdraw,
                    onTap: () => _withdraw(context, mine.id),
                  );
                }
                return _suggestedPill(context);
              },
            )
          : null,
    );
  }

  Future<void> _withdraw(BuildContext context, String id) async {
    await NoteMessage.showCheckDialog(
      context,
      text: S.of(context).withdrawSuggestionConfirm,
      textButton: S.of(context).withdraw,
      image: Icons.person_remove_outlined,
      destructive: true,
      onConfirm: () async {
        final done = await context.read<MyGuestSuggestionsCubit>().delete(id);
        if (done && context.mounted) context.read<MeetingCubit>().getData(newData: true);
      },
    );
  }

  Widget _suggestedPill(BuildContext context) {
    return DashedBorder(
              color: AppColorManager.neutral300,
              radius: 999,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: DrawableText(
                  text: S.of(context).suggested,
                  size: 12.0.sp,
                  fontWeight: .w600,
                  color: AppColorManager.neutral700,
                ),
              ),
            );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      decoration: BoxDecoration(
        color: AppColorManager.neutral50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: DrawableText(
        text: text,
        size: 12.0.sp,
        fontWeight: .w700,
        color: AppColorManager.neutral700,
      ),
    );
  }
}
