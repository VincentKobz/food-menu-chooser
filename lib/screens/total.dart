import 'package:flutter/material.dart';
import '../components/app_bar_item_chooser.dart';
import '../components/button.dart';
import '../services/database.dart';

class Total extends StatefulWidget {
  const Total({Key? key, required this.user}) : super(key: key);

  final UserConnect user;

  @override
  State<Total> createState() => _TotalState();
}

class _TotalState extends State<Total> {
  late UserConnect user = widget.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBarItemChooser(user: user),
              const SizedBox(height: 20),
              Button(
                  disabled: false,
                  width: 160,
                  height: 50,
                  size: 18,
                  text: "Back",
                  onPressed: () => Navigator.pop(context)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
