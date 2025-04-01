import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/appointment.dart';
import 'package:logaluxe_users/model/product.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/provider/product.dart';
import 'package:logaluxe_users/widget/card/product.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ProductPurchaseList extends ConsumerWidget {
  final String currency;
  const ProductPurchaseList({super.key, required this.currency});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductModel> products = ref.watch(productProvider).products;
    List<ProductModel> bookedAppointment = ref.watch(bookingProvider).products;
    Widget body = Container(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/empty.png',
              color: ref.watch(displayProvider).colorScheme.onPrimary,
            ),
            SizedBox(
              height: 10,
            ),
            LogaText(
              content: "Empty Products",
              color: ref.watch(displayProvider).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
            ),
          ],
        ),
      ),
    );
    if (products.isNotEmpty)
      body = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ...products.map(
              (eachProduct) {
                return ProductCard(
                  product: eachProduct,
                  currency: currency,
                  addedProduct: ref.watch(bookingProvider).products.isNotEmpty &&
                          ref
                              .watch(bookingProvider)
                              .products
                              .where((each) => each.id == eachProduct.id)
                              .toList()
                              .isNotEmpty
                      ? true
                      : false,
                );
              },
            ).toList()
          ],
        ),
      );
    return ref.watch(productProvider).loadingState == true
        ? Container(
            padding: EdgeInsets.only(top: 60),
            child: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
              ),
            ),
          )
        : body;
  }
}
