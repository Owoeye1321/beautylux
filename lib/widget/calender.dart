import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogaLuxeCalender extends ConsumerStatefulWidget {
  Function selectDate;
  LogaLuxeCalender({super.key, required this.selectDate});

  @override
  ConsumerState<LogaLuxeCalender> createState() => _LogaLuxeCalenderState();
}

class _LogaLuxeCalenderState extends ConsumerState<LogaLuxeCalender> {
  DateTime _currentDate = DateTime.now();

  DateTime? _selectedDate;

  _setDate(DateTime date) {
    setState(() {
      _currentDate = date;
    });
    widget.selectDate(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: ref.watch(displayProvider).colorScheme.outline.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          _setDate(date);
        },
        weekendTextStyle: TextStyle(
          color: ref.watch(displayProvider).colorScheme.outline.withAlpha((0.4 * 255).toInt()),
        ),
        weekdayTextStyle: TextStyle(color: ref.watch(displayProvider).colorScheme.outline),
        thisMonthDayBorderColor: Colors.grey,
        inactiveDaysTextStyle: TextStyle(color: ref.watch(displayProvider).colorScheme.outline),
        weekFormat: false,
        markedDatesMap: null,
        height: double.infinity,
        iconColor: ref.watch(displayProvider).colorScheme.outline,
        selectedDayButtonColor: ref.watch(displayProvider).colorScheme.outline.withAlpha((0.7 * 255).toInt()),
        selectedDateTime: _currentDate,
        daysTextStyle: TextStyle(color: ref.watch(displayProvider).colorScheme.onSurface),
        selectedDayTextStyle: TextStyle(color: ref.watch(displayProvider).colorScheme.onSurface),
        selectedDayBorderColor: ref.watch(displayProvider).colorScheme.onSurface,
      ),
    );
  }
}
