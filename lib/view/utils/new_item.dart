import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/models/item.dart';
import 'package:shopping_list/controllers/data_text_field.dart';

import '../../models/provider/state_notifier.dart';

class NewItem extends ConsumerStatefulWidget {
  NewItem({super.key});

  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController quantityController = TextEditingController(text: "1");

  final formKey = GlobalKey<FormState>();

  void _saveItem(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Item newItem = Item(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.toString().trim(),
        quantity: int.parse(quantityController.text.toString()),
        category: ref.read(categoryProvider.notifier).returnCategory(),
      );
      Navigator.of(context).pop(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(children: [
              NameField(nameController),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: QuantityField(quantityController),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CategoryField(),
                  ))
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel")),
                  ElevatedButton(
                    onPressed: () => _saveItem(context),
                    child: Text("Add"),
                  )
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
