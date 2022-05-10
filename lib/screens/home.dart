import 'package:flutter/material.dart';
import 'package:sushi/components/button.dart';

SafeArea home() {
  return SafeArea(
    child: Center(
      child: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text("SUSHI SELECT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                )),
            const Text("sushi spot",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                )),
            const Spacer(flex: 4),
            Image.asset(
              "assets/illustrations/sushi.png",
              height: 151,
              width: 300,
            ),
            const Spacer(flex: 3),
            const button(
              width: 160,
              height: 50,
              size: 18,
              text: "JOIN",
            ),
            const SizedBox(
              height: 20,
            ),
            const button(
              width: 160,
              height: 50,
              size: 18,
              text: "CREATE",
            ),
            const Spacer(
              flex: 1,
            )
          ],
        ),
      ),
    ),
  );
}
