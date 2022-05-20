import 'package:flutter/material.dart';
import 'package:sushi/components/app_bar_item_chooser.dart';
import 'package:sushi/screens/item_chooser.dart';

class UserOrder extends StatefulWidget {
  const UserOrder({
    Key? key,
    required this.widget,
    required List pages,
  })  : _pages = pages,
        super(key: key);

  final ItemChooser widget;
  final List _pages;

  @override
  State<UserOrder> createState() => _UserOrderState();
}

class _UserOrderState extends State<UserOrder> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBarItemChooser(user: widget.widget.user),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(children: [
                ...widget._pages,
              ]),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
