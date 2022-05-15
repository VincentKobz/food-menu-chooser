import 'package:flutter/material.dart';
import 'package:sushi/components/button.dart';
import 'package:sushi/screens/create.dart';
import 'package:sushi/screens/join.dart';

Scaffold home() {
  return const Scaffold(
    body: Main(),
  );
}

class Main extends StatelessWidget {
  const Main({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Button(
                disabled: false,
                width: 160,
                height: 50,
                size: 18,
                text: "JOIN",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Join()),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Button(
                disabled: false,
                width: 160,
                height: 50,
                size: 18,
                text: "CREATE",
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Create()),
                ),
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
}
