import 'package:flutter/material.dart';
import 'package:sushi/constant.dart';
import 'package:sushi/services/database.dart';

class Food extends StatefulWidget {
  const Food({
    Key? key,
    required this.name,
    required this.index,
    required this.user,
    required this.description,
  }) : super(key: key);

  final String name;
  final int index;
  final String description;
  final UserConnect user;

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> with AutomaticKeepAliveClientMixin {
  int quantity = 0;
  var enabled = false;

  void changeText(int value) {
    setState(
      () {
        quantity += value;

        if (quantity == 0) {
          enabled = false;
        } else {
          enabled = true;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            widget.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 0.4 * MediaQuery.of(context).size.width,
            child: Text(
              widget.description,
              overflow: TextOverflow.visible,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 15,
          ),
          IconButton(
              splashColor: Colors.transparent,
              onPressed: enabled
                  ? () {
                      print("1");
                      updateMenuQuantity(widget.user, -1, widget.index);
                      if (quantity > 0) changeText(-1);
                      print("2");
                    }
                  : null,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.remove_circle_outline_rounded,
                color: enabled ? Theme.of(context).primaryColor : Colors.grey,
              ),
              iconSize: 30),
          const SizedBox(
            width: 5,
          ),
          IconButton(
              splashColor: Colors.transparent,
              onPressed: () {
                updateMenuQuantity(widget.user, 1, widget.index);
                changeText(1);
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.add_circle_outline_rounded,
                color: Theme.of(context).primaryColor,
              ),
              iconSize: 30),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
