import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/provider/product.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ProductPurchaseList extends ConsumerWidget {
  const ProductPurchaseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var products = ref.watch(productProvider).products;
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
                fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight),
          ],
        ),
      ),
    );
    if (products.isNotEmpty)
      body = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [],
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
