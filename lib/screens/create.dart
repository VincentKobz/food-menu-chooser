import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sushi/constant.dart';
import '../components/button.dart';
import '../services/database.dart';
import 'menu_chooser.dart';

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController nameController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
  }

  int generateNumber() {
    Random random = Random();
    int r = 100000 + random.nextInt(999999 - 100000);
    return r;
  }

  void signInAnonymously(String name) {
    _auth.signInAnonymously().then((result) {
      int groupId = generateNumber();
      UserConnect user = UserConnect(groupId: groupId.toString(), name: name);

      createGroup(groupId.toString(), name);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ItemChooser(user: user)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "SUSHI SELECT",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const Text(
                "sushi spot",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Spacer(flex: 1),
              Container(
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
                  controller: nameController,
                  decoration: InputDecoration(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Icon(Icons.person,
                          color: Theme.of(context).primaryColor),
                    ),
                    hintText: "Enter your name",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Button(
                disabled: nameController.text.isEmpty,
                width: 160,
                height: 50,
                size: 18,
                text: "CONTINUE",
                onPressed: !nameController.text.isNotEmpty
                    ? null
                    : () => signInAnonymously(nameController.text),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
