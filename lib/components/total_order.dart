import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sushi/components/app_bar_item_chooser.dart';
import 'package:sushi/components/recap_item.dart';
import 'package:sushi/services/database.dart';

class TotalOrder extends StatefulWidget {
  const TotalOrder({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserConnect user;

  @override
  State<TotalOrder> createState() => _TotalOrderState();
}

class _TotalOrderState extends State<TotalOrder> {
  final List pages = [];
  List<TotalMenuQuantity> totalMenuQuantity = [];

  @override
  void initState() {
    super.initState();
    loadWidget();
  }

  void loadWidget() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final doc = _firestore
        .collection('group')
        .where('groupId', isEqualTo: widget.user.groupId);

    doc.snapshots().listen(
      (event) async {
        totalMenuQuantity = (await getTotalQuantity(widget.user));
        for (var i = 0; i < totalMenuQuantity.length; i++) {
          var item = RecapItem(
              quantity: totalMenuQuantity[i].quantity,
              name: totalMenuQuantity[i].name);
          setState(
            () {
              if (pages.length == totalMenuQuantity.length) {
                pages[i] = item;
              } else {
                pages.add(item);
              }
            },
          );
        }
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarItemChooser(user: widget.user),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(children: [
                ...pages,
              ]),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
