import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/slot.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/slot.dart';
import 'package:logaluxe_users/widget/card/slot.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:toastification/toastification.dart';

class SlotGrid extends ConsumerStatefulWidget {
  final DateTime slot_date;
  String company_id;
  SlotGrid({super.key, required this.slot_date, required this.company_id});
  @override
  ConsumerState<SlotGrid> createState() => _SlotGrid();
}

class _SlotGrid extends ConsumerState<SlotGrid> {
  @override
  void initState() {
    super.initState();
  }

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    var allSlot = ref.watch(slotProvider).slots;
    Widget body = Container(
      child: Center(
        child: Column(
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
                content: "No Slots for the selected date",
                color: ref.watch(displayProvider).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight),
          ],
        ),
      ),
    );

    if (allSlot.isNotEmpty)
      body = SizedBox(
        height: 100,
        child: GridView.builder(
            padding: EdgeInsets.all(0),
            physics: ScrollPhysics(),
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 40,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: allSlot.length,
            itemBuilder: (context, index) => TimeSlot(slot: allSlot[index])),
      );
    return ref.watch(slotProvider).loadingState == true
        ? Container(
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
