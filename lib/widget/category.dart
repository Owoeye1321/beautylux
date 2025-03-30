import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/category.dart';
import 'package:logaluxe_users/model/user.dart';
import 'package:logaluxe_users/provider/category.dart';
import 'package:logaluxe_users/provider/service.dart';
import 'package:logaluxe_users/provider/display.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class CategoryRowScroll extends ConsumerStatefulWidget {
  UserModel? user;
  CategoryRowScroll({super.key, this.user});
  @override
  ConsumerState<CategoryRowScroll> createState() => _CategoryRowScroll();
}

class _CategoryRowScroll extends ConsumerState<CategoryRowScroll> {
  bool loadingState = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    var categoryNotier = await ref.read(categoryProvider.notifier);
    var fetchCategories = await categoryNotier.fetchCategory();
    if (!fetchCategories.data.isEmpty) {
      categoryNotier.setActiveCategory(fetchCategories.data[0]);
      fetchProviderCategoryService();
    }
  }

  _setActiveCategory(CategoryModel category) {
    ref.read(categoryProvider.notifier).setActiveCategory(category);
    fetchProviderCategoryService();
  }

  fetchProviderCategoryService() async {
    if (widget.user != null) {
      ref.read(serviceProvider.notifier).resetServices();
      String companyId = widget.user!.company_id as String;
      String category_id = ref.read(categoryProvider).activeCategory!.id!;
      ServiceProviderModel response =
          await ref.read(serviceProvider.notifier).fetchServices(category_id, companyId);
    }
  }

  @override
  Widget build(BuildContext context) {
    var categoryNotier = ref.watch(categoryProvider);
    var activeCategory = categoryNotier.activeCategory;
    var allCategories = categoryNotier.data;
    if (!allCategories.isEmpty) {
      setState(() {
        loadingState = false;
      });
    }
    return loadingState == true
        ? CircularProgressIndicator.adaptive(
            backgroundColor: ref.watch(displayProvider).colorScheme.onSurface,
          )
        : Row(
            children: allCategories.map(
              (category) {
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ElevatedButton(
                    onPressed: () {
                      return _setActiveCategory(category);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: 150,
                      child: LogaText(
                          content: category.category_name,
                          color: ref.watch(displayProvider).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight! as FontWeight),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: activeCategory?.id! == category.id
                          ? ref.watch(displayProvider).colorScheme.onPrimary
                          : Colors.transparent,
                      minimumSize: const Size(0, 0),
                      fixedSize: Size(117, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                  ),
                );
              },
            ).toList(),
          );
  }
}
