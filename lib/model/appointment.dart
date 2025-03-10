import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/model/user.dart';

class Appointment {
  final String payment_status;
  final List<AppointmentProduct>? products;
  final String? time;
  final String first_name;
  final String last_name;
  final String? phone;
  final String? currency;
  final String status;
  final DateTime? start_date;
  final DateTime? end_date;
  final int total_amount;
  final int service_amount;
  final ServiceModel service_id;
  final String? note;
  final UserModel customer_id;
  final UserModel company_id;
  final String? duration;
  final String? appointment_ref;
  final DateTime createdAt;
  final DateTime updatedAt;
  Appointment(
      {required this.payment_status,
      this.products,
      this.time,
      required this.status,
      required this.first_name,
      required this.last_name,
      this.phone,
      this.currency,
      this.start_date,
      this.end_date,
      required this.total_amount,
      required this.service_id,
      required this.service_amount,
      this.note,
      required this.customer_id,
      required this.company_id,
      this.duration,
      this.appointment_ref,
      required this.createdAt,
      required this.updatedAt});
}

class AppointmentProduct {
  final String? id;
  final int? count;
  final String? product_name;
  AppointmentProduct({this.id, this.count, this.product_name});
}
