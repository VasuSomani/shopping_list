import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/category_list.dart';
import 'item.dart';

Future<void> postData(Item myItem) async {
  const url =
      "https://shopping-list-8f235-default-rtdb.firebaseio.com/shopping-list.json";
  final uri = Uri.parse(url);
  final body = myItem.toJson();
  final response = await http.post(uri, body: body);
  if (response.statusCode == 200) {
    debugPrint("Post SUCCESS");
  } else {
    debugPrint("Post FAILURE");
  }
}

Future<List<Item>> getData() async {
  const url =
      "https://shopping-list-8f235-default-rtdb.firebaseio.com/shopping-list.json";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    debugPrint("Get SUCCESS");
  } else {
    debugPrint("Get FAILURE");
  }
  final Map<String, dynamic>? dataMap = jsonDecode(response.body);
  if (dataMap == null) {
    return [];
  }
  final List<Item> dataList = [];
  for (final item in dataMap.entries) {
    dataList.add(Item(
        id: item.key,
        name: item.value["name"],
        quantity: item.value["quantity"],
        category: categoriesList.entries
            .firstWhere(
                (element) => element.value.title == item.value["category"])
            .value));
  }
  debugPrint(dataList.toString());
  return dataList;
}

Future<void> deleteData(Item myItem) async {
  final url =
      "https://shopping-list-8f235-default-rtdb.firebaseio.com/shopping-list/${myItem.id}.json/";
  final uri = Uri.parse(url);
  final response = await http.delete(uri);
  if (response.statusCode == 200) {
    debugPrint("Delete SUCCESS");
  } else {
    debugPrint("Delete FAILURE ${response.statusCode}");
  }
}
