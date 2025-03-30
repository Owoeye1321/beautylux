import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/recent.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/widget/card/slot.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
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
  Widget build(
    BuildContext context,
  ) {
    var allSearches = ref.watch(recentSearchProvider);
    var allUsers = ref.watch(userProvider).serviceProviders;
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
              hintText: "Enter address or city name",
              verticalPadding: 15,
              horizontalPadding: 10,
              alterVisibility: false,
              hideTextInput: false,
              prefixIconData: Icons.search,
              setIconSize: true,
              iconSize: 40,
              setIconColor: true,
              iconColor: Theme.of(context).colorScheme.onTertiary,
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
          RowText(rightText: "Clear all", leftText: "Recents", action: () {}),
          SizedBox(
            height: 150,
            child: SingleChildScrollView(
              child: Column(
                children: allSearches
                    .map((search) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LogaText(
                                content: search.content,
                                color: Theme.of(context).colorScheme.outline,
                                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                                fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.close, color: Theme.of(context).colorScheme.outline),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // SizedBox(
          //   height: 140,
          //   child: GridView.builder(
          //     padding: EdgeInsets.all(0),
          //     physics: ScrollPhysics(),
          //     // physics: NeverScrollableScrollPhysics(),
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 3,
          //       mainAxisExtent: 40,
          //       mainAxisSpacing: 20,
          //       crossAxisSpacing: 10,
          //     ),
          //     itemCount: allSearches.length,
          //     itemBuilder: (context, index) =>
          //        // TimeSlot(content: allSearches[index].content, slot_ref: allSearches[index].content),
          //   ),
          // ),
          SizedBox(
            height: 30,
          ),
          LogaText(
            content: "Suggestions for you",
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
            fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
          ),
          SizedBox(
            height: 15,
          ),
          ServiceListView(
            allUsers: allUsers,
          )
        ],
      ),
    );
  }
}
