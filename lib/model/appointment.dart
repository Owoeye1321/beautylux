import 'package:intl/intl.dart';
import 'package:logaluxe_users/model/category.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/model/user.dart';

class Appointment {
  final String payment_status;
  final List<AppointmentProduct> products;
  final String? time;
  final String? first_name;
  final String? last_name;
  final String? phone;
  final String? currency;
  final String status;
  final DateTime start_date;
  final DateTime end_date;
  final int total_amount;
  final int service_amount;
  final ServiceModel service_id;
  final String? note;
  final UserModel? customer_id;
  final UserModel? company_id;
  final String? duration;
  final String? appointment_ref;
  final DateTime createdAt;
  final DateTime updatedAt;
  Appointment(
      {required this.payment_status,
      required this.products,
      this.time,
      required this.status,
      this.first_name,
      this.last_name,
      this.phone,
      this.currency,
      required this.start_date,
      required this.end_date,
      required this.total_amount,
      required this.service_id,
      required this.service_amount,
      this.note,
      this.customer_id,
      this.company_id,
      this.duration,
      this.appointment_ref,
      required this.createdAt,
      required this.updatedAt});

  get formatStartTime {
    final now = DateTime.now();
    final today = DateFormat('EEEE, h:mm a').format(start_date); // Today, 11:00 AM
    final thisWeek = DateFormat('EEEE, h:mm a').format(start_date); // Monday, 11:00 AM
    final thisYear = DateFormat('MMM d, yyyy').format(start_date); // Mar 30, 2025

    if (start_date.year == now.year) {
      if (start_date.difference(now).inDays == 0) {
        return 'Today, ${DateFormat('h:mm a').format(start_date)}';
      } else if (start_date.difference(now).inDays.abs() < 7) {
        return thisWeek;
      }
    }

    return thisYear;
  }

  get formatStartHour {
    return DateFormat('h:mm a').format(start_date); // Today, 11:00 AM
  }

  get formatEndHour {
    return DateFormat('h:mm a').format(end_date); // Today, 11:00 AM
  }

  static List<Appointment> fromJsonList(Map<String, dynamic> data) {
    //print(data['data'][0]);
    List<Appointment> allAppointments = [];
    for (Map<String, dynamic> eachAppointment in data['data']) {
      Appointment appointment = Appointment(
        products: [],
        payment_status: eachAppointment['payment_status'].toString(),
        status: eachAppointment['status'].toString(),
        total_amount: int.parse(eachAppointment['total_amount'].toString()),
        service_id: ServiceModel(
          id: eachAppointment['service_id']['_id'].toString(),
          name: eachAppointment['service_id']['name'].toString(),
          service_duration: eachAppointment['service_id']['service_duration'].toString(),
          location: '',
          service_ref: eachAppointment['service_id']['service_ref'].toString(),
          company_id: UserModel(
            token: '',
            id: '',
            email: '',
            first_name: '',
            bio: '',
            business_address: '',
            business_name: '',
            company_id: '',
          ),
          category_id:
              CategoryModel(id: eachAppointment['service_id']['_id'], category_name: '', category_ref: ''),
          amount: int.parse(eachAppointment['service_id']['amount'].toString()),
          country: '',
          state: '',
          active: false,
          opening_time: '',
          closing_time: '',
          createdAt: '',
          currency: eachAppointment['service_id']['currency'].toString(),
          updatedAt: '',
          description: eachAppointment['service_id']['description'].toString(),
          image_url: '',
        ),
        service_amount: int.parse(eachAppointment['service_amount'].toString()),
        start_date: DateTime.parse(eachAppointment['start_date']),
        end_date: DateTime.parse(eachAppointment['end_date']),
        createdAt: DateTime.parse(eachAppointment['createdAt']),
        updatedAt: DateTime.parse(eachAppointment['updatedAt']),
      );
      allAppointments.add(appointment);
    }
    return allAppointments;
  }
}

class AppointmentProduct {
  final String? id;
  final int? count;
  final String? product_name;
  AppointmentProduct({this.id, this.count, this.product_name});
}
