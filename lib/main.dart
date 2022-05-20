import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sushi/constant.dart';
import 'package:sushi/screens/home.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sushi Select',
        theme: ThemeData(
          fontFamily: 'nunito',
          brightness: Brightness.light,
          primaryColor: thirdColor,
          shadowColor: Colors.grey.withOpacity(0.2),
          backgroundColor: Colors.white,
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: primaryColorDark,
            shadowColor: Colors.black.withOpacity(0.2)),
        home: home());
  }
}
