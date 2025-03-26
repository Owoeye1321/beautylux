import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/booking.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/slot.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/screen/auth/login.dart';
import 'package:logaluxe_users/widget/calender.dart';
import 'package:logaluxe_users/widget/card/booking_summary.dart';
import 'package:logaluxe_users/widget/card/service.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/widget/slot_grid.dart';
import 'package:logaluxe_users/widget/staff_container.dart';
import 'package:logaluxe_users/widget/text_row.dart';
import 'package:toastification/toastification.dart';

class ReviewBooking extends ConsumerStatefulWidget {
  String company_id;
  ReviewBooking({super.key, required this.company_id});

  @override
  ConsumerState<ReviewBooking> createState() => _ReviewBookingState();
}

class _ReviewBookingState extends ConsumerState<ReviewBooking> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  String errorMessage = '';

  _removeService(ServiceModel service) {
    ref.read(bookingProvider.notifier).removeService(service);
    Navigator.pop(context);
  }

  _setDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    fetchTimeSlot();
  }

  bookAppointment() async {
    try {
      BookingModel bookings = ref.read(bookingProvider);
      UserModel profile = ref.read(profileProvider);
      var response = await ref
          .read(bookingProvider.notifier)
          .bookAppointment(bookings, profile.token, profile.first_name, profile.last_name);
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(response['message']),
        type: ToastificationType.success,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        primaryColor: Colors.green,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      });
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(errorMessage),
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
    }
  }

  _confirmBooking() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          height: 100,
          padding: EdgeInsets.only(top: 50),
          child: Center(
            child: LogaText(
              content: "Proceed with bookings ?",
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: LogaText(
              content: "No",
              color: Theme.of(context).colorScheme.onError,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
            ),
          ),
          SizedBox(
            width: 100,
          ),
          TextButton(
            child: LogaText(
              content: "Yes",
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

    //Navigator.pop(context);
  }

  fetchTimeSlot() async {
    try {
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2ExZTI2M2NlZWRlYWRkMWJhMjYyZTQiLCJuYW1lIjoiam9zaG5qb2huIiwicm9sZSI6InByb2Zlc3Npb25hbCIsImlhdCI6MTc0MjkzODc2NiwiZXhwIjoxNzQzMDI1MTY2fQ.nwlIYCGRNdrONLhtRiSYpIp-2_7JiJ-xiNpYGNA7QBU';
      ref.read(slotProvider.notifier).getBookingTimeSlot(selectedDate, widget.company_id, token);
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceAll('Exception: ', '');
      });
      toastification.show(
        context: context, // optional if you use ToastificationWrapper
        title: Text(errorMessage),
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 2),
        animationDuration: const Duration(milliseconds: 100),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var bookingDetails = ref.watch(bookingProvider);
    final currentDate = DateTime.now();
    final firstDate = DateTime(currentDate.year - 1, currentDate.month, currentDate.day);
    final lastDate = DateTime(currentDate.year + 4, currentDate.month, currentDate.day);

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 70),
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
                    color: Theme.of(context).colorScheme.outline.withAlpha((0.5 * 255).toInt()),
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
            ref.watch(userProvider).loadingState == true
                ? Container(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  )
                : ref.watch(userProvider).staffs.isNotEmpty
                    ? SizedBox(
                        height: 200,
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: ref.watch(userProvider).staffs.map((eachStaff) {
                                return StaffContainer(staff: eachStaff);
                              }).toList(),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: LogaText(
                              content: "Empty Staffs",
                              color: Theme.of(context).colorScheme.onInverseSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight),
                        ),
                      ),
            RowText(rightText: "", leftText: "Select Date & Time", action: () {}),
            LogaLuxeCalender(
              selectDate: _setDate,
            ),
            RowText(rightText: "", leftText: "Select Time Slot", action: () {}),
            SlotGrid(
              slot_date: selectedDate,
              company_id: widget.company_id,
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
                  color: Theme.of(context).colorScheme.onInverseSurface.withAlpha((0.6 * 255).toInt()),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogaText(
                        content: "Total(1 service)",
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
                    width: 70,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _confirmBooking();
                    },
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all(
                        Size(0, 0),
                      ),
                      fixedSize: WidgetStateProperty.all((Size(150, 55))),
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
