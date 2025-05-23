import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/auth/profile.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/provider/like.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/screen/service-provider/view_provider.dart';

class ServiceGridView extends ConsumerWidget {
  final List<UserModel> allUsers;
  const ServiceGridView({super.key, required this.allUsers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _viewUser(UserModel user, bool liked) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ViewProvider(
              user: user,
              liked: liked,
            );
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
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisExtent: 353,
          mainAxisSpacing: 20,
        ),
        itemCount: allUsers.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _viewUser(allUsers[index], allLikes.any((like) => like.company_id == allUsers[index].id));
            },
            child: Container(
              decoration: BoxDecoration(
                color:
                    ref.watch(displayProvider).colorScheme.onTertiaryContainer.withAlpha((0.2 * 255).toInt()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: ref.watch(displayProvider).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: allUsers[index].image_url != ''
                            ? NetworkImage(allUsers[index].image_url!)
                            : AssetImage('images/home.png') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          top: 30,
                          bottom: 158,
                          right: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
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
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Text(
                                    "1.1km",
                                    style: TextStyle(
                                        color: ref.watch(displayProvider).colorScheme.onPrimary,
                                        fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                                        fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: ref.watch(displayProvider).isLightMode
                                      ? ref.watch(displayProvider).colorScheme.surface
                                      : ref.watch(displayProvider).colorScheme.onSurface,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: allLikes.any((like) => like.company_id == allUsers[index].id)
                                    ? InkWell(
                                        onTap: () {
                                          ref.read(likeProvider.notifier).saveLike(
                                              ref.watch(profileProvider).token,
                                              allUsers[index].id,
                                              ref.watch(profileProvider).id);
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
                                                ref.watch(profileProvider).token,
                                                allUsers[index].id,
                                                ref.watch(profileProvider).id);
                                        },
                                        child: Icon(
                                          Icons.favorite_border,
                                          size: 25,
                                          color: ref.watch(displayProvider).colorScheme.onPrimary,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90,
                              child: Text(
                                "Hair . Facial . Nail 2+",
                                maxLines: 1, // Limits text to 2 lines
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  wordSpacing: 2,
                                  color: ref.watch(displayProvider).colorScheme.onPrimary,
                                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 15,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "4.7(2.7)",
                              maxLines: 1, // Limits text to 2 lines
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                wordSpacing: 2,
                                color: ref.watch(displayProvider).colorScheme.outline,
                                fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
                                //fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                        child: Text(
                          allUsers[index].business_name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: ref.watch(displayProvider).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 3),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: ref.watch(displayProvider).colorScheme.outline,
                                //color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                allUsers[index].business_address,
                                maxLines: 2, // Limits text to 2 lines
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ref.watch(displayProvider).colorScheme.outline,
                                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: ref.watch(displayProvider).colorScheme.outline,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                "open ${allUsers[index].opening_time}am - ${allUsers[index].closing_time}pm",
                                maxLines: 2, // Limits text to 2 lines
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: ref.watch(displayProvider).colorScheme.outline,
                                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
