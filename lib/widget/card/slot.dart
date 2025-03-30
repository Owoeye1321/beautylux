import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/slot.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class TimeSlot extends ConsumerStatefulWidget {
  final SlotModel slot;
  const TimeSlot({super.key, required this.slot});
  ConsumerState<TimeSlot> createState() => _TimeSlot();
}

class _TimeSlot extends ConsumerState<TimeSlot> {
  _addBookingSlot(SlotModel slot) {
    ref.read(bookingProvider.notifier).addBookingSlot(slot);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _addBookingSlot(widget.slot);
      },
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.only(left: 25, top: 11),
        decoration: BoxDecoration(
          color: ref.watch(bookingProvider).slot?.id == widget.slot.id
              ? ref.watch(displayProvider).colorScheme.outline.withAlpha((0.8 * 255).toInt())
              : ref.watch(displayProvider).colorScheme.outline.withAlpha((0.2 * 255).toInt()),
          borderRadius: BorderRadius.circular(10),
        ),
        child: LogaText(
          content: widget.slot.formatTime,
          color: ref.watch(displayProvider).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
        ),
      ),
    );
  }
}
