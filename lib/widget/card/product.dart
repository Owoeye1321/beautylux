import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/product.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ProductCard extends ConsumerStatefulWidget {
  final ProductModel product;
  final String currency;
  final bool addedProduct;
  const ProductCard({super.key, required this.product, required this.currency, required this.addedProduct});
  ConsumerState<ProductCard> createState() => _ProductCard();
}

class _ProductCard extends ConsumerState<ProductCard> {
  _removeProduct(ProductModel product) {
    ref.read(bookingProvider.notifier).removeProduct(product);
  }

  _addProduct(ProductModel product) {
    ref.read(bookingProvider.notifier).addProduct(product);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 115,
      width: screenWidth * 1,
      decoration: BoxDecoration(
        color: ref.watch(displayProvider).colorScheme.onTertiaryContainer.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            height: 110,
            width: screenWidth * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: widget.product.iamge_url_1 != null &&
                        widget.product.iamge_url_1 != '' &&
                        widget.product.iamge_url_1 != 'string' &&
                        widget.product.iamge_url_1.length > 15
                    ? NetworkImage(widget.product.iamge_url_1!)
                    : AssetImage('images/home.png') as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 10, right: screenWidth * 0.05, bottom: 0),
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
                          content: widget.product.name,
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: widget.product.product_category == "men"
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: ref
                                      .watch(displayProvider)
                                      .colorScheme
                                      .onInverseSurface
                                      .withAlpha((0.3 * 255).toInt()),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: LogaText(
                                  content: widget.product.product_category,
                                  color: ref.watch(displayProvider).colorScheme.onSurface,
                                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                                  fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                                ),
                              )
                            : widget.product.product_category == "women"
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: ref.watch(displayProvider).colorScheme.onPrimary.withAlpha(
                                            (0.3 * 255).toInt(),
                                          ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: LogaText(
                                      content: widget.product.product_category,
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
                                      content: widget.product.product_category,
                                      color: ref.watch(displayProvider).colorScheme.onSurface,
                                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                                      fontweight:
                                          Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                                    ),
                                  ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: screenWidth * 0.38,
                        child: LogaText(
                          content: widget.product.description,
                          maxLines: 2,
                          setMaxLine: true,
                          color: ref.watch(displayProvider).colorScheme.outline,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                        ),
                      ),
                      widget.addedProduct == true
                          ? Container(
                              width: screenWidth * 0.09,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.green,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  _removeProduct(widget.product);
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
                              width: screenWidth * 0.09,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: ref.watch(displayProvider).colorScheme.onPrimary,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  _addProduct(widget.product);
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
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: LogaText(
                          content: "Amount",
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: LogaText(
                          content: "${widget.currency}${widget.product.amount}",
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
