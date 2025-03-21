import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/service.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/category.dart';
import 'package:logaluxe_users/provider/service.dart';
import 'package:logaluxe_users/widget/category.dart';
import 'package:logaluxe_users/widget/service-provider/about_content.dart';
import 'package:logaluxe_users/widget/service-provider/provider_profile_features.dart';
import 'package:logaluxe_users/widget/service-provider/provider_profile_tabs.dart';
import 'package:logaluxe_users/widget/service-provider/services_purchase_list.dart';

class ProviderProfile extends ConsumerStatefulWidget {
  final UserModel user;
  const ProviderProfile({super.key, required this.user});

  @override
  ConsumerState<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends ConsumerState<ProviderProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<ServiceModel> allServices = [];
  int currentIndex = 0;
  void _getCurrentIndex(int activeIndex) {
    setState(() {
      currentIndex = activeIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.user.business_name,
              maxLines: 2, // Limits text to 2 lines
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.user.business_address,
              maxLines: 2, // Limits text to 2 lines
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Theme.of(context).colorScheme.outline,
                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${widget.user.opening_time}am - ${widget.user.closing_time}pm",
                          maxLines: 2, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "-58%",
                          maxLines: 1, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 2,
                            decoration: TextDecoration.none,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(6 packs available)",
                          maxLines: 1, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 2,
                            decoration: TextDecoration.none,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 25,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "4.7(2.7k)",
                          maxLines: 1, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 2,
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 65),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Theme.of(context).colorScheme.outline,
                            size: 25,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "10K views",
                            maxLines: 1, // Limits text to 2 lines
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              wordSpacing: 2,
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ProfileMenu(user: widget.user),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            ),
            ServiceProviderTabs(
              getCurrentIndex: _getCurrentIndex,
            ),
            SizedBox(
              height: 15,
            ),
            currentIndex == 0
                ? Container(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: CategoryRowScroll(
                            user: widget.user,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        SizedBox(
                          height: 300,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ServicePurchaseList(),
                          ),
                        )
                      ],
                    ),
                  )
                : currentIndex == 1
                    ? SizedBox(height: 320, child: AboutProvider(user: widget.user))
                    : currentIndex == 2
                        ? Container()
                        : Container(),
          ],
        ),
      ),
    );
  }
}
