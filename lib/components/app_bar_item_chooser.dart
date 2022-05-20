import 'package:flutter/material.dart';
import 'package:sushi/services/database.dart';
import '../constant.dart';

class AppBarItemChooser extends StatefulWidget {
  const AppBarItemChooser({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserConnect user;

  @override
  State<AppBarItemChooser> createState() => _AppBarItemChooserState();
}

class _AppBarItemChooserState extends State<AppBarItemChooser> {
  Future<void> _showMyDialogDelete() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Group deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to delete the group ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                deleteRoom(widget.user);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showMyDialogLeave() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Group leave'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to leave the group ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                for (var i = 0; i < 3; i++) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            offset: const Offset(0, 4),
            color: Colors.grey.withOpacity(0.25),
          )
        ],
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: InkWell(
              child: const Icon(
                Icons.delete_rounded,
                color: thirdColor,
              ),
              onTap: () => _showMyDialogDelete(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Food Chooser",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                widget.user.groupId,
                style: const TextStyle(fontSize: 18, color: thirdColor),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: InkWell(
              onTap: () => _showMyDialogLeave(),
              child: const Icon(
                Icons.exit_to_app_rounded,
                color: thirdColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
