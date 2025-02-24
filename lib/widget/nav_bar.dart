import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/screen/home.dart';

import '../provider/user.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  int activeIndex;
  final int currentIndex;
  CustomBottomNavigationBar({super.key, required this.activeIndex, required this.currentIndex});

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
    var allUsers = ref.watch(userNotifier);

    _switchIndex(int active) {
      setState(() {
        widget.activeIndex = active;
        if (active == widget.currentIndex) return;
        if (active == 0) Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
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
                    width: 110,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage('images/home_icon.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Home",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Image(
                    image: AssetImage('images/home_icon.png'),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
          ),
          GestureDetector(
            onTap: () => _switchIndex(1),
            child: widget.activeIndex == 1
                ? Container(
                    height: 50,
                    width: 120,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage('images/search.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Explore",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Image(
                    image: AssetImage('images/search.png'),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
          ),
          GestureDetector(
            onTap: () => _switchIndex(2),
            child: widget.activeIndex == 2
                ? Container(
                    height: 50,
                    width: 130,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              image: AssetImage('images/menu.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            "Booking",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Image(
                    image: AssetImage('images/menu.png'),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
          ),
          GestureDetector(
            onTap: () => _switchIndex(3),
            child: widget.activeIndex == 3
                ? Container(
                    height: 50,
                    width: 130,
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
                            padding: const EdgeInsets.all(8.0),
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
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Image(
                    image: AssetImage('images/more.png'),
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
          ),
        ],
      ),
    );
  }
}
