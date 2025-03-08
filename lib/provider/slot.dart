import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/dummy_data/slot.dart';
import 'package:logaluxe_users/model/slot.dart';

class SlotNotifier extends StateNotifier<List<SlotModel>> {
  SlotNotifier() : super(allSlots);
}

var slotProvider = StateNotifierProvider<SlotNotifier, List<SlotModel>>((ref) => SlotNotifier());
