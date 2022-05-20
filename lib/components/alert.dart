import 'package:flutter/material.dart';

showAlertDialogGroupID(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK, sorry"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alertWrongGroupID = AlertDialog(
    title: const Text("Wrong group ID"),
    content: const Text("There is no group with this ID, try another one."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertWrongGroupID;
    },
  );
}

showAlertDialogDuplicateUser(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK, sorry"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alertWrongGroupID = AlertDialog(
    title: const Text("Username already taken"),
    content: const Text("Same username already exists in this group."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertWrongGroupID;
    },
  );
}
