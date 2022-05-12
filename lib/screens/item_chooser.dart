import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sushi/services/database.dart';
import '../components/app_bar_item_chooser.dart';
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
    return WillPopScope(
      onWillPop: () async {
        leaveRoom(groupId);
        await FirebaseAuth.instance.signOut();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppBarItemChooser(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Food(name: item[index]["name"]);
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
