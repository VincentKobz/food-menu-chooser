import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/food_item.dart';

class ItemChooser extends StatefulWidget {
  const ItemChooser({
    Key? key,
  }) : super(key: key);

  @override
  _ItemsGenerator createState() => _ItemsGenerator();
}

class _ItemsGenerator extends State<ItemChooser> {
  List item = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/metadata.json');
    final data = await json.decode(response);
    setState(
      () {
        item = data["menu"];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Item Lists",
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                "5 members",
                style: TextStyle(fontSize: 16),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Food(name: item[index]["name"]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
