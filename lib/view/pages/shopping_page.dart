import 'package:flutter/material.dart';
import 'package:shopping_list/view/utils/new_item.dart';
import 'package:shopping_list/view/utils/shoppping_tile.dart';

import '../../models/item.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

List<Item> groceryList = [];

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Groceries"),
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () async {
                final Item newItem = await showModalBottomSheet(
                  context: context,
                  builder: (context) => NewItem(),
                );
                setState(() {
                  groceryList.add(newItem);
                });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: (groceryList.isEmpty)
          ? Center(
              child: (const Text(
                "No items to show",
                style: TextStyle(fontSize: 30),
              )),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  background: Container(color: Colors.red),
                  confirmDismiss: (direction) async {
                    bool confirm = false;
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Confirm Delete"),
                          content: Text(
                              'Are you sure want to delete ${groceryList[index].name}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    groceryList.removeWhere((element) =>
                                        element.id == groceryList[index].id);
                                  });
                                  Navigator.pop(context);
                                  confirm = true;
                                },
                                child: Text("Delete"))
                          ],
                        );
                      },
                    );
                    return confirm;
                  },
                  onDismissed: (DismissDirection direction) {},
                  key: ValueKey<String>(groceryList[index].id),
                  child: ShoppingTile(
                      category: groceryList[index].category,
                      title: groceryList[index].name,
                      quantity: groceryList[index].quantity),
                );
              },
              itemCount: groceryList.length,
            ),
    );
  }
}
