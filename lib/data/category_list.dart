import 'package:flutter/material.dart';

import '../models/categories.dart';

Map<Categories, GrocerryCategory> categoriesList = {
  Categories.vegetables: GrocerryCategory(
    'Vegetables',
    const Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: GrocerryCategory(
    'Fruit',
    const Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: GrocerryCategory(
    'Meat',
    const Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: GrocerryCategory(
    'Dairy',
    const Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: GrocerryCategory(
    'Carbs',
    const Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: GrocerryCategory(
    'Sweets',
    const Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: GrocerryCategory(
    'Spices',
    const Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: GrocerryCategory(
    'Convenience',
    const Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: GrocerryCategory(
    'Hygiene',
    const Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: GrocerryCategory(
    'Other',
    const Color.fromARGB(255, 0, 225, 255),
  ),
};
