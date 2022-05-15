import 'package:flutter/material.dart';

class RecapItem extends StatelessWidget {
  const RecapItem({
    Key? key,
    required this.quantity,
    required this.name,
  }) : super(key: key);

  final int quantity;
  final String name;

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
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
