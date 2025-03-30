import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/appointment.dart';
import 'package:logaluxe_users/model/appointment.dart';

class AppointmentProviderModel {
  final List<Appointment> data;
  final bool loadingState;
  AppointmentProviderModel({required this.data, required this.loadingState});
}

class AppointmentNotifier extends StateNotifier<AppointmentProviderModel> {
  AppointmentNotifier() : super(AppointmentProviderModel(data: [], loadingState: true));

  Future<AppointmentProviderModel> fetchAppointment(String token, String customer_id) async {
    try {
      var response = await http.get(
          Uri.parse("${dotenv.env['API_URL']!}/customer/appointments?customer_id=${customer_id}"),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        state = AppointmentProviderModel(
            data: Appointment.fromJsonList(jsonDecode(response.body)), loadingState: false);
        return state;
      } else {
        state = AppointmentProviderModel(data: state.data, loadingState: false);
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}

var appointmentProvider =
    StateNotifierProvider<AppointmentNotifier, AppointmentProviderModel>((ref) => AppointmentNotifier());
