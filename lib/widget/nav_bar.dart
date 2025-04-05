import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/display.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  int activeIndex;
  final int currentIndex;
  Function getActiveIndex;
  CustomBottomNavigationBar(
      {super.key, required this.activeIndex, required this.currentIndex, required this.getActiveIndex});

  @override
  ConsumerState<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends ConsumerState<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _switchIndex(int active) {
      int prevIndex = widget.activeIndex;
      setState(() {
        widget.activeIndex = active;
        widget.getActiveIndex(active, prevIndex);
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => _switchIndex(0),
            child: widget.activeIndex == 0
                ? Container(
                    height: 50,
                    width: 114,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outline.withAlpha((0.2 * 255).toInt()),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Image(
                              image: AssetImage('images/home_icon.png'),
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Home",
                            style: TextStyle(
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Image(
                    image: AssetImage('images/home_icon.png'),
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.onSurface,
                  ),
          ),
          GestureDetector(
            onTap: () => _switchIndex(1),
            child: widget.activeIndex == 1
                ? Container(
                    height: 50,
                    width: 123,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Image(
                              image: AssetImage('images/search.png'),
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Explore",
                            style: TextStyle(
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Image(
                    image: AssetImage('images/search.png'),
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.onSurface,
                  ),
          ),
          GestureDetector(
            onTap: () => _switchIndex(2),
            child: widget.activeIndex == 2
                ? Container(
                    height: 50,
                    width: 133,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Image(
                              image: AssetImage('images/menu.png'),
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "History",
                            style: TextStyle(
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Image(
                    image: AssetImage('images/menu.png'),
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.onSurface,
                  ),
          ),
          GestureDetector(
            onTap: () => _switchIndex(3),
            child: widget.activeIndex == 3
                ? Container(
                    height: 50,
                    width: 133,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13),
                            child: Image(
                              image: AssetImage('images/more.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Settings",
                            style: TextStyle(
                              color: ref.watch(displayProvider).isLightMode
                                  ? ref.watch(displayProvider).colorScheme.surface
                                  : ref.watch(displayProvider).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Image(
                    image: AssetImage('images/more.png'),
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.onSurface,
                  ),
          ),
        ],
      ),
    );
  }
}
