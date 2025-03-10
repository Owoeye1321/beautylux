import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/appointment.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/widget/text_row.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(
                    appointment.service_id?.image_url! as String,
                  ),
                  fit: BoxFit.cover
                  // height: double.infinity,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 140,
                      child: LogaText(
                        content: appointment.service_id?.name! as String,
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                      ),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.bottomRight,
                      child: appointment.status == "booked"
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: LogaText(
                                content: appointment.status,
                                color: Theme.of(context).colorScheme.onSurface,
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
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                                    fontweight:
                                        Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.onError,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: LogaText(
                                    content: appointment.status,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                                    fontweight:
                                        Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                                  ),
                                ),
                    )
                  ],
                ),
                LogaText(
                  content: "with Serah Johnson",
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Theme.of(context).colorScheme.outline,
                      size: 13,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    LogaText(
                      content: "Today, 11:00 AM",
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                      fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: LogaText(
                        content: "Total cost",
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 140,
                      alignment: Alignment.bottomRight,
                      child: LogaText(
                        content: "\$${appointment.total_amount}",
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
