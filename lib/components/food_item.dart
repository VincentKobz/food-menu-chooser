import 'package:flutter/material.dart';

class Food extends StatelessWidget {
  const Food({
    Key? key,
    required this.name,
  }) : super(key: key);

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          const Text(
            "0",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.remove_circle_outline_rounded),
              iconSize: 30),
          IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.add_circle_outline_rounded),
              iconSize: 30),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
