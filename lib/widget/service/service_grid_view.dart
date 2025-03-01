import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/screen/service-provider/view_provider.dart';

class ServiceGridView extends ConsumerWidget {
  const ServiceGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allUsers = ref.watch(userProvider);
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
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisExtent: 353,
          mainAxisSpacing: 20,
        ),
        itemCount: allUsers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _viewUser(allUsers[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
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
                    child: Stack(
                      children: [
                        Positioned.fill(
                          top: 30,
                          left: 145,
                          bottom: 155,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.favorite_border,
                              size: 30,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          top: 30,
                          bottom: 155,
                          right: 110,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
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
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                                    fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Hair . Facial . Nail 2+",
                          maxLines: 1, // Limits text to 2 lines
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
                            //fontWeight: Theme.of(context).textTheme.bodySmall?.fontWeight!,
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
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: Theme.of(context).textTheme.displaySmall?.fontSize!,
                            //fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      allUsers[index].business_name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize!,
                        fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
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
                        Expanded(
                          child: Text(
                            allUsers[index].business_address,
                            maxLines: 2, // Limits text to 2 lines
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
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
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            "${allUsers[index].opening_time} - ${allUsers[index].closing_time}",
                            maxLines: 2, // Limits text to 2 lines
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            ),
                          ),
                        ),
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
