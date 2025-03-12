import 'package:flutter/material.dart';
import 'package:logaluxe_users/widget/category.dart';
import 'package:logaluxe_users/widget/input-field/loga_input.dart';
import 'package:logaluxe_users/widget/service/service_grid_view.dart';
import 'package:logaluxe_users/widget/service/service_list_view.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final searchTextController = TextEditingController();
  int currentIndex = 0;
  String activeView = 'grid';
  _changeView() {
    setState(() {
      activeView = activeView == 'grid' ? 'list' : 'grid';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
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
              color: Theme.of(context).colorScheme.onSurface,
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
                        Theme.of(context).colorScheme.background,
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
                    color: Theme.of(context).colorScheme.onSurface,
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
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize!,
                    ),
                  )),
              Positioned.fill(
                top: 97,
                left: 20,
                child: Text(
                  "on All Haircuts Between 9-10 AM.",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
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
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.onSurface,
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                      fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
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
          color: Theme.of(context).colorScheme.onInverseSurface,
          thickness: 1,
        ),
        Text(
          "Categories",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize!,
          ),
        ),
        SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: CategoryRowScroll(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Salon",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View all",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
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
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                padding: const EdgeInsets.only(left: 7),
                minimumSize: const Size(0, 0),
                fixedSize: const Size(130, 33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Text(
                    "Recommended",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                      fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Theme.of(context).colorScheme.background,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                padding: const EdgeInsets.all(0),
                minimumSize: const Size(0, 0),
                fixedSize: const Size(30, 33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {},
              child: Icon(
                Icons.filter_list,
                color: Theme.of(context).colorScheme.background,
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
                color: Theme.of(context).colorScheme.onTertiary,
                size: 30,
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        activeView == "grid" ? ServiceGridView() : ServiceListView(),
      ],
    );
  }
}
