import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/provider/like.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/screen/service-provider/view_provider.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class ServiceListView extends ConsumerWidget {
  List<UserModel> allUsers;
  ServiceListView({super.key, required this.allUsers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _viewUser(UserModel user) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ViewProvider(user: user);
          },
        ),
      );
    }

    var allLikes = ref.watch(likeProvider);

    return Container(
      child: GridView.builder(
        shrinkWrap: true, // ✅ Prevents GridView from taking infinite height
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 20,
          mainAxisExtent: 155,
          mainAxisSpacing: 15,
        ),
        itemCount: allUsers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _viewUser(allUsers[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onTertiaryContainer.withAlpha((0.2 * 255).toInt()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: allUsers[index].image_url != null
                            ? NetworkImage(allUsers[index].image_url!)
                            : AssetImage('images/home.png') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: double.infinity,
                    width: 150,
                    child: Stack(children: []),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 5, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Text(
                                  "Hair . Facial . 2+",
                                  maxLines: 1, // Limits text to 2 lines
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    wordSpacing: 2,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
                                    fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  LogaText(
                                    content: "4.7(2.7)",
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: Theme.of(context).textTheme.displaySmall?.fontSize! as double,
                                    fontweight:
                                        Theme.of(context).textTheme.bodyMedium?.fontWeight! as FontWeight,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 155,
                            child: LogaText(
                              content: allUsers[index].business_name,
                              setMaxLine: true,
                              maxLines: 1,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 6),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Theme.of(context).colorScheme.outline,
                                  //color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 4),
                                width: 115,
                                child: Text(
                                  allUsers[index].business_address,
                                  maxLines: 2, // Limits text to 2 lines
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: Theme.of(context).colorScheme.outline,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "open ${allUsers[index].opening_time}am - ${allUsers[index].closing_time}pm",
                                maxLines: 2, // Limits text to 2 lines
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                //width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ref.watch(displayProvider).isLightMode
                                      ? ref.watch(displayProvider).colorScheme.surface
                                      : ref.watch(displayProvider).colorScheme.onSurface,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  child: Text(
                                    "1.1km",
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                                      fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 80,
                              // ),
                              Container(
                                height: 30,
                                //width: 32,
                                decoration: BoxDecoration(
                                  color: ref.watch(displayProvider).isLightMode
                                      ? ref.watch(displayProvider).colorScheme.surface
                                      : ref.watch(displayProvider).colorScheme.onSurface,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                                  child: allLikes.any((like) => like.company_id == allUsers[index].id)
                                      ? InkWell(
                                          onTap: () {
                                            ref.read(likeProvider.notifier).saveLike(
                                                ref.watch(profileProvider).token, allUsers[index].id);
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            size: 25,
                                            color: ref.watch(displayProvider).colorScheme.onPrimary,
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            if (ref.watch(profileProvider).token != '')
                                              ref.read(likeProvider.notifier).saveLike(
                                                  ref.watch(profileProvider).token, allUsers[index].id);
                                          },
                                          child: Icon(
                                            Icons.favorite_border,
                                            size: 25,
                                            color: ref.watch(displayProvider).colorScheme.onPrimary,
                                          ),
                                        ),
                                ),
                              ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
