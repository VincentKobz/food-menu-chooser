import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sushi/screens/item_chooser.dart';

import '../services/database.dart';
import 'button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _State extends State<SignIn> {
  void signInAnonymously() {
    _auth.signInAnonymously().then((result) {
      DataBase database = DataBase();
      database.createGroup('group1', result.user?.uid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ItemChooser()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      width: 160,
      height: 50,
      size: 18,
      text: "CREATE",
      onPressed: signInAnonymously,
    );
  }
}
