import 'package:intl/intl.dart';

class SlotModel {
  final bool? is_booked;
  final int? booked_count;
  final int? max_booking_capacity;
  final DateTime start_time;
  final DateTime end_time;
  final String? company_id;
  final String? name;
  final String? slot_ref;
  const SlotModel(
      {this.is_booked,
      this.booked_count,
      this.max_booking_capacity,
      required this.start_time,
      required this.end_time,
      this.company_id,
      this.name,
      this.slot_ref});

  get formatTime {
    return DateFormat.jm().format(start_time);
  }
}
