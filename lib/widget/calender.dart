import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class LogaLuxeCalender extends StatefulWidget {
  Function selectDate;
  LogaLuxeCalender({super.key, required this.selectDate});

  @override
  State<LogaLuxeCalender> createState() => _LogaLuxeCalenderState();
}

class _LogaLuxeCalenderState extends State<LogaLuxeCalender> {
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
        color: Theme.of(context).colorScheme.outline.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          _setDate(date);
        },
        weekendTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.outline.withAlpha((0.4 * 255).toInt()),
        ),
        weekdayTextStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
        thisMonthDayBorderColor: Colors.grey,
        inactiveDaysTextStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
        weekFormat: false,
        markedDatesMap: null,
        height: double.infinity,
        iconColor: Theme.of(context).colorScheme.outline,
        selectedDayButtonColor: Theme.of(context).colorScheme.outline.withAlpha((0.7 * 255).toInt()),
        selectedDateTime: _currentDate,
        daysTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        selectedDayTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        selectedDayBorderColor: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
