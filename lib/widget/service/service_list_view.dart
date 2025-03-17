import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
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

    return Container(
      child: GridView.builder(
        shrinkWrap: true, // ✅ Prevents GridView from taking infinite height
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 20,
          mainAxisExtent: 150,
          mainAxisSpacing: 30,
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
                    height: 150,
                    width: 150,
                    child: Stack(children: []),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 130,
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
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "4.7(2.7)",
                              maxLines: 1, // Limits text to 2 lines
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                wordSpacing: 2,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
                                fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 170,
                          child: LogaText(
                            content: allUsers[index].business_name,
                            setMaxLine: true,
                            maxLines: 1,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                            fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              //color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 120,
                              child: Text(
                                allUsers[index].business_address,
                                maxLines: 2, // Limits text to 2 lines
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${allUsers[index].opening_time} - ${allUsers[index].closing_time}",
                              maxLines: 2, // Limits text to 2 lines
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurface,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                            SizedBox(
                              width: 80,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurface,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 25,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
