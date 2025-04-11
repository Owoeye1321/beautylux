import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/recent.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/recent.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/screen/pages/search.dart';
import 'package:logaluxe_users/widget/category.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/service/service_grid_view.dart';
import 'package:logaluxe_users/widget/service/service_list_view.dart';

class MarketPlace extends ConsumerStatefulWidget {
  Function() bookNow;
  Function viewHistory;
  MarketPlace({super.key, required this.bookNow, required this.viewHistory});

  @override
  ConsumerState<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends ConsumerState<MarketPlace> {
  List<UserModel> allUsers = [];
  String order = 'default';
  bool loadingState = true;
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  final searchTextController = TextEditingController();
  int currentIndex = 0;
  String activeView = 'grid';
  _changeView() {
    setState(() {
      activeView = activeView == 'grid' ? 'list' : 'grid';
    });
  }

  fetchUsers() async {
    var users = await ref.read(userProvider.notifier).getServiceProviders();
    if (mounted)
      setState(() {
        allUsers = users.serviceProviders;
      });
  }

  _fetchSearchDetails(String searchQuery) async {
    try {
      var providerNotifier = ref.read(recentSearchProvider.notifier);
      List<UserModel> providerSearchResults = await providerNotifier.searchProvider(searchQuery, null);
      //if (providerSearchResults.isNotEmpty && searchQuery != '' && searchQuery.length > 3)
      // providerNotifier.addRecentSearches(RecentSearch(content: searchQuery, key: ObjectKey(searchQuery)));
      widget.viewHistory(0, 1);
    } catch (e) {
      print(e.toString());
    }
  }

  _filterUsers() {
    ref.read(userProvider.notifier).filterUsers();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!allUsers.isEmpty) {
      setState(() {
        loadingState = false;
      });
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
          child: LogaInputField(
            onChange: (value) {
              _fetchSearchDetails(value);
            },
            hintText: "Enter address or city name",
            verticalPadding: 15,
            horizontalPadding: 10,
            alterVisibility: false,
            hideTextInput: false,
            prefixIconData: Icons.search,
            setIconSize: true,
            iconSize: 40,
            setIconColor: true,
            iconColor: ref.watch(displayProvider).isLightMode
                ? ref.watch(displayProvider).colorScheme.surface
                : ref.watch(displayProvider).colorScheme.onSurface,
            setIconPadding: true,
            iconPadding: 10,
            buttonBorder: 20,
            prefixIcon: false,
            prefixImage: true,
            controller: searchTextController,
            errorText: '',
            imageIcon: Image(
              image: AssetImage('images/search.png'),
              color: ref.watch(displayProvider).isLightMode
                  ? ref.watch(displayProvider).colorScheme.surface
                  : ref.watch(displayProvider).colorScheme.onSurface,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/home.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ref.watch(displayProvider).isLightMode
                            ? ref.watch(displayProvider).colorScheme.onSurface
                            : ref.watch(displayProvider).colorScheme.surface,
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              Positioned.fill(
                left: 20,
                top: 20,
                child: Text(
                  "Morning Special!",
                  style: TextStyle(
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize!,
                  ),
                ),
              ),
              Positioned.fill(
                  top: 45,
                  left: 20,
                  child: Text(
                    "Get 20% off",
                    style: TextStyle(
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize!,
                    ),
                  )),
              Positioned.fill(
                top: 97,
                left: 20,
                child: Text(
                  "on All Haircuts Between 9-10 AM.",
                  style: TextStyle(
                    color: ref.watch(displayProvider).isLightMode
                        ? ref.watch(displayProvider).colorScheme.surface
                        : ref.watch(displayProvider).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                    // fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                  ),
                ),
              ),
              Positioned.fill(
                top: 125,
                left: 20,
                right: 255,
                bottom: 20,
                child: GestureDetector(
                  onTap: () {
                    widget.bookNow;
                    widget.viewHistory(0, 1);
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ref.watch(displayProvider).isLightMode
                          ? ref.watch(displayProvider).colorScheme.surface
                          : ref.watch(displayProvider).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: ref.watch(displayProvider).isLightMode
                            ? ref.watch(displayProvider).colorScheme.onSurface
                            : ref.watch(displayProvider).colorScheme.surface,
                        fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                        fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: ref.watch(displayProvider).colorScheme.onInverseSurface,
          thickness: 1,
        ),
        Text(
          "Categories",
          style: TextStyle(
            color: ref.watch(displayProvider).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize!,
          ),
        ),
        SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: CategoryRowScroll(),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Salon",
              style: TextStyle(
                color: ref.watch(displayProvider).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              ),
            ),
            TextButton(
              onPressed: () => widget.viewHistory(0, 1),
              child: Text(
                "View all",
                style: TextStyle(
                  color: ref.watch(displayProvider).colorScheme.onPrimary,
                  fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
                padding: const EdgeInsets.only(left: 7),
                minimumSize: const Size(0, 0),
                fixedSize: const Size(130, 33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                _filterUsers();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ref.watch(userProvider).order == 'default'
                        ? "Recommended"
                        : ref.watch(userProvider).order == "asc"
                            ? "Ascending"
                            : "Descending",
                    style: TextStyle(
                      color: ref.watch(displayProvider).colorScheme.surface,
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                      fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: ref.watch(displayProvider).colorScheme.surface,
                    size: 15,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
                padding: const EdgeInsets.all(0),
                minimumSize: const Size(0, 0),
                fixedSize: const Size(30, 33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                _filterUsers();
              },
              child: order == 'default'
                  ? Icon(
                      Icons.filter_list,
                      color: ref.watch(displayProvider).colorScheme.surface,
                      size: 15,
                    )
                  : Icon(
                      Icons.sort_by_alpha,
                      color: ref.watch(displayProvider).colorScheme.surface,
                      size: 15,
                    ),
            ),
            SizedBox(
              width: 150,
            ),
            GestureDetector(
              onTap: _changeView,
              child: Icon(
                activeView == "grid" ? Icons.view_agenda_outlined : Icons.grid_view,
                color: ref.watch(displayProvider).colorScheme.onTertiary,
                size: 30,
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        ref.watch(userProvider).loadingState == true || ref.watch(recentSearchProvider).loadingState == true
            ? Container(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
                  ),
                ),
              )
            : activeView == "grid"
                ? ServiceGridView(
                    allUsers: ref.watch(userProvider).serviceProviders,
                  )
                : ServiceListView(
                    allUsers: ref.watch(userProvider).serviceProviders,
                  ),
      ],
    );
  }
}
