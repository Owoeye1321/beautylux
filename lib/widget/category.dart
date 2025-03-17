import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/category.dart';
import 'package:logaluxe_users/provider/category.dart';
import 'package:logaluxe_users/widget/loga_text.dart';

class CategoryRowScroll extends ConsumerStatefulWidget {
  const CategoryRowScroll({super.key});
  @override
  ConsumerState<CategoryRowScroll> createState() => _CategoryRowScroll();
}

class _CategoryRowScroll extends ConsumerState<CategoryRowScroll> {
  List<CategoryModel> allCategories = [];
  bool loadingState = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  fetchCategories() async {
    var categoryProvider = await ref.read(categoryNotifier.notifier);
    var fetchCategories = await categoryProvider.fetchCategory();
    if (!fetchCategories.data.isEmpty) {
      categoryProvider.setActiveCategory(fetchCategories.data[0]);
      setState(() {
        allCategories = fetchCategories.data;
      });
    }
  }

  _setActiveCategory(CategoryModel category) {
    setState(() {
      ref.read(categoryNotifier.notifier).setActiveCategory(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    var activeCategory = ref.watch(categoryNotifier).activeCategory;
    if (!allCategories.isEmpty) {
      setState(() {
        loadingState = false;
      });
    }
    return loadingState == true
        ? CircularProgressIndicator.adaptive(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
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
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize as double,
                          fontweight: Theme.of(context).textTheme.bodyMedium?.fontWeight! as FontWeight),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: activeCategory?.id! == category.id
                          ? Theme.of(context).colorScheme.onPrimary
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
