import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/recent.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/recent.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/widget/card/slot.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/service/service_list_view.dart';
import 'package:logaluxe_users/widget/text_row.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  final searchTextController = TextEditingController();
  String activeView = 'grid';
  _changeView() {
    setState(() {
      activeView = activeView == 'grid' ? 'list' : 'grid';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchTextController.dispose();
  }

  _fetchSearchDetails(String searchQuery) async {
    try {
      var providerNotifier = ref.read(recentSearchProvider.notifier);
      List<UserModel> providerSearchResults = await providerNotifier.searchProvider(searchQuery, null);
      // if (providerSearchResults.isNotEmpty && searchQuery != '' && searchQuery.length > 3)
      //   providerNotifier.addRecentSearches(RecentSearch(content: searchQuery, key: ObjectKey(searchQuery)));
    } catch (e) {
      print(e.toString());
    }
  }

  _removeSearch(RecentSearch search) async {
    try {
      ref.read(recentSearchProvider.notifier).removeSearch(search);
    } catch (e) {
      print(e.toString());
    }
  }

  _clearSearchHistory() {
    ref.read(recentSearchProvider.notifier).clearSearchHistory();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    var searchHistory = ref.watch(recentSearchProvider);
    var defaultUsers = ref.watch(userProvider).serviceProviders;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
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
              iconColor: ref.watch(displayProvider).colorScheme.onTertiary,
              setIconPadding: true,
              iconPadding: 10,
              buttonBorder: 20,
              prefixIcon: false,
              prefixImage: true,
              controller: searchTextController,
              errorText: '',
              imageIcon: Image(
                image: AssetImage('images/search.png'),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RowText(
            rightText: "Clear all",
            leftText: "Recents",
            action: () {
              _clearSearchHistory();
            },
          ),
          SizedBox(
            height: 150,
            child: searchHistory.search.isEmpty
                ? Container(
                    height: 250,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            child: Image.asset(
                              'images/empty.png',
                              color: ref.watch(displayProvider).colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LogaText(
                              content: "No Recent Search",
                              color: ref.watch(displayProvider).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: searchHistory.search
                          .map(
                            (search) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _fetchSearchDetails(search.content);
                                    },
                                    child: LogaText(
                                      content: search.content,
                                      color: ref.watch(displayProvider).colorScheme.outline,
                                      fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                                      fontweight:
                                          Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _removeSearch(search);
                                    },
                                    child: Icon(Icons.close,
                                        color: ref.watch(displayProvider).colorScheme.outline),
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
          ),
          LogaText(
            content: "Service Providers",
            color: ref.watch(displayProvider).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
            fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
          ),
          SizedBox(
            height: 15,
          ),
          searchHistory.loadingState == true
              ? Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
                    ),
                  ),
                )
              : searchHistory.providers.isEmpty && defaultUsers.isEmpty
                  ? Container(
                      height: 250,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              child: Image.asset(
                                'images/empty.png',
                                color: ref.watch(displayProvider).colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LogaText(
                                content: "No Search History",
                                color: ref.watch(displayProvider).colorScheme.onSurface,
                                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                                fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight),
                          ],
                        ),
                      ),
                    )
                  : ServiceListView(
                      allUsers: searchHistory.providers.isEmpty ? defaultUsers : searchHistory.providers,
                    )
        ],
      ),
    );
  }
}
