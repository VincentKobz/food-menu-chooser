import 'package:flutter/material.dart';
import '../constant.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.text,
      required this.width,
      required this.height,
      required this.size,
      required this.onPressed,
      required this.disabled})
      : super(key: key);

  final String text;
  final double width;
  final double height;
  final double size;
  final bool disabled;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: height / 2),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: !disabled ? Theme.of(context).primaryColor : Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: size),
            )
          ],
        ),
      ),
    );
  }
}
