import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/slot.dart';
import 'package:logaluxe_users/widget/card/slot.dart';

class SlotGrid extends ConsumerWidget {
  final DateTime slot_date;
  const SlotGrid({super.key, required this.slot_date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allSlot = ref.watch(slotProvider);
    return SizedBox(
      height: 100,
      child: GridView.builder(
        padding: EdgeInsets.all(0),
        physics: ScrollPhysics(),
        // physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 40,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
        ),
        itemCount: allSlot.length,
        itemBuilder: (context, index) =>
            TimeSlot(content: "${allSlot[index].formatTime}", slot_ref: "${allSlot[index].slot_ref}"),
      ),
    );
  }
}
