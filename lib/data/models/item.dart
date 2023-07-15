import 'dart:convert';
import 'categories.dart';

class Item {
  final String id;
  final String name;
  final int quantity;
  final GroceryCategory? category;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  toJson() {
    return json.encode({
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': category?.title
    });
  }
}
