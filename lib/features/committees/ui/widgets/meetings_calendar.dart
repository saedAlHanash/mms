import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:intl/intl.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/meetings/bloc/meetings_cubit/meetings_cubit.dart';
import 'package:mms/features/meetings/data/response/meetings_response.dart';
import 'package:mms/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';

/// Month calendar of meetings + the selected day's title, followed by
/// whatever [builder] returns for that day's meetings.
class MeetingCalenderWidget extends StatefulWidget {
  const MeetingCalenderWidget({
    super.key,
    required this.builder,
    this.doteColor = AppColorManager.primary500,
    this.onSelectDate,
  });

  final Widget Function(BuildContext ctx, List<Meeting> list, Widget? widget) builder;
  final void Function(DateTime d)? onSelectDate;
  final Color doteColor;

  @override
  State<MeetingCalenderWidget> createState() => _MeetingCalenderWidgetState();
}

class _MeetingCalenderWidgetState extends State<MeetingCalenderWidget> {
  late final ValueNotifier<List<Meeting>> _selectedEvents;

  late DateTime kToday;
  late DateTime kFirstDay;
  late DateTime kLastDay;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    kToday = DateTime.now();
    kFirstDay = DateTime(kToday.year - 2, kToday.month, kToday.day);
    kLastDay = DateTime(kToday.year + 10, kToday.month, kToday.day);
    _selectedEvents = ValueNotifier([]);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Meeting> _getEventsForDay(DateTime day, Map<int, List<Meeting>> map) {
    return map[day.hashDate] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay, Map<int, List<Meeting>> map) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay, map);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0.w),
          padding: EdgeInsets.fromLTRB(10.0.w, 8.0.h, 10.0.w, 10.0.h),
          decoration: BoxDecoration(
            color: AppColorManager.neutral25,
            border: Border.all(color: AppColorManager.neutral50),
            borderRadius: BorderRadius.circular(16.0.r),
          ),
          child: BlocConsumer<MeetingsCubit, MeetingsInitial>(
            listener: (context, state) {
              widget.onSelectDate?.call(_focusedDay);
              _onDaySelected(_focusedDay, _focusedDay, state.events);
            },
            listenWhen: (p, c) => c.done,
            builder: (context, state) {
              if (state.statuses.loading) return const _CalendarSkeleton();

              return TableCalendar<Meeting>(
                locale: locale,
                onDaySelected: (selectedDay, focusedDay) {
                  _onDaySelected(selectedDay, focusedDay, state.events);
                  widget.onSelectDate?.call(focusedDay);
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: (day) => _getEventsForDay(day, state.events),
                daysOfWeekHeight: 24.0.h,
                rowHeight: 40.0.h,
                calendarFormat: CalendarFormat.month,
                availableGestures: AvailableGestures.horizontalSwipe,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  headerPadding: EdgeInsets.zero,
                  leftChevronPadding: EdgeInsets.all(8.0.r),
                  rightChevronPadding: EdgeInsets.all(8.0.r),
                  leftChevronMargin: EdgeInsets.zero,
                  rightChevronMargin: EdgeInsets.zero,
                  // Month name localized, year kept in Latin digits.
                  titleTextFormatter: (date, locale) => '${DateFormat.MMMM(locale).format(date)} ${date.year}',
                  titleTextStyle: TextStyle(
                    fontSize: 17.0.sp,
                    fontWeight: .w700,
                    color: AppColorManager.neutral900,
                  ),
                  leftChevronIcon: ImageMultiType(
                    url: Icons.chevron_left_rounded,
                    width: 24.0.r,
                    height: 24.0.r,
                    color: AppColorManager.neutral700,
                  ),
                  rightChevronIcon: ImageMultiType(
                    url: Icons.chevron_right_rounded,
                    width: 24.0.r,
                    height: 24.0.r,
                    color: AppColorManager.neutral700,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontSize: 12.0.sp, fontWeight: .w600, color: AppColorManager.neutral500),
                  weekendStyle: TextStyle(fontSize: 12.0.sp, fontWeight: .w600, color: AppColorManager.neutral500),
                ),
                calendarStyle: const CalendarStyle(outsideDaysVisible: false),
                calendarBuilders: CalendarBuilders<Meeting>(
                  defaultBuilder: (context, day, _) => _DayCell(day: day, style: .normal),
                  todayBuilder: (context, day, _) => _DayCell(day: day, style: .today),
                  selectedBuilder: (context, day, _) => _DayCell(day: day, style: .selected),
                  markerBuilder: (context, day, events) {
                    if (events.isEmpty) return null;
                    final selected = isSameDay(_selectedDay, day);
                    return Positioned(
                      bottom: 6.0.h,
                      child: Container(
                        width: 5.0.r,
                        height: 5.0.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selected ? AppColorManager.neutral0 : widget.doteColor,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        _SelectedDayTitle(day: _selectedDay, locale: locale, events: _selectedEvents),
        ValueListenableBuilder<List<Meeting>>(
          valueListenable: _selectedEvents,
          builder: widget.builder,
        ),
      ],
    );
  }
}

enum _DayStyle { normal, today, selected }

/// 40px day circle.
class _DayCell extends StatelessWidget {
  const _DayCell({required this.day, required this.style});

  final DateTime day;
  final _DayStyle style;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground, Border? border, FontWeight weight) = switch (style) {
      .selected => (AppColorManager.primary500, AppColorManager.neutral0, null, FontWeight.w700),
      .today => (
          AppColorManager.neutral0,
          AppColorManager.primary700,
          Border.all(color: AppColorManager.primary500, width: 1.5),
          FontWeight.w700,
        ),
      .normal => (Colors.transparent, AppColorManager.neutral900, null, FontWeight.w400),
    };

    return Center(
      child: Container(
        width: 40.0.r,
        height: 40.0.r,
        alignment: .center,
        decoration: BoxDecoration(shape: BoxShape.circle, color: background, border: border),
        child: DrawableText(
          text: '${day.day}',
          size: 15.0.sp,
          fontWeight: weight,
          color: foreground,
        ),
      ),
    );
  }
}

/// "Monday 9 November · Today" + meetings count.
class _SelectedDayTitle extends StatelessWidget {
  const _SelectedDayTitle({required this.day, required this.locale, required this.events});

  final DateTime? day;
  final String locale;
  final ValueNotifier<List<Meeting>> events;

  @override
  Widget build(BuildContext context) {
    final day = this.day;
    if (day == null) return 18.0.verticalSpace;

    final isToday = isSameDay(day, DateTime.now());
    final title =
        '${DateFormat.EEEE(locale).format(day)} ${day.day} ${DateFormat.MMMM(locale).format(day)}'
        '${isToday ? ' · ${S.of(context).today}' : ''}';

    return Padding(
      padding: EdgeInsets.fromLTRB(20.0.w, 18.0.h, 20.0.w, 4.0.h),
      child: ValueListenableBuilder<List<Meeting>>(
        valueListenable: events,
        builder: (context, list, _) {
          return DrawableText(
            text: title,
            size: 16.0.sp,
            fontWeight: .w700,
            color: AppColorManager.neutral900,
            matchParent: true,
            drawableEnd: list.isEmpty
                ? null
                : DrawableText(
                    text: S.of(context).meetingsCount(list.length),
                    size: 13.0.sp,
                    color: AppColorManager.neutral500,
                  ),
          );
        },
      ),
    );
  }
}

class _CalendarSkeleton extends StatelessWidget {
  const _CalendarSkeleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290.0.h,
      child: Column(
        children: [
          8.0.verticalSpace,
          SkeletonBox(width: 120.0.w, height: 20, radius: 6),
          16.0.verticalSpace,
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10.0.h,
              crossAxisSpacing: 8.0.w,
              childAspectRatio: 1.4,
              children: List.generate(35, (_) => const SkeletonBox(height: 28, radius: 999)),
            ),
          ),
        ],
      ),
    );
  }
}
