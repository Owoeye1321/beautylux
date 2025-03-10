import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/dummy_data/appointment.dart';
import 'package:logaluxe_users/model/appointment.dart';

class AppointmentNotifier extends StateNotifier<List<Appointment>> {
  AppointmentNotifier() : super(allAppointment);
}

var appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, List<Appointment>>((ref) => AppointmentNotifier());
