import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class StaffContainer extends StatelessWidget {
  final UserModel staff;
  const StaffContainer({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 140,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
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
              height: 15,
            ),
            LogaText(
              content: "${staff.first_name} ${staff.last_name}",
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight! as FontWeight,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.schedule,
                  color: Theme.of(context).colorScheme.outline,
                ),
                SizedBox(
                  width: 10,
                ),
                LogaText(
                  content: "4.7",
                  color: Theme.of(context).colorScheme.outline,
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
