import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/user.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  ConsumerState<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends ConsumerState<CustomBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  late int activeIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    var allUsers = ref.watch(userNotifier);

    _switchIndex(int active) {
      setState(() {
        activeIndex = active;
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          activeIndex == 0
              ? GestureDetector(
                  onTap: _switchIndex(0),
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.onError,
                          child: Icon(
                            Icons.home,
                            size: 35,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Icon(
                  Icons.home,
                  size: 35,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          Icon(
            Icons.search,
            size: 35,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Icon(
            Icons.event_note,
            size: 35,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Icon(
            Icons.more_horiz,
            size: 35,
            color: Theme.of(context).colorScheme.onSurface,
          )
        ],
      ),
    );
  }
}
