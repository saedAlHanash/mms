import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../meetings/bloc/meetings_cubit/meetings_cubit.dart';
import '../../../meetings/data/response/meetings_response.dart';

class MeetingCalenderWidget extends StatefulWidget {
  const MeetingCalenderWidget({
    super.key,
    required this.builder,
    this.doteColor = Colors.red,
    this.onSelectDate,
  });

  final Widget Function(BuildContext ctx, List<Meeting> list, Widget? widget)
      builder;
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
    kFirstDay = DateTime(kToday.year - 1, kToday.month, kToday.day);
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

  void _onDaySelected(
      DateTime selectedDay, DateTime focusedDay, Map<int, List<Meeting>> map) {
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
    const headerStyle = HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      leftChevronPadding: EdgeInsets.all(0.0),
      rightChevronPadding: EdgeInsets.all(0.0),
      headerPadding: EdgeInsets.only(bottom: 8.0),
    );

    final calendarStyle = CalendarStyle(
        selectedDecoration: const BoxDecoration(
          color: AppColorManager.mainColor,
          shape: BoxShape.circle,
        ),
        todayTextStyle: const TextStyle(color: Colors.black),
        markerDecoration: BoxDecoration(
          color: widget.doteColor,
          shape: BoxShape.circle,
        ),
        markerSize: 5.0.spMin,
        todayDecoration: const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0).h,
      child: Column(
        children: [
          10.0.verticalSpace,
          MyCardWidget(
            margin: const EdgeInsets.symmetric(horizontal: 20.0).w,
            cardColor: AppColorManager.cardColor,
            child: BlocConsumer<MeetingsCubit, MeetingsInitial>(
              listener: (context, state) {
                widget.onSelectDate?.call(_focusedDay);
                _onDaySelected(_focusedDay, _focusedDay, state.events);
              },
              listenWhen: (p, c) => c.statuses.done,
              builder: (context, state) {
                if (state.statuses.loading) {
                  return MyStyle.loadingWidget();
                }
                return TableCalendar<Meeting>(
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
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  eventLoader: (day) => _getEventsForDay(day, state.events),
                  daysOfWeekHeight: 25.0.h,
                  rowHeight: 35.0.h,
                  calendarFormat: CalendarFormat.month,
                  availableGestures: AvailableGestures.horizontalSwipe,
                  headerStyle: headerStyle,
                  calendarStyle: calendarStyle,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                );
              },
            ),
          ),
          ValueListenableBuilder<List<Meeting>>(
            valueListenable: _selectedEvents,
            builder: widget.builder,
          ),
        ],
      ),
    );
  }
}
