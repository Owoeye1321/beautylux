import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/provider/display.dart';

class ServiceCard extends ConsumerWidget {
  final ServiceModel service;
  Function removeService;
  Function addService;
  final bool bookedService;
  ServiceCard({
    super.key,
    required this.service,
    required this.removeService,
    required this.addService,
    required this.bookedService,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: ref.watch(displayProvider).colorScheme.onTertiaryContainer.withAlpha((0.2 * 255).toInt()),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ref.watch(displayProvider).colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: service.image_url != null && service.image_url != ''
                        ? NetworkImage(service.image_url!)
                        : AssetImage('images/home.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                height: 180,
                width: screenWidth * 0.3,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: screenWidth * 0.02, top: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: LogaText(
                              content: service.name,
                              color: ref.watch(displayProvider).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                              fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 60,
                            height: 24,
                            decoration: BoxDecoration(
                              color: ref.watch(displayProvider).colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.local_offer,
                                    color: Colors.orange,
                                    size: 13,
                                  ),
                                  LogaText(
                                    content: "-20%",
                                    color: Colors.orange,
                                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                                    fontweight:
                                        Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          LogaText(
                            content: "${service.currency}${service.amount}",
                            color: ref.watch(displayProvider).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                            fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: ref.watch(displayProvider).colorScheme.onSurfaceVariant),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.schedule,
                            color: ref.watch(displayProvider).colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          LogaText(
                            content: "${service.service_duration} Min",
                            color: ref.watch(displayProvider).colorScheme.outline,
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                            fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 120,
                            child: LogaText(
                              content: service.description,
                              setMaxLine: true,
                              maxLines: 2,
                              color: ref.watch(displayProvider).colorScheme.outline,
                              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                              fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          bookedService == true
                              ? Container(
                                  width: 30,
                                  height: 30,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.green,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      removeService(service);
                                    },
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        EdgeInsets.only(right: 0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: ref.watch(displayProvider).colorScheme.onSurface,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 30,
                                  height: 30,
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ref.watch(displayProvider).colorScheme.onPrimary,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      addService(service);
                                    },
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                        EdgeInsets.only(right: 0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: ref.watch(displayProvider).colorScheme.onSurface,
                                    ),
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
        ),
      ),
    );
  }
}
