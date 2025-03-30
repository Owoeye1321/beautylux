import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/gallery.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/provider/user.dart';
import 'package:logaluxe_users/widget/loga_text.dart';
import 'package:logaluxe_users/widget/staff_container.dart';

class AboutProvider extends ConsumerWidget {
  final UserModel user;
  const AboutProvider({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allGalary = ref.watch(galleryProvider);
    var allStaffs = ref.watch(userProvider).staffs;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: ref.watch(displayProvider).colorScheme.onInverseSurface.withAlpha((0.5 * 255).toInt()),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogaText(
                    content: "About",
                    color: ref.watch(displayProvider).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize! as double,
                    fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                  ),
                  SizedBox(height: 20),
                  LogaText(
                    content: user.bio,
                    setMaxLine: true,
                    maxLines: 10,
                    color: ref.watch(displayProvider).colorScheme.outline,
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
              color: ref.watch(displayProvider).colorScheme.onInverseSurface.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LogaText(
                    content: "Opening Hours",
                    color: ref.watch(displayProvider).colorScheme.onSurface,
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
                            color: ref.watch(displayProvider).colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ref.watch(displayProvider).colorScheme.onPrimary,
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
                              color: ref.watch(displayProvider).colorScheme.outline,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LogaText(
                              content: "open ${user.opening_time}am - close ${user.closing_time}pm",
                              color: ref.watch(displayProvider).colorScheme.onSurface,
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
                            color: ref.watch(displayProvider).colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ref.watch(displayProvider).colorScheme.onPrimary,
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
                              color: ref.watch(displayProvider).colorScheme.outline,
                              fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize as double,
                              fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            LogaText(
                              content: "open ${user.opening_time}am - close${user.closing_time}pm",
                              color: ref.watch(displayProvider).colorScheme.onSurface,
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
                  color: ref.watch(displayProvider).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
                  fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                ),
                GestureDetector(
                  onTap: () {},
                  child: LogaText(
                    content: "View All",
                    color: ref.watch(displayProvider).colorScheme.onPrimary,
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
                  color: ref.watch(displayProvider).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize as double,
                  fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight as FontWeight,
                ),
                GestureDetector(
                  onTap: () {},
                  child: LogaText(
                    content: "View All",
                    color: ref.watch(displayProvider).colorScheme.onPrimary,
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
            height: 270,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: allStaffs.map(
                    (eachStaff) {
                      return StaffContainer(staff: eachStaff);
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
