import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sushi/components/food_item.dart';
import 'package:sushi/components/total_order.dart';
import 'package:sushi/components/user_order.dart';
import 'package:sushi/constant.dart';
import 'package:sushi/services/database.dart';

class ItemChooser extends StatefulWidget {
  const ItemChooser({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserConnect user;

  @override
  _ItemsGenerator createState() => _ItemsGenerator();
}

class _ItemsGenerator extends State<ItemChooser> {
  static List item = [];
  int _selectedIndex = 0;
  final List _pages = [];
  final List<Widget> _widgetOptions = <Widget>[Text("data"), Text("data")];

  void loadWidget() {
    for (var i = 0; i < item.length; i++) {
      _pages.add(Food(
        name: item[i]['name'],
        description: item[i]['description'],
        user: widget.user,
        index: i,
      ));
    }

    _widgetOptions[0] = UserOrder(widget: widget, pages: _pages);
    _widgetOptions[1] = TotalOrder(user: widget.user);
  }

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
        loadWidget();
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        leaveRoom(widget.user);
        return true;
      },
      child: Scaffold(
        body: IndexedStack(
          children: [
            _widgetOptions[0],
            _widgetOptions[1],
          ],
          index: _selectedIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 17,
          unselectedFontSize: 15,
          iconSize: 30,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_rounded),
              label: 'Total Order',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: thirdColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
