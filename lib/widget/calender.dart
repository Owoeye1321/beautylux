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
      height: 300,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          _setDate(date);
        },
        weekendTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.4),
        ),
        weekdayTextStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
        thisMonthDayBorderColor: Colors.grey,
        inactiveDaysTextStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
        weekFormat: false,
        markedDatesMap: null,
        height: double.infinity,
        iconColor: Theme.of(context).colorScheme.outline,
        selectedDayButtonColor: Theme.of(context).colorScheme.outline.withOpacity(0.7),
        selectedDateTime: _currentDate,
        daysTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        selectedDayTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        selectedDayBorderColor: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
