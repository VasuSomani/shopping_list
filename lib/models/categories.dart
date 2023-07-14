import 'dart:ui';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class GrocerryCategory {
  GrocerryCategory(this.title, this.color);
  final String title;
  final Color color;
}
