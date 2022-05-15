import 'package:flutter/material.dart';
import 'package:sushi/constant.dart';
import 'package:sushi/services/database.dart';

class Food extends StatefulWidget {
  const Food({
    Key? key,
    required this.name,
    required this.index,
    required this.user,
  }) : super(key: key);

  final String name;
  final int index;
  final UserConnect user;

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> with AutomaticKeepAliveClientMixin {
  int quantity = 0;
  var enabled = false;

  void changeText(int value) {
    setState(() {
      quantity += value;

      if (quantity == 0) {
        enabled = false;
      } else {
        enabled = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
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
            style: const TextStyle(fontSize: 20),
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
              onPressed: enabled
                  ? () {
                      updateMenuQuantity(widget.user, -1, widget.index);
                      if (quantity > 0) changeText(-1);
                    }
                  : null,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.remove_circle_outline_rounded,
                color: enabled ? thirdColor : Colors.grey,
              ),
              iconSize: 30),
          const SizedBox(
            width: 5,
          ),
          IconButton(
              onPressed: () {
                updateMenuQuantity(widget.user, 1, widget.index);
                changeText(1);
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: thirdColor,
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
