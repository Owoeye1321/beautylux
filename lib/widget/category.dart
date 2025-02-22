import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logaluxe_users/model/category.dart';
import 'package:logaluxe_users/provider/category.dart';

class CategoryRowScroll extends ConsumerStatefulWidget {
  const CategoryRowScroll({super.key});
  @override
  ConsumerState<CategoryRowScroll> createState() => _CategoryRowScroll();
}

class _CategoryRowScroll extends ConsumerState<CategoryRowScroll> {
  late CategoryModel activeCategory;
  bool loadingState = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activeCategory = ref.read(categoryNotifier)[0];
  }

  _setActiveCategory(CategoryModel cateogory) {
    setState(() {
      activeCategory = cateogory;
    });
  }

  @override
  Widget build(BuildContext context) {
    var allCategories = ref.watch(categoryNotifier);
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ElevatedButton(
                    onPressed: () {
                      return _setActiveCategory(category);
                    },
                    child: Text(
                      category.category_name,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: activeCategory.id == category.id
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
