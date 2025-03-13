import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/widget/calender.dart';
import 'package:logaluxe_users/widget/card/booking_summary.dart';
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

  _makeBooking() {
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
      color: Theme.of(context).colorScheme.surface,
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
            SlotGrid(slot_date: selectedDate!),
            SizedBox(
              height: 20,
            ),
            RowText(rightText: "", leftText: "Booking Summary", action: () {}),
            BookingSummary(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.task_alt,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  LogaText(
                    content: "Pay after service",
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogaText(
                        content: "Total(3 service)",
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      LogaText(
                        content: "\$${bookingDetails.total}",
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: Theme.of(context).textTheme.titleMedium?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodyLarge?.fontWeight as FontWeight,
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _makeBooking();
                    },
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(
                        Size(0, 0),
                      ),
                      fixedSize: WidgetStateProperty.all((Size(180, 55))),
                      padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                    child: Text("Book Now"),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
