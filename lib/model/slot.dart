import 'package:intl/intl.dart';

class SlotModel {
  final bool is_booked;
  final int? booked_count;
  final int? max_booking_capacity;
  final DateTime start_time;
  final DateTime end_time;
  final String? company_id;
  final String? name;
  final String? slot_ref;
  final String id;
  const SlotModel(
      {required this.is_booked,
      this.booked_count,
      this.max_booking_capacity,
      required this.start_time,
      required this.end_time,
      this.company_id,
      this.name,
      required this.id,
      this.slot_ref});

  get formatTime {
    return DateFormat.jm().format(start_time);
  }

  static List<SlotModel> fromJsonList(Map<String, dynamic> data) {
    List<SlotModel> allSlots = [];
    for (Map<String, dynamic> eachSlot in data['data']) {
      SlotModel slot = SlotModel(
        id: eachSlot['_id'],
        is_booked: eachSlot['is_booked'],
        start_time: DateTime.parse(eachSlot['start_time']),
        slot_ref: eachSlot['slot_ref'],
        end_time: DateTime.parse(eachSlot['end_time']),
      );
      allSlots.add(slot);
    }
    return allSlots;
  }
}
