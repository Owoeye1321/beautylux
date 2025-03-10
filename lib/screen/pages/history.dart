import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/appointment.dart';
import 'package:logaluxe_users/widget/card/appointment.dart';

class BookingHistory extends ConsumerWidget {
  const BookingHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allAppointment = ref.watch(appointmentProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: allAppointment.map((appointment) => AppointmentCard(appointment: appointment)).toList(),
      ),
    );
  }
}
