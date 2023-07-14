import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/category_list.dart';
import 'package:shopping_list/models/categories.dart';

class CategoryNotifier extends StateNotifier<GrocerryCategory?> {
  CategoryNotifier() : super(categoriesList[0]);

  void changeCategory(GrocerryCategory? newCategory) {
    state = newCategory;
  }

  GrocerryCategory? returnCategory() {
    return state;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, GrocerryCategory?>(
        (ref) => CategoryNotifier());
