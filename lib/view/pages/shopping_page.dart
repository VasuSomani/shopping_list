import 'package:flutter/material.dart';
import 'package:shopping_list/models/http_requests.dart';
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
  bool _isLoading = false;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    _isLoading = true;
    await getData().then((data) {
      setState(() {
        _isLoading = false;
        groceryList = data;
      });
    });
  }

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
                      context: context, builder: (context) => NewItem());
                  await postData(newItem);
                  setState(() {
                    groceryList.add(newItem);
                  });
                  setState(() {});
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ))
          ],
        ),
        body: (_isLoading)
            ? const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (CircularProgressIndicator(
                    color: Colors.white,
                  )),
                  SizedBox(height: 30),
                  Text(
                    "Fetching your data ...",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ))
            : ((groceryList.isEmpty)
                ? const Center(
                    child: (Text(
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
                                title: const Text("Confirm Delete"),
                                content: Text(
                                    'Are you sure want to delete ${groceryList[index].name}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          debugPrint(groceryList[index].id);
                                          deleteData(groceryList[index]);
                                        });
                                        Navigator.pop(context);
                                        confirm = true;
                                      },
                                      child: const Text("Delete"))
                                ],
                              );
                            },
                          );
                          return confirm;
                        },
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            groceryList.removeAt(index);
                          });
                        },
                        key: ValueKey<String>(groceryList[index].id),
                        child: ShoppingTile(
                            category: groceryList[index].category,
                            title: groceryList[index].name,
                            quantity: groceryList[index].quantity),
                      );
                    },
                    itemCount: groceryList.length,
                  )));
  }
}
