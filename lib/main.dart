import 'package:apitutorial/First_Screen.dart';
import 'package:apitutorial/ImageScreen.dart';
import 'package:apitutorial/Login_Screen.dart';
import 'package:apitutorial/Second_Screen.dart';
import 'package:apitutorial/homescreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondScreen(),
    );
  }
}
