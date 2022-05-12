import 'package:flutter/material.dart';
import '../constant.dart';

class AppBarItemChooser extends StatelessWidget {
  const AppBarItemChooser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 4),
            color: Colors.grey.withOpacity(0.25),
          )
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Icon(Icons.exit_to_app, color: thirdColor),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Item Lists",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "5 members",
                style: TextStyle(fontSize: 16, color: thirdColor),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25),
            child: Icon(
              Icons.info_outline_rounded,
              color: thirdColor,
            ),
          ),
        ],
      ),
    );
  }
}
