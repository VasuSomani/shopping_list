import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../category_list.dart';
import '../models/categories.dart';

class CategoryNotifier extends StateNotifier<GroceryCategory?> {
  CategoryNotifier() : super(categoriesList[0]);

  void changeCategory(GroceryCategory? newCategory) {
    state = newCategory;
  }

  GroceryCategory? returnCategory() {
    return state;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, GroceryCategory?>(
        (ref) => CategoryNotifier());
