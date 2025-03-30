import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/appointment.dart';
import 'package:logaluxe_users/widget/card/appointment.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class BookingHistory extends ConsumerWidget {
  const BookingHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allAppointment = ref.watch(appointmentProvider).data;

    Widget body = Container(
      height: 600,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Image.asset(
                'images/empty.png',
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LogaText(
                content: "No Appointment History",
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight),
          ],
        ),
      ),
    );

    if (allAppointment.isNotEmpty)
      body = Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: allAppointment.map((appointment) => AppointmentCard(appointment: appointment)).toList(),
        ),
      );
    return ref.watch(appointmentProvider).loadingState == true
        ? Container(
            height: 600,
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          )
        : body;
  }
}
