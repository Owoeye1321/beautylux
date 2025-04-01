import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:logaluxe_users/provider/booking.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/widget/text_row.dart';

class BookingSummary extends ConsumerStatefulWidget {
  const BookingSummary({super.key});

  @override
  ConsumerState<BookingSummary> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends ConsumerState<BookingSummary> {
  @override
  Widget build(BuildContext context) {
    var booking = ref.watch(bookingProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: ref.watch(displayProvider).colorScheme.onInverseSurface.withAlpha((0.6 * 255).toInt()),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          booking.service != null
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: booking.service?.image_url != ''
                              ? NetworkImage(
                                  booking.service?.image_url! as String,
                                )
                              : AssetImage('images/home.png') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LogaText(
                            content: booking.service?.name as String,
                            color: ref.watch(displayProvider).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                            fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                          ),
                          LogaText(
                            content: booking.service?.description as String,
                            color: ref.watch(displayProvider).colorScheme.outline,
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
                                color: ref.watch(displayProvider).colorScheme.outline,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              LogaText(
                                content: DateFormat('EEEE, h:mm a').format(DateTime.now()),
                                color: ref.watch(displayProvider).colorScheme.outline,
                                fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                                fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              : Divider(),
          SizedBox(
            height: 20,
          ),
          booking.products.isNotEmpty
              ? Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogaText(
                        content: "Products",
                        color: ref.watch(displayProvider).colorScheme.onSurface,
                        fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
                        fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                      ),
                      ...booking.products.map(
                        (product) => RowText(
                            rightText: 'Remove',
                            leftText: product.name,
                            action: () {
                              ref.read(bookingProvider.notifier).removeProduct(product);
                            }),
                      )
                    ],
                  ),
                )
              : Divider(),
          Divider(
            thickness: 1,
            color: ref.watch(displayProvider).colorScheme.onInverseSurface,
          ),
          RowText(
            rightText: "\$${booking.total}",
            leftText: "Total cost",
            action: () {},
            setRightTextColor: true,
            rightTextColor: ref.watch(displayProvider).colorScheme.onSurface,
            setRightFontWeight: true,
            rightFontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
          )
        ],
      ),
    );
  }
}
