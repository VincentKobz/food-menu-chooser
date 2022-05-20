import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  const TextFieldCustom({
    Key? key,
    required this.nameController,
    required this.label,
    required this.icon,
    required this.type,
  }) : super(key: key);

  final TextEditingController nameController;
  final String label;
  final Icon icon;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        keyboardType: type,
        controller: nameController,
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: icon,
          ),
          hintText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
