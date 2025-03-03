import 'package:flutter/material.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ServicePurchaseList extends StatefulWidget {
  final List<ServiceModel> services;
  const ServicePurchaseList({super.key, required this.services});

  @override
  State<ServicePurchaseList> createState() => _ServicePurchaseListState();
}

class _ServicePurchaseListState extends State<ServicePurchaseList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: widget.services.map((eachService) {
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
                          image: eachService.image_url != null
                              ? NetworkImage(eachService.image_url!)
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
                                  content: eachService.name,
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                                  fontweight:
                                      Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
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
                              Text(
                                "${eachService.currency}${eachService.amount}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                                ),
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
                              Text(
                                "${eachService.service_duration} Min",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120,
                                child: LogaText(
                                  content: eachService.description,
                                  setMaxLine: true,
                                  maxLines: 2,
                                  color: Theme.of(context).colorScheme.outline,
                                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize! as double,
                                  fontweight:
                                      Theme.of(context).textTheme.bodySmall?.fontWeight! as FontWeight,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
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
        }).toList(),
      ),
    );
    ;
  }
}
