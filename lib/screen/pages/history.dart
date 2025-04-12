import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/appointment.dart';
import 'package:logaluxe_users/provider/appointment.dart';
import 'package:logaluxe_users/widget/card/appointment.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class BookingHistory extends ConsumerStatefulWidget {
  BookingHistory({super.key});
  @override
  ConsumerState<BookingHistory> createState() => _BookingHistory();
}

class _BookingHistory extends ConsumerState<BookingHistory> {
  _previewAppointment(Appointment appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: LogaText(
          content: "Appointment Details",
          color: ref.watch(displayProvider).isLightMode
              ? ref.watch(displayProvider).colorScheme.surface
              : ref.watch(displayProvider).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
          fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
        ),
        content: Container(
          height: 200,
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: LogaText(
                      content: "Name ",
                      maxLines: 2,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                  Expanded(
                    child: LogaText(
                      content: appointment.service_id.name,
                      maxLines: 2,
                      setMaxLine: true,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: LogaText(
                      content: "Description ",
                      maxLines: 2,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                  Expanded(
                    child: LogaText(
                      content: appointment.service_id.description,
                      maxLines: 2,
                      setMaxLine: true,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: LogaText(
                      content: "Date ",
                      maxLines: 2,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                  Expanded(
                    child: LogaText(
                      content: appointment.formatStartTime,
                      maxLines: 3,
                      setMaxLine: true,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: LogaText(
                      content: "Duration ",
                      maxLines: 2,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                  Expanded(
                    child: LogaText(
                      content: "${appointment.formatStartHour} - ${appointment.formatEndHour}",
                      maxLines: 3,
                      setMaxLine: true,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    height: 25,
                    child: LogaText(
                      content: "Total amount",
                      maxLines: 2,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                  Expanded(
                    child: LogaText(
                      content: "${appointment.service_id.currency}${appointment.total_amount}",
                      maxLines: 3,
                      setMaxLine: true,
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: ref.watch(displayProvider).colorScheme.onInverseSurface,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ref.watch(displayProvider).colorScheme.onPrimary, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );

    //Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                color: ref.watch(displayProvider).colorScheme.onPrimary,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LogaText(
                content: "No Appointment History",
                color: ref.watch(displayProvider).colorScheme.onSurface,
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
          children: allAppointment
              .map((appointment) => AppointmentCard(
                    appointment: appointment,
                    preview: _previewAppointment,
                  ))
              .toList(),
        ),
      );
    return ref.watch(appointmentProvider).loadingState == true
        ? Container(
            height: 600,
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
              ),
            ),
          )
        : body;
  }
}
