import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ServiceCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: service.image_url != null && service.image_url != ''
                        ? NetworkImage(service.image_url!)
                        : AssetImage('images/home.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                height: 180,
                width: 155,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 0, top: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 90,
                          child: LogaText(
                            content: service.name,
                            color: Theme.of(context).colorScheme.onSurface,
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
                            color: Theme.of(context).colorScheme.onSurface,
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
                          color: Theme.of(context).colorScheme.onSurface,
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
                              color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.schedule,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        LogaText(
                          content: "${service.service_duration} Min",
                          color: Theme.of(context).colorScheme.outline,
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
                            color: Theme.of(context).colorScheme.outline,
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
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              )
                            : Container(
                                width: 30,
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Theme.of(context).colorScheme.onPrimary,
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
                                    color: Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
