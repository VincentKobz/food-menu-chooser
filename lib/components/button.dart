import 'package:flutter/material.dart';
import '../constant.dart';

class button extends StatelessWidget {
  const button(
      {Key? key,
      required this.text,
      required this.width,
      required this.height,
      required this.size})
      : super(key: key);

  final String text;
  final double width;
  final double height;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: height / 2),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: secondaryColor,
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
