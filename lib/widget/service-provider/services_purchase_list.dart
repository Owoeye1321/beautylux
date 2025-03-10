import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/response.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/screen/booking/review.dart';
import 'package:logaluxe_users/widget/card/service.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ServicePurchaseList extends ConsumerStatefulWidget {
  final List<ServiceModel> services;
  const ServicePurchaseList({super.key, required this.services});

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
    var selectedService = ref.watch(bookingProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ...widget.services.map((eachService) {
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
    ;
  }
}
