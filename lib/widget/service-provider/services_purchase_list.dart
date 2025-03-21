import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/response.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/service.dart';
import 'package:logaluxe_users/screen/booking/review.dart';
import 'package:logaluxe_users/widget/card/service.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ServicePurchaseList extends ConsumerStatefulWidget {
  const ServicePurchaseList({
    super.key,
  });

  @override
  ConsumerState<ServicePurchaseList> createState() => _ServicePurchaseListState();
}

class _ServicePurchaseListState extends ConsumerState<ServicePurchaseList> {
  _removeService(ServiceModel service) {
    ref.read(bookingProvider.notifier).removeService(service);
  }

  _addService(ServiceModel service) {
    ResponseModel response = ref.read(bookingProvider.notifier).addService(service);
    Widget title = LogaText(
      content: response.status,
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
      fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
    );
    Widget content = LogaText(
      content: response.message,
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
      fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
    );
    Widget action = TextButton(
      onPressed: () {
        if (response.status == "success") {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ReviewBooking()));
        } else {
          Navigator.pop(context);
        }
      },
      child: Text("Proceed to cart"),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ServiceModel> services = ref.watch(serviceProvider).data;
    var selectedService = ref.watch(bookingProvider);
    Widget body = Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Image.asset(
            'images/empty.png',
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          SizedBox(
            height: 10,
          ),
          LogaText(
              content: "Empty",
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight),
        ],
      ),
    );
    if (services.isNotEmpty)
      body = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ...services.map((eachService) {
              return ServiceCard(
                service: eachService,
                removeService: _removeService,
                addService: _addService,
                bookedService: selectedService.service != null &&
                        selectedService.service?.service_ref == eachService.service_ref
                    ? true
                    : false,
              );
            }).toList(),
          ],
        ),
      );
    return ref.watch(serviceProvider).loadingState == true
        ? Container(
            padding: EdgeInsets.only(top: 60),
            child: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          )
        : body;
    ;
  }
}
