import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/category_list.dart';
import 'package:shopping_list/models/categories.dart';

import '../models/provider/state_notifier.dart';

class NameField extends StatelessWidget {
  const NameField(this.controller, {Key? key}) : super(key: key);
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty || value.trim() == "") {
          return "Item Name can't be empty";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Item Name",
          labelStyle: TextStyle(fontSize: 25),
          floatingLabelBehavior: FloatingLabelBehavior.always),
      style: const TextStyle(fontSize: 20),
      maxLength: 50,
      controller: controller,
      cursorHeight: 20,
    );
  }
}

class QuantityField extends StatelessWidget {
  const QuantityField(this.controller, {Key? key}) : super(key: key);
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value.trim() == "" ||
            int.tryParse(value)! <= 0) {
          return "Item Name can't be empty";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Item Quantity",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(fontSize: 25),
      ),
      style: const TextStyle(fontSize: 20),
      controller: controller,
      cursorHeight: 20,
      keyboardType: TextInputType.number,
    );
  }
}

class CategoryField extends ConsumerStatefulWidget {
  const CategoryField({Key? key}) : super(key: key);

  @override
  _CategoryFieldState createState() => _CategoryFieldState();
}

class _CategoryFieldState extends ConsumerState<CategoryField> {
  GrocerryCategory? _selectedCategory = categoriesList[0];
  List<DropdownMenuItem<GrocerryCategory>> dropDownList = categoriesList.entries
      .map((e) => DropdownMenuItem<GrocerryCategory>(
          value: e.value,
          child: Row(
            children: [
              Container(
                height: 15,
                width: 15,
                color: e.value.color,
              ),
              const SizedBox(width: 5),
              Text(e.value.title, style: const TextStyle(fontSize: 20)),
            ],
          )))
      .toList();
  @override
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: Text("Category"),
      value: _selectedCategory,
      icon: Icon(Icons.arrow_drop_down),
      items: dropDownList,
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
          ref.read(categoryProvider.notifier).changeCategory(value);
        });
      },
      style: TextStyle(fontSize: 20),
    );
  }
}
