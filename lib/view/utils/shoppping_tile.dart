import 'package:flutter/material.dart';
import 'package:shopping_list/models/categories.dart';

class ShoppingTile extends StatelessWidget {
  const ShoppingTile({
    Key? key,
    required this.category,
    required this.title,
    required this.quantity,
  }) : super(key: key);

  final GrocerryCategory? category;
  final String title;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 20)),
      leading: Container(
        color: category!.color,
        height: 25,
        width: 25,
      ),
      trailing: Text(
        quantity.toString(),
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
