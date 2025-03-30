import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class StaffContainer extends ConsumerWidget {
  final UserModel staff;
  const StaffContainer({super.key, required this.staff});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 160,
      width: 140,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ref.watch(displayProvider).colorScheme.outline.withAlpha((0.2 * 255).toInt()),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: ref.watch(displayProvider).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: staff.image_url != null
                      ? NetworkImage(staff.image_url!)
                      : AssetImage("images/dp.jpeg") as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            LogaText(
              content: "${staff.first_name} ${staff.last_name}",
              color: ref.watch(displayProvider).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight! as FontWeight,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.schedule,
                  color: ref.watch(displayProvider).colorScheme.outline,
                ),
                SizedBox(
                  width: 5,
                ),
                LogaText(
                  content: "4.7",
                  color: ref.watch(displayProvider).colorScheme.outline,
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                  fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight! as FontWeight,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
