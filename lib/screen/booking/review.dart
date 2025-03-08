import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/widget/calender.dart';
import 'package:logaluxe_users/widget/card/service.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/widget/slot_grid.dart';
import 'package:logaluxe_users/widget/staff_container.dart';
import 'package:logaluxe_users/widget/text_row.dart';

class ReviewBooking extends ConsumerStatefulWidget {
  const ReviewBooking({super.key});

  @override
  ConsumerState<ReviewBooking> createState() => _ReviewBookingState();
}

class _ReviewBookingState extends ConsumerState<ReviewBooking> {
  DateTime? selectedDate = DateTime.now();

  _removeService(ServiceModel service) {
    ref.read(bookingProvider.notifier).removeService(service);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var bookingDetails = ref.watch(bookingProvider);
    var staffs = ref.watch(userProvider);
    final currentDate = DateTime.now();
    final firstDate = DateTime(currentDate.year - 1, currentDate.month, currentDate.day);
    final lastDate = DateTime(currentDate.year + 4, currentDate.month, currentDate.day);

    _setDate(DateTime date) {
      setState(() {
        selectedDate = date;
      });
    }

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 70),
      color: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.chevron_left,
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                LogaText(
                  content: "Bookings Review",
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize! as double,
                  fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            RowText(
              leftText: "Your Service Order",
              rightText: "+ Add More",
              action: () {
                Navigator.pop(context);
                // _showDatePicker();
              },
            ),
            bookingDetails.service != null
                ? ServiceCard(
                    service: bookingDetails.service!,
                    removeService: _removeService,
                    addService: () {},
                    bookedService: true,
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            LogaText(
              content: "Pick a stylist",
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: staffs.map((eachStaff) {
                      return StaffContainer(staff: eachStaff);
                    }).toList(),
                  ),
                ),
              ),
            ),
            RowText(rightText: "", leftText: "Select Time & Date", action: () {}),
            LogaLuxeCalender(
              selectDate: _setDate,
            ),
            RowText(rightText: "", leftText: "Select Time Slot", action: () {}),
            SlotGrid(slot_date: selectedDate!)
          ],
        ),
      ),
    );
  }
}
