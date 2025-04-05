import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/appointment.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/widget/text_row.dart';
import 'package:logaluxe_users/provider/display.dart';

class AppointmentCard extends ConsumerWidget {
  final Appointment appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 108,
      decoration: BoxDecoration(
        color: ref.watch(displayProvider).colorScheme.onTertiaryContainer.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 108,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: appointment.service_id.image_url != null && appointment.service_id.image_url != ''
                    ? NetworkImage(appointment.service_id.image_url!)
                    : AssetImage('images/home.png') as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: LogaText(
                          content: appointment.service_id?.name! as String,
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.only(top: 5),
                        child: appointment.status == "booked"
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: ref.watch(displayProvider).colorScheme.onPrimary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: LogaText(
                                  content: appointment.status,
                                  color: ref.watch(displayProvider).colorScheme.onSurface,
                                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                                ),
                              )
                            : appointment.status == "completed"
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.green, borderRadius: BorderRadius.circular(10)),
                                    child: LogaText(
                                      content: appointment.status,
                                      color: ref.watch(displayProvider).colorScheme.onSurface,
                                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                                      fontweight:
                                          Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: ref.watch(displayProvider).colorScheme.onError,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: LogaText(
                                      content: appointment.status,
                                      color: ref.watch(displayProvider).colorScheme.onSurface,
                                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                                      fontweight:
                                          Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                                    ),
                                  ),
                      )
                    ],
                  ),
                  LogaText(
                    content: appointment.service_id.description,
                    color: ref.watch(displayProvider).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: ref.watch(displayProvider).colorScheme.outline,
                        size: 13,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      LogaText(
                        content: appointment.formatStartTime,
                        color: ref.watch(displayProvider).colorScheme.outline,
                        fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: LogaText(
                          content: "Total cost",
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: LogaText(
                          content: "\$${appointment.total_amount}",
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
