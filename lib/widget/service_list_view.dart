import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/provider/user.dart';

class ServiceListView extends ConsumerWidget {
  const ServiceListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allUsers = ref.watch(userNotifier);
    return Container(
      child: GridView.builder(
        shrinkWrap: true, // ✅ Prevents GridView from taking infinite height
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 20,
          mainAxisExtent: 180,
          mainAxisSpacing: 30,
        ),
        itemCount: allUsers.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onTertiaryContainer.withOpacity(0.2),
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
                      fit: BoxFit.fill,
                    ),
                  ),
                  height: 180,
                  width: 180,
                  child: Stack(children: []),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hair . Facial . Nail 2+",
                            maxLines: 1, // Limits text to 2 lines
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              wordSpacing: 2,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "4.7(2.7)",
                            maxLines: 1, // Limits text to 2 lines
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              wordSpacing: 2,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                              fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        allUsers[index].business_name,
                        maxLines: 2, // Limits text to 2 lines
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: Theme.of(context).textTheme.titleMedium?.fontSize!,
                            fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight),
                      ),
                      SizedBox(height: 10),
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
                          Text(
                            allUsers[index].business_address,
                            maxLines: 2, // Limits text to 2 lines
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                              fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                              child: Text(
                                "1.1km",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize!,
                                  fontWeight: Theme.of(context).textTheme.titleMedium?.fontWeight!,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Container(
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
          );
        },
      ),
    );
  }
}
