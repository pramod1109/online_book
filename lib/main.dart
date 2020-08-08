import 'package:flutter/material.dart';
import 'package:online_book/screens/intro_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'భావతరంగిణి',
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}