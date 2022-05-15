import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sushi/constant.dart';
import '../components/button.dart';
import '../components/text_field.dart';
import '../services/database.dart';

class Join extends StatefulWidget {
  const Join({Key? key}) : super(key: key);

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  TextEditingController nameController = TextEditingController();
  TextEditingController groupController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
    groupController.addListener(() {
      setState(() {});
    });
  }

  void signInAnonymously(String name) {
    _auth.signInAnonymously().then((result) {
      UserConnect user = UserConnect(groupId: groupController.text, name: name);
      joinRoom(groupController.text, name, user, context);
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
              TextFieldCustom(
                type: TextInputType.text,
                nameController: nameController,
                label: "Enter your name",
                icon: const Icon(
                  Icons.person_rounded,
                  color: thirdColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(
                type: TextInputType.number,
                nameController: groupController,
                label: "Enter your group id",
                icon: const Icon(
                  Icons.group_rounded,
                  color: thirdColor,
                ),
              ),
              const SizedBox(height: 30),
              Button(
                disabled:
                    groupController.text.isEmpty || nameController.text.isEmpty,
                width: 160,
                height: 50,
                size: 18,
                text: "CONTINUE",
                onPressed: () => signInAnonymously(nameController.text),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
