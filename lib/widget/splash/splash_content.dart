import 'package:flutter/material.dart';
import 'package:logaluxe_users/widget/splash/splash_circular_container.dart';
import 'package:logaluxe_users/widget/splash/text.dart';

class SplashContent extends StatefulWidget {
  final int currentSplash;
  const SplashContent({super.key, required this.currentSplash});

  @override
  State<SplashContent> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    late Widget currentWidget = Column(
      children: [
        SplashText(
            title: "Best Stylist For You",
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
            fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight!),
        const SizedBox(
          height: 20,
        ),
        SplashText(
            title: "Styling your appearance",
            color: Theme.of(context).colorScheme.onTertiary,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
            fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!),
        const SizedBox(
          height: 3,
        ),
        SplashText(
            title: "according to your lifestyle",
            color: Theme.of(context).colorScheme.onTertiary,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
            fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!),
        const SizedBox(height: 27),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularIndex(width: 30, height: 8, color: Theme.of(context).colorScheme.onSurface),
            const SizedBox(
              width: 5,
            ),
            CircularIndex(width: 9, height: 8, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(
              width: 5,
            ),
            CircularIndex(width: 9, height: 8, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ],
        )
      ],
    );
    if (widget.currentSplash == 1) {
      setState(() {
        currentWidget = Column(
          children: [
            SplashText(
              title: "Meet Our Specialist",
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
              fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight!,
            ),
            const SizedBox(
              height: 20,
            ),
            SplashText(
                title: "There are many other stylist",
                color: Theme.of(context).colorScheme.onTertiary,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!),
            const SizedBox(
              height: 3,
            ),
            SplashText(
                title: "from all the best salons ever",
                color: Theme.of(context).colorScheme.onTertiary,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!),
            const SizedBox(height: 27),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularIndex(width: 9, height: 8, color: Theme.of(context).colorScheme.onSurfaceVariant),
                const SizedBox(
                  width: 5,
                ),
                CircularIndex(width: 30, height: 8, color: Theme.of(context).colorScheme.onSurface),
                const SizedBox(
                  width: 5,
                ),
                CircularIndex(width: 9, height: 8, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ],
            )
          ],
        );
      });
    } else if (widget.currentSplash == 2) {
      currentWidget = Column(
        children: [
          SplashText(
            title: "Find The Best Service",
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
            fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight!,
          ),
          const SizedBox(
            height: 20,
          ),
          SplashText(
              title: "There are various services",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!),
          const SizedBox(
            height: 3,
          ),
          SplashText(
              title: "from the best salons",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!),
          const SizedBox(height: 27),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularIndex(width: 9, height: 8, color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(
                width: 5,
              ),
              CircularIndex(width: 9, height: 8, color: Theme.of(context).colorScheme.onSurfaceVariant),
              const SizedBox(
                width: 5,
              ),
              CircularIndex(width: 30, height: 8, color: Theme.of(context).colorScheme.onSurface)
            ],
          )
        ],
      );
    } else if (widget.currentSplash == 3) {
      currentWidget = Column(
        children: [
          SplashText(
            title: "Let's Join With Us",
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize!,
            fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight!,
          ),
          const SizedBox(
            height: 20,
          ),
          SplashText(
              title: "Find and book Beauty, salon, Barber",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.displaySmall?.fontWeight!),
          const SizedBox(
            height: 3,
          ),
          SplashText(
              title: "and Spa services anywhere, anytime.",
              color: Theme.of(context).colorScheme.onTertiary,
              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              fontWeight: Theme.of(context).textTheme.bodyLarge?.fontWeight!),
        ],
      );
    }
    return currentWidget;
  }
}
