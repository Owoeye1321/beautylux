import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/gallery.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class AboutProvider extends ConsumerWidget {
  final UserModel user;
  const AboutProvider({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allGalary = ref.watch(galleryProvider);
    var allStaffs = ref.watch(userProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogaText(
                    content: "About",
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                  ),
                  SizedBox(height: 20),
                  LogaText(
                    content: user.bio,
                    setMaxLine: true,
                    maxLines: 10,
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodySmall?.fontWeight as FontWeight,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogaText(
                    content: "Opening Hours",
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LogaText(
                              content: "Monday - Friday",
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LogaText(
                              content: "${user.opening_time} - ${user.closing_time}",
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LogaText(
                              content: "Saturday - Sunday",
                              color: Theme.of(context).colorScheme.outline,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LogaText(
                              content: "${user.opening_time} - ${user.closing_time}",
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogaText(
                  content: "Gallery",
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
                  fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                ),
                GestureDetector(
                  onTap: () {},
                  child: LogaText(
                    content: "View All",
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                    fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 150,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: allGalary.map(
                    (eachImage) {
                      return Container(
                        height: 150,
                        width: 150,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(eachImage.image_url),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 55,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogaText(
                  content: "Our Specialists",
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
                  fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                ),
                GestureDetector(
                  onTap: () {},
                  child: LogaText(
                    content: "View All",
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                    fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 250,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: allStaffs.map(
                    (eachStaff) {
                      return Container(
                        height: double.infinity,
                        width: 170,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: eachStaff.image_url != null
                                        ? NetworkImage(eachStaff.image_url!)
                                        : AssetImage("images/dp.jpeg") as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              LogaText(
                                content: "${eachStaff.first_name} ${eachStaff.last_name}",
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                                fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight! as FontWeight,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: Theme.of(context).colorScheme.outline,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  LogaText(
                                    content: "4.7",
                                    color: Theme.of(context).colorScheme.outline,
                                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize! as double,
                                    fontweight:
                                        Theme.of(context).textTheme.bodyMedium?.fontWeight! as FontWeight,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
