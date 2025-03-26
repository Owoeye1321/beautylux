import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logaluxe_users/dummy_data/slot.dart';
import 'package:logaluxe_users/model/slot.dart';

class TimeSlotProviderModel {
  List<SlotModel> slots;
  bool loadingState;
  TimeSlotProviderModel({required this.slots, required this.loadingState});
}

class SlotNotifier extends StateNotifier<TimeSlotProviderModel> {
  SlotNotifier() : super(TimeSlotProviderModel(slots: [], loadingState: true));
  Future<TimeSlotProviderModel> getBookingTimeSlot(DateTime date, String company_id, String token) async {
    state = TimeSlotProviderModel(slots: [], loadingState: true);
    try {
      var response = await http.get(
          Uri.parse(
              "${dotenv.env['API_URL']!}/time-slot?company_id=${company_id}&date=${date.toIso8601String()}"),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      if (response.statusCode == 200) {
        state = TimeSlotProviderModel(
            slots: SlotModel.fromJsonList(jsonDecode(response.body)), loadingState: false);
        return state;
      } else {
        state = TimeSlotProviderModel(slots: [], loadingState: false);
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        String errorMessage = errorResponse['message'] ?? errorResponse['message'];
        throw new Exception(errorMessage);
      }
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}

var slotProvider = StateNotifierProvider<SlotNotifier, TimeSlotProviderModel>((ref) => SlotNotifier());
